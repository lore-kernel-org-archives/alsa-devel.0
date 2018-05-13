From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 00/10] ASoC: rt5640: Add jack-detect and
 button-press support
Date: Sun, 13 May 2018 06:48:21 +0200
Message-ID: <87c76437-459c-0c24-f629-d296bb18fec1@redhat.com>
References: <20180511132928.7669-1-hdegoede@redhat.com>
 <20180513022956.GB17611@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id DC6F3266F88
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 06:48:23 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id a137-v6so7511474wme.1
 for <alsa-devel@alsa-project.org>; Sat, 12 May 2018 21:48:23 -0700 (PDT)
In-Reply-To: <20180513022956.GB17611@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 05/13/2018 04:29 AM, Mark Brown wrote:
> On Fri, May 11, 2018 at 03:29:18PM +0200, Hans de Goede wrote:
>> Hi Mark, et. al.,
>>
>> Here is v2 of the remaining patches from my rt5640 jack-detect series.
>>
>> As requested this is rebased on your sound/for-next branch, so this should
>> apply cleanly now.
> 
> That's not what git is telling me:
> 
> Applying: ASoC: Intel: bytcr_rt5640: Use device properties for setting up dmic
> error: patch failed: sound/soc/intel/boards/bytcr_rt5640.c:556
> error: sound/soc/intel/boards/bytcr_rt5640.c: patch does not apply
> Patch failed at 0001 ASoC: Intel: bytcr_rt5640: Use device properties for setting up dmic
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> If I try with -3 it tells me that it doesn't even know the SHA1s which
> suggests you have something else in your tree?

Yes, I still have the "ASoC: Intel: bytcr_rt5640: Drop unwanted ignore_suspend settings"
patch, for which we never really finished the discussion.

I will drop that for now and send a v3 which should apply cleanly, sorry about this.

As for the ignore_suspend patch I will run some tests to make sure that things
work ok without it and then just drop it permanently.

Regards,

Hans
