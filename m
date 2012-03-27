From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 2/8] sound:asoc: Add support for synopsys
 i2s controller as per ASoC framework.
Date: Tue, 27 Mar 2012 09:21:12 +0530
Message-ID: <4F713930.2090900@st.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<7692a51789abe38e7066a582d8329dc93b8eced3.1332242166.git.rajeev-dlh.kumar@st.com>
	<20120320154420.GE3445@opensource.wolfsonmicro.com>
	<4F7030DA.2090009@st.com>
	<20120326111055.GM3098@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog102.obsmtp.com (eu1sys200aog102.obsmtp.com
	[207.126.144.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AAC3104139
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 05:50:41 +0200 (CEST)
In-Reply-To: <20120326111055.GM3098@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, spear-devel <spear-devel@list.st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 3/26/2012 4:40 PM, Mark Brown wrote:
> On Mon, Mar 26, 2012 at 02:33:22PM +0530, Rajeev kumar wrote:
>> On 3/20/2012 9:14 PM, Mark Brown wrote:
>>> On Tue, Mar 20, 2012 at 05:03:46PM +0530, Rajeev Kumar wrote:
>
>>>> +		if (dev->i2s_clk_cfg(config)) {
>>>> +			dev_err(dev->dev, "runtime audio clk config fail\n");
>>>> +			if (cpu_dai->driver->ops->trigger) {
>>>> +				int ret =
>>>> +					cpu_dai->driver->ops->trigger(substream,
>>>> +							SNDRV_PCM_TRIGGER_STOP,
>>>> +							cpu_dai);
>>>> +				if (ret<   0) {
>>>> +					dev_err(dev->dev,
>>>> +							"trigger stop fail\n");
>>>> +					return ret;
>>>> +				}
>>>> +			}
>
>>> No, return an error if you encounter an error!
>
>> You need not to stop controller in case clock fail ?
>
> Let the upper layers worry about that.  Don't randomly change the state
> of the controller without them knowing about it.
>

Ok

Best Regards
Rajeev
