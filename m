From: "Murphy, Dan" <dmurphy@ti.com>
Subject: Re: [PATCH 1/2] ASoC: tas2552: Fix PM sequencing
Date: Mon, 21 Jul 2014 13:23:17 +0000
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49D88593@DFLE09.ent.ti.com>
References: <1405704668-8038-1-git-send-email-dmurphy@ti.com>
 <20140721121931.GX17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark

On 07/21/2014 07:19 AM, Mark Brown wrote:
> On Fri, Jul 18, 2014 at 12:31:07PM -0500, Dan Murphy wrote:
>> In the pm suspend/resume it is better
>> to disable the GPIO after the regmap_cache
>> setting calls so that if the call is interrupted
>> the new reg values will be cached and set on resume.
>>
>> Also add pm_runtime_put in the remove call.
> Applied, thanks, but please don't mix multiple changes into one commit
> like this especially when there's no textual overlap.

I usually don't mix changes like this as I like to have a single change per
commit.

But I find each maintainer is a little different but now I know for next time.

Thanks

-- 
------------------
Dan Murphy

