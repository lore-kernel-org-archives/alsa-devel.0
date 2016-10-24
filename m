From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RFC PATCH 1/2] ASoC: core: Print one-time messages if missing
 resources when binding DAIs
Date: Mon, 24 Oct 2016 15:39:00 -0300
Message-ID: <31474093-6389-629a-73f0-d60cc8d15d3c@osg.samsung.com>
References: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
 <1476897666-13974-2-git-send-email-javier@osg.samsung.com>
 <20161024172121.GF17252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024172121.GF17252@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 10/24/2016 02:21 PM, Mark Brown wrote:
> On Wed, Oct 19, 2016 at 02:21:05PM -0300, Javier Martinez Canillas wrote:
>> If snd_soc_find_dai() doesn't find a DAI in soc_bind_dai_link(), a
>> error message is printed and an -EPROBE_DEFER errno code returned to
>> the caller.
> 
>> But since many probe retries can happen before a resource is available,
>> the printed messages can spam the kernel log buffer and slow the boot.
> 
>> The information is useful to know that a dependency was not meet and a
>> defer happened, but isn't necessary to print it on each probe deferral.
> 
> This then turns any subsequent failure into a silent one which isn't
> great for diagnostics.  It'd be better to look into trying to avoid the
> retries in the first place, Raphael's dependency graph stuff looks very
> promising here.
>

Ok, thanks for your feedback. I'll also investigate why the number of
probes/retries increased that much from v4.8.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
