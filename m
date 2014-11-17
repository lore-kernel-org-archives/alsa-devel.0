From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Remove comment about SSI
	running only in slave mode
Date: Mon, 17 Nov 2014 00:16:19 -0200
Message-ID: <1416190579-14006-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com
 [209.85.192.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 282C426147A
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 03:16:53 +0100 (CET)
Received: by mail-qg0-f47.google.com with SMTP id z60so1948197qgd.6
 for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2014 18:16:52 -0800 (PST)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Current driver can also run in I2S master mode, so remove the old comment.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ab05262..1ef0c84 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -67,8 +67,6 @@
 /**
  * FSLSSI_I2S_FORMATS: audio formats supported by the SSI
  *
- * This driver currently only supports the SSI running in I2S slave mode.
- *
  * The SSI has a limitation in that the samples must be in the same byte
  * order as the host CPU.  This is because when multiple bytes are written
  * to the STX register, the bytes and bits must be written in the same
-- 
1.9.1
