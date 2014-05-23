From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Add suspend/resume support
Date: Fri, 23 May 2014 02:38:56 -0300
Message-ID: <1400823536-31708-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
 [209.85.192.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 16A4126563E
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 07:39:06 +0200 (CEST)
Received: by mail-qg0-f44.google.com with SMTP id i50so7346650qgf.3
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 22:39:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Doing a suspend/resume sequence while playing an audio track in the backgroung
causes broken audio right after resume:

root@freescale /$ aplay clarinet.wav &

root@freescale /home$ Playing WAVE 'clarinet.wav' : Signed 16 bit Little Endian,
 Rate 44100 Hz, Mono

root@freescale /home$ echo mem > /sys/power/state 
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.002 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: suspend of devices complete after 37.082 msecs
PM: suspend devices took 0.040 seconds
PM: late suspend of devices complete after 4.234 msecs
PM: noirq suspend of devices complete after 4.618 msecs
Disabling non-boot CPUs ...
PM: noirq resume of devices complete after 4.013 msecs
PM: early resume of devices complete after 4.000 msecs
PM: resume of devices complete after 68.907 msecs
PM: resume devices took 0.070 seconds
Restarting tasks ... Suspended. Trying resume. Failed. Restarting stream. Done.
Suspended. Trying resume. Failed. Restarting stream. Done.
Suspended. Trying resume. Failed. Restarting stream. Done.
Suspended. Trying resume. Failed. Restarting stream. Done.
Suspended. Trying resume. Failed. Restarting stream. Done.
Suspended. Trying resume. Failed. Restarting stream. Done.
Suspended. Trying resume. Failed. Restarting stream. Done.
....

Add SNDRV_PCM_TRIGGER_RESUME/SUSPEND cases so that we can gracefully handle
system suspend/resume.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f233d91..090f449 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -874,6 +874,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			fsl_ssi_tx_config(ssi_private, true);
@@ -882,6 +883,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			fsl_ssi_tx_config(ssi_private, false);
-- 
1.8.3.2
