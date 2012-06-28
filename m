From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] ASoC: snd_dmaengine: add common api for pcm_mmap
Date: Thu, 28 Jun 2012 17:37:27 +0530
Message-ID: <4FEC48FF.9040408@nvidia.com>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com> <20120628105148.GD28922@opensource.wolfsonmicro.com> <4FEC468A.3080607@nvidia.com> <20120628120245.GF28922@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120628120245.GF28922@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lrg@ti.com" <lrg@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 28 June 2012 05:32 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Thu, Jun 28, 2012 at 05:26:58PM +0530, Laxman Dewangan wrote:
>
>> Other driver which can use this API are davinci, OMAP, samsung but
>> because they are not using the snd_dmaengine_pcm driver's api as of
>> now so not be very much useful for them.
> There's no reason why we can't factor out more common code - this is
> essentially what Lars-Peter was saying.
>

Ok, then let me start on this.

>> Should I send one patch per driver change or squash all 4 file
>> changes in one patch? Whatever will be easy or recommended?
> It doesn't really matter that much, but please take on board
> Lars-Peter's comments.

Ok then I will go for one patch per file.
I will send the patches in series.
