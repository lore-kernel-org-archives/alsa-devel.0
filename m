From: Hans de Goede <hdegoede@redhat.com>
Subject: ASoC: rt5640,
 rt5651 jack-detect and BYT SST suspend/resume patches / status
 update
Date: Sun, 11 Feb 2018 13:00:59 +0100
Message-ID: <98d557fa-0c5d-0955-0987-0b5dc6764282@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 5741D266C0E
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 13:01:02 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id g1so4917046wmg.2
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 04:01:02 -0800 (PST)
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
To: Carlo Caione <carlo@endlessm.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi Pierre-Louis, Carlo, et al,

This mail is mostly just FYI, I've been doing a lot of work
on $subject lately and the purpose of this mail is to avoid
people doing double work.

As Pierre-Louis knows already, I've been working on adding
support for rt5640 jack-detect, this is harder then it should
be really, since the micbias overcurrent detect on the rt5640
seems to be very finicky if I don't enable things in exactly
the right order its gets in some sort of "unhappy" state
where it still works but only sometimes / it is unreliable.
This "unhappy" state looks exactly the same as normal working
state from a reg-dump pov.

So I've jack-detect including headphones vs headset detect
working reliable now, after a reboot, but it becomes wonky
again after a suspend/resume.

Which let me deeper into the rabbit hole. Suspend/resume
while streams are active / allocated in the SST-DSP is broken
on Bay Trail. I've written a fix for this and I can now suspend/
resume BYT devices while audio is playing over the speakers
and the audio properly resumes playing properly. Also these
related errors are gone now:

intel_sst_acpi 80860F28:00: FW sent error response 0x4000e
intel_sst_acpi 80860F28:00: FW sent error response 0x4000f

I've added a quirk to the SST driver for this and I was wondering
if I needed this at the platform (byt) level or at the machine-driver
(so platform+codec combo) level. I've a Ployer momo7w tablet which
uses the bytcr-rt5651 machine-driver, so I started testing with that.

So the bytcr-rt5651 machine-driver despite its name does not
actually work with bytcr devices, which only have SSP0 available,
so I fixed that, then had some issues with the jack-detection
Carlo recently added, so I've done a bunch of fixes for those
too.

I also have some UCM fixes for bytcr-rt5651 + SSP0, I will
send a pull-req to Pierre-Louis' UCM github repo for those
when I get around to it.

The kernel patches for all this can be found here:

https://github.com/jwrdegoede/linux-sunxi/commits/master

Noe this is somewhat in a state of flux, e.g. the BYT SST
suspend/resume fixes are good, but currently only enabled on
the bytcr-rt5640 combo, testing has shown I need them on
the ployer too, but I still need to rework the quirk
handling to move the quirk to the  sst_platform_info struct.
Also this needs to be rebased on top of 4.16-rc1, I know
there will be some minor conflicts in the rt5651 code.

Note the rt5651 jack change to fix headset vs headphone
detection does not work yet, now it sees everything as
headphones ...

I probably won't have much time to continue work on this
today and as said the main purpose of this mail is to get
you aware of these patches to avoid double work. I hope to
be able to rebase on top of 4.16-rc1, and do an upstream
submission of everything except for the rt5640 jack-detect
code sometime the next week.

Regards,

Hans

p.s.

Carlo or Pierre-Louis can one of you check using e.g.
the left + right speaker test in gnome-control-panel's
sound config-applet if that left only goes to the left
speaker and right only goes to the right speaker?

My bytcr-rt5651 tablet has only one speaker, but I
here sound for both the left and right speaker tests
which suggests some right-to-left mixing is happening
which we don't want on devices with stereo speakers.
Could be there is some mixing happening outside of the
codec on this tablet, still it would be good to test
this.
