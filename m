From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 0/3] ALSA: hda/ca0132 - Better handle a failed
	DSP firmware load.
Date: Thu, 14 Mar 2013 17:27:43 -0700
Message-ID: <1363307266-30055-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f202.google.com (mail-ye0-f202.google.com
 [209.85.213.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AC9C261618
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 01:27:56 +0100 (CET)
Received: by mail-ye0-f202.google.com with SMTP id q5so291492yen.5
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 17:27:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, chee_kin@ctl.creative.com, ian_minett@creativelabs.com
List-Id: alsa-devel@alsa-project.org

Enabling CONFIG_SND_HDA_CODEC_CA0132_DSP on the Chromebook Pixel leads
to 10+ a second delay between running aplay and hearing audio.  This
was caused by the driver thinking the DSP was loaded when it had
actually failed.  The first two patches avoid that situation, the DSP
still fails to load every time, but at least the system continues
without a painful delay.  The third patch is just a cleanup that
touches the same state variable.

Dylan Reid (3):
  ALSA: hda/ca0132 - Check if dspload_image succeeded.
  ALSA: hda/ca0132 - Check download state of DSP.
  ALSA: hda/ca0132 - Remove extra setting of dsp_state.

 sound/pci/hda/patch_ca0132.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

-- 
1.8.1.3.605.g02339dd
