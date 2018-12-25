From: Hans de Goede <hdegoede@redhat.com>
Subject: "ALSA: HD-Audio: SKL+: abort probe if DSP is present
 and Skylake driver selected" breaks sound, suspend on Apollo Lake
Date: Tue, 25 Dec 2018 14:10:03 +0100
Message-ID: <c2d25194-a779-aec0-59e8-a4d90326c811@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 96BF0267960
 for <alsa-devel@alsa-project.org>; Tue, 25 Dec 2018 14:10:05 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id f23so11658999edb.3
 for <alsa-devel@alsa-project.org>; Tue, 25 Dec 2018 05:10:05 -0800 (PST)
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre-Louis,

Since I recently have been doing a bunch of i915 work I'm currently
running drm-tip. This brought in this commit from next:

https://cgit.freedesktop.org/drm-tip/commit/?id=c337104b1a16becc486fdc95d544c835b17021db

This causes the hda driver to not bind to the audio on my Apollo Lake
based laptop, and the asoc driver errors out with:

[   19.176417] skl_hda_dsp_generic skl_hda_dsp_generic: Unsupported HDAudio/iDisp configuration found
[   19.176428] skl_hda_dsp_generic: probe of skl_hda_dsp_generic failed with error -22

After which I get no sound and worse, the machine hangs on suspend.
It seems to never reach its fully suspended state (the power-led
never starts to fade on/off as it normally does when suspended).

I've been looking through the Kconfig option and it seems that
currently selecting SND_SOC_INTEL_APL makes little sense since there
are 0 machine drivers for this setup ?

I guess I can fix this by unselecting SND_SOC_INTEL_SKYLAKE and
then during the manual platform selection not selecting
SND_SOC_INTEL_APL, but IMHO we need to put something in place
where the hda driver actually checks if there is a machine driver
and if there isn't one then we should keep using the hda driver
on the machine in question.

Regards,

Hans


p.s.

Merry Christmas!
