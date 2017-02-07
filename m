From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ALSA: x86: Flatten two abstraction layers
Date: Tue, 7 Feb 2017 13:42:03 +0300
Message-ID: <20170207104203.GA14088@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B164266F77
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 11:42:24 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Iwai,

The patch da8648097497: "ALSA: x86: Flatten two abstraction layers"
from Jan 31, 2017, leads to the following static checker warning:

	sound/x86/intel_hdmi_audio.c:1702 hdmi_lpe_audio_probe()
	error: strcpy() '"IntelHdmiLpeAudio"' too large for 'card->driver' (18 vs 16)

sound/x86/intel_hdmi_audio.c
  1695          ctx = card->private_data;
  1696          spin_lock_init(&ctx->had_spinlock);
  1697          mutex_init(&ctx->mutex);
  1698          ctx->connected = false;
  1699          ctx->dev = &pdev->dev;
  1700          ctx->card = card;
  1701          ctx->aes_bits = SNDRV_PCM_DEFAULT_CON_SPDIF;
  1702          strcpy(card->driver, INTEL_HAD);
                                     ^^^^^^^^^
Too long.  We're corrupting memory.  The old code was equally bad, but
the renaming the function made it show up as a new warning...

  1703          strcpy(card->shortname, INTEL_HAD);
  1704  

regards,
dan carpenter
