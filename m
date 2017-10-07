From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 6/7] regmap: add SLIMBUS support
Date: Sat, 7 Oct 2017 11:25:22 +0100
Message-ID: <d37242b1-dace-15d2-e758-1f242dadfa09@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-7-srinivas.kandagatla@linaro.org>
 <20171007050242.4smp3x2rqkwxvg5h@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171007050242.4smp3x2rqkwxvg5h@latitude>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

Thanks for the review comments,

On 07/10/17 06:02, Jonathan Neuschäfer wrote:
> Hi,
> 
> On Fri, Oct 06, 2017 at 05:51:35PM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to read/write slimbus value elements.
>> Currently it only supports byte read/write. Adding this support in
>> regmap would give codec drivers more flexibility when there are more
>> than 2 control interfaces like slimbus, i2c.
>>
>> Without this patch each codec driver has to directly call slimbus value
>> element apis, and this could would get messy once we want to add i2c
>> interface to it.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
> [...]
>> +static int regmap_slimbus_byte_reg_read(void *context, unsigned int reg,
>> +					unsigned int *val)
>> +{
>> +	struct slim_device *slim = context;
>> +	struct slim_val_inf msg = {0,};
>> +
>> +	msg.start_offset = reg;
>> +	msg.num_bytes = 1;
>> +	msg.rbuf = (void *)val;
>> +
>> +	return slim_request_val_element(slim, &msg);
>> +}
> 
> This looks like it won't work on big-endian systems. I know big endian
> is pretty uncommon in devices that will likely have SLIMBus, but it's
> better to be endian-independent.

Yep, I agree! will fix it in next version.

> 
>> +static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
>> +					 unsigned int val)
>> +{
>> +	struct slim_device *slim = context;
>> +	struct slim_val_inf msg = {0,};
>> +
>> +	msg.start_offset = reg;
>> +	msg.num_bytes = 1;
>> +	msg.wbuf = (void *)&val;
>> +
>> +	return slim_change_val_element(slim, &msg);
>> +}
> 
> dito
> 
>> +static struct regmap_bus regmap_slimbus_bus = {
>> +	.reg_write = regmap_slimbus_byte_reg_write,
>> +	.reg_read = regmap_slimbus_byte_reg_read,
>> +};
> 
> 
> Thanks,
> Jonathan Neuschäfer
> 
