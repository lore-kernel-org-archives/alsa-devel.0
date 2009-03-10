From: Viral Mehta <viral.mehta@einfochips.com>
Subject: [PATCH] [SOUND] Fixes recording gain control
Date: Tue, 10 Mar 2009 18:31:56 +0530
Message-ID: <49B664C4.2080804@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahmedabad.einfochips.com (india.einfochips.com [203.88.139.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EE011037EB
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 14:10:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Have tested two usb audio mic devices.
At the time of initialization, SNDRV_MIXER_OSS_PRESENT_PVOLUME bit is not
set for MIC (slot 7).
So, the same should not be checked when an application tries to do gain 
control
for audio recording devices. Just check
slot->present for SNDRV_MIXER_OSS_PRESENT_CVOLUME independently.
Verified with a simple application which opens /dev/dsp for recording and
/dev/mixer for volume control.

Signed-off-by: Viral Mehta <viral.mehta@einfochips.com>
---
 sound/core/oss/mixer_oss.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 4690b8b..919c7eb 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -690,7 +690,7 @@ static int snd_mixer_oss_put_volume1(struct 
snd_mixer_oss_file *fmixer,

        if (slot->present & SNDRV_MIXER_OSS_PRESENT_PVOLUME) {
                snd_mixer_oss_put_volume1_vol(fmixer, pslot, 
slot->numid[SNDRV_MIXER_OSS_ITEM_PVOLUME], left, right);
-               if (slot->present & SNDRV_MIXER_OSS_PRESENT_CVOLUME)
+       } else if (slot->present & SNDRV_MIXER_OSS_PRESENT_CVOLUME) {
                        snd_mixer_oss_put_volume1_vol(fmixer, pslot, 
slot->numid[SNDRV_MIXER_OSS_ITEM_CVOLUME], left, right);
        } else if (slot->present & SNDRV_MIXER_OSS_PRESENT_GVOLUME) {
                snd_mixer_oss_put_volume1_vol(fmixer, pslot, 
slot->numid[SNDRV_MIXER_OSS_ITEM_GVOLUME], left, right);
--
1.6.0.2.GIT

-- 
_____________________________________________________________________
Disclaimer: This e-mail message and all attachments transmitted with it
are intended solely for the use of the addressee and may contain legally
privileged and confidential information. If the reader of this message
is not the intended recipient, or an employee or agent responsible for
delivering this message to the intended recipient, you are hereby
notified that any dissemination, distribution, copying, or other use of
this message or its attachments is strictly prohibited. If you have
received this message in error, please notify the sender immediately by
replying to this message and please delete it from your computer. Any
views expressed in this message are those of the individual sender
unless otherwise stated.Company has taken enough precautions to prevent
the spread of viruses. However the company accepts no liability for any
damage caused by any virus transmitted by this email.
__________________________________________________________________________
