From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 00/20] ALSA: Drop superfluous PCM
 preallocation error checks
Date: Wed, 6 Feb 2019 10:07:21 +0100
Message-ID: <697e40c0-d0ea-9e50-277e-bba82945c46b@perex.cz>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C212673DD
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 10:07:25 +0100 (CET)
In-Reply-To: <20190205194221.25924-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Dne 5.2.2019 v 20:42 Takashi Iwai napsal(a):
> Hi,
> 
> this is yet another patchset for trivial cleanups.
> At this time, it's about the superfluous error check from
> snd_pcm_lib_preallocate_pages() and co.  They always succeed and never
> return a failure although many codes do the error check.  The patches
> simply remove the error checks and finally change the function to be
> void function.
> 
> The patches are applied on top of my previous NULL device fix patches,
> so not applicable to ASoC tree, I guess.  As all these are trivial,
> applying through my tree altogether would be simpler.
> 
> So, Mark, please give your ACK if the changes to ASoC drivers are OK.

With all respects, do we really need to split those elementary changes
to single patches inside the sound tree? I would really prefer to have
this inside one patch or maybe few patches (core/pci/asoc/others). Just
my two cents.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
