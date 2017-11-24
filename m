From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 11/13] slimbus: qcom: Add Qualcomm Slimbus controller
 driver
Date: Fri, 24 Nov 2017 14:40:10 +0000
Message-ID: <7200d3c4-79c8-b461-9883-182a1c8b4476@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-12-srinivas.kandagatla@linaro.org>
 <20171123100703.gqwcdm7qij63cuwz@localhost.localdomain>
 <20171123164212.655yliz3tmlpsjje@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171123164212.655yliz3tmlpsjje@latitude>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

Thanks for your review,

On 23/11/17 16:42, Jonathan Neuschäfer wrote:
> Hello Srinivas and Charles,
> 
> On Thu, Nov 23, 2017 at 10:07:03AM +0000, Charles Keepax wrote:
>> On Wed, Nov 15, 2017 at 02:10:41PM +0000, srinivas.kandagatla@linaro.org wrote:
>>> From: Sagar Dharia <sdharia@codeaurora.org>
>>>
>>> This controller driver programs manager, interface, and framer
>>> devices for Qualcomm's slimbus HW block.
>>> Manager component currently implements logical address setting,
>>> and messaging interface.
>>> Interface device reports bus synchronization information, and framer
>>> device clocks the bus from the time it's woken up, until clock-pause
>>> is executed by the manager device.
>>>
>>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
> [...]
>>> +static void qcom_slim_rxwq(struct work_struct *work)
>>> +{
>>> +	u8 buf[SLIM_MSGQ_BUF_LEN];
>>> +	u8 mc, mt, len;
>>> +	int i, ret;
>>> +	struct qcom_slim_ctrl *ctrl = container_of(work, struct qcom_slim_ctrl,
>>> +						 wd);
>>> +
>>> +	while ((slim_get_current_rxbuf(ctrl, buf)) != -ENODATA) {
>>> +		len = SLIM_HEADER_GET_RL(buf[0]);
>>> +		mt = SLIM_HEADER_GET_MT(buf[0]);
>>> +		mc = SLIM_HEADER_GET_MC(buf[1]);
>>> +		if (mt == SLIM_MSG_MT_CORE &&
>>> +			mc == SLIM_MSG_MC_REPORT_PRESENT) {
>>> +			u8 laddr;
>>> +			struct slim_eaddr ea;
>>> +			u8 e_addr[6];
>>> +
>>> +			for (i = 0; i < 6; i++)
>>> +				e_addr[i] = buf[7-i];
>>> +
>>> +			ea.manf_id = (u16)(e_addr[5] << 8) | e_addr[4];
>>> +			ea.prod_code = (u16)(e_addr[3] << 8) | e_addr[2];
>>> +			ea.dev_index = e_addr[1];
>>> +			ea.instance = e_addr[0];
>>
>> If we are just bitshifting this out of the bytes does it really
>> make it much more clear to reverse the byte order first? Feels
>> like you might as well shift it out of buf directly.
> 
> In any case, there is a predefined function to make this code a little
> nicer in <asm/byteorder.h>:
> 
> 	le16_to_cpu(x):  Converts the 16-bit little endian value x to
> 	                 CPU-endian
> 	le16_to_cpup(p): Converts the 16-bit little endian value pointed
> 	                 to by p to CPU-endian
> 
> If you use le16_to_cpup, you need to cast your pointer to __le16 *:
> 
> 	ea.manf_id = le16_to_cpup((__le16 *)&e_addr[4]);
> 
It Looks like I can make use of these apis here, I will give this a go 
to cleanup this part of the code.

thanks,
srini
