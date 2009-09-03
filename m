From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 2/3] ASoC: DaVinci: pcm,
 rename variables in prep for ping/pong
Date: Thu, 03 Sep 2009 11:55:57 -0700
Message-ID: <4AA0113D.9030605@boundarydevices.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>	<20090902220152.GB4495@sirena.org.uk>
	<4A9F0A8C.1040509@boundarydevices.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD6102A3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth03.csee.onr.siteprotect.com
	(smtpauth03.csee.onr.siteprotect.com [64.26.60.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B96A103823
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 20:56:05 +0200 (CEST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6102A3@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Nori, Sekhar wrote:
> On Thu, Sep 03, 2009 at 05:45:08, Troy Kisky wrote:
>> Mark Brown wrote:
>>> On Mon, Aug 31, 2009 at 04:31:44PM -0700, Troy Kisky wrote:
> [...]
>>> I'll probably also apply the first patch since nobody else seems to care
>>> one way or another, but I would urge you to look at changing the default
>>> for the platform data to at most select the workaround only on CPUs that
>>> have problems with channel swapping - it's going to cause confusion for
>>> people to have it on by default.
>>>
>> I think the ones without a problem use davinci-mcasp instead of davinci-i2s
>> but share davinci-pcm. So, I don't know of any machines to exclude in davinci-i2s.
>> But if someone else knows, speak up.
>>
> 
> In my experience too, the channel swap issues got reported only with ASP
> (aka McBSP) and not with McASP.
> 
> The swap was almost always at the start of playback, and supposedly because
> of the errata "2.1.5 ASP: Initialization Procedure When External Device is
> Frame-Sync Master" in http://focus.ti.com/lit/er/sprz241l/sprz241l.pdf


This should have been fixed when I added

davinci_i2s_prepare because it will call davinci_mcbsp_start if the codec
is master, giving plenty of time for the first dma to be serviced.

So, all that ugly code in davinci_mcbsp_start to
"/* wait for any unexpected frame sync error to occur */"
can probably be removed. But since I didn't know the
reason for it, I haven't tried. If you can give this a try
I'd like to know the results.


> 
> Using EDMA acount=4 instead of 2 (32-bit transfers) did fix that issue on the
> OSS drivers but I don't recall the problem morphing into an "always channel
> swapped" case.
> 
> Have you tested your patch (1/3) with DM644x EVM? If not, we can do that and
> see if it leads to channels being always swapped on that hardware as well.

Yes, I have tested with dm644x, not evm. I haven't tried to hear the channel swap,
but I have no doubt that it is.

> 
> One feedback we have received on this solution is that it does not work for
> 24-bit audio. In which case, implementing the workaround described in the
> errata is the only way around.

Yes, you cannot shift more than 32 bits at once, so 48 bits is out.
Although 24 bit format would be easy to add, currently only 8, 16, and 32
are supported by davinci-i2s.

> 
> Thanks,
> Sekhar
> 
> 
