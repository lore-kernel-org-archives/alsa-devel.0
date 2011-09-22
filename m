From: Leo Yan <leoy@marvell.com>
Subject: Re: Questions for dummy codec driver
Date: Thu, 22 Sep 2011 09:42:14 +0800
Message-ID: <4E7A9276.803@marvell.com>
References: <1316502540.4269.1.camel@phoenix> <4E794A96.9040206@marvell.com> <20110921125607.GC25620@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110921125607.GC25620@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 09/21/2011 08:56 PM, Mark Brown wrote:
> On Wed, Sep 21, 2011 at 10:23:18AM +0800, Leo Yan wrote:
>
>> I have a question for the dummy codec.
>
> Don't start new threads by randomly replying to unrelated mails.
>

Sorry for that :-), the alsa-devel is the unrelated mailing list, right?
if so, i will note for that later.

>> As you know, sometimes maybe we only need set the timing from the
>> processor, and codec just only need tx/rx data; So there do not need
>> the codec driver.
>
> Even a dumb CODEC will have some constraints on things like the sample
> rates it can support which need to be conveyed to the framework and
> ideally the audio routing out of the CODEC should be visible for
> integration with any external output drivers or similar.
>

Get it.

On our platform, there have some devices (like hdmi/bt) do not need 
config from the CODEC driver, they have their own s/w stack and 
interface to configure; for the audio driver, just need to set the 
I2S/PCM timing for them. So if there have a common dummy codec driver, 
then it can meet our requirement well. Otherwise, there will have some 
duplicate codes for these dummy codecs.

>> After browser the code, there have NO such a dummy codec driver; and
>> for soc-core, there have not such flags to support this situation.
>> Only what i get is sound/soc/codecs/spdif_transciever.c, but it's
>> specific for TI's DaVinci platform.
>
> Not at all, what makes you believe that it is platform specific?
