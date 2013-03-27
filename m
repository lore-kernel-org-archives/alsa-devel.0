From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ALSA: add DSD formats
Date: Thu, 28 Mar 2013 00:30:45 +0100
Message-ID: <1364427046-29944-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 884FA26531B
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 00:31:04 +0100 (CET)
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
Cc: jussi@sonarnerd.net, tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

This patch adds two formats for Direct Stream Digital (DSD), a
pulse-density encoding format which is described here:
https://en.wikipedia.org/wiki/Direct_Stream_Digital

DSD operates on 2.8, 5.6 or 11.2MHz sample rates and as a 1-bit
stream. In order to provide a compatibility way for pushing samples
of DSD type through ordinary PCM channels, the "DoP open Standard" was
created. See http://www.dsd-guide.com for a copy of the documentation.

The two new types describe streams that are capable of handling DSD
samples in 8-bit or in 16-bit (or at a single or double data rate,
respectively). For applications, the following mapping table is used
to configure the DSD mode by selecting a combination of PCM sample
rates and word lengths:

        352.8kHz       705.6KHz     1411.2KHz

8-bit     2.8MHz         5.6MHz       11.2MHz
16-bit    5.6MHz        11.2MHz

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 include/sound/pcm.h         | 2 ++
 include/uapi/sound/asound.h | 4 +++-
 sound/core/pcm.c            | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index aa7b0a8..2dffd55 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -181,6 +181,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_G723_24_1B	_SNDRV_PCM_FMTBIT(G723_24_1B)
 #define SNDRV_PCM_FMTBIT_G723_40	_SNDRV_PCM_FMTBIT(G723_40)
 #define SNDRV_PCM_FMTBIT_G723_40_1B	_SNDRV_PCM_FMTBIT(G723_40_1B)
+#define SNDRV_PCM_FMTBIT_DSD_U8		_SNDRV_PCM_FMTBIT(DSD_U8)
+#define SNDRV_PCM_FMTBIT_DSD_U16	_SNDRV_PCM_FMTBIT(DSD_U16)
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_LE
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1774a5c..f9b0d3f 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -214,7 +214,9 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_G723_24_1B	((__force snd_pcm_format_t) 45) /* 1 sample in 1 byte */
 #define	SNDRV_PCM_FORMAT_G723_40	((__force snd_pcm_format_t) 46) /* 8 Samples in 5 bytes */
 #define	SNDRV_PCM_FORMAT_G723_40_1B	((__force snd_pcm_format_t) 47) /* 1 sample in 1 byte */
-#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_G723_40_1B
+#define	SNDRV_PCM_FORMAT_DSD_U8		((__force snd_pcm_format_t) 48) /* DSD in 1 byte */
+#define	SNDRV_PCM_FORMAT_DSD_U16	((__force snd_pcm_format_t) 49) /* DSD in 2 bytes */
+#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_16U
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 578327e..433efdb 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -209,6 +209,8 @@ static char *snd_pcm_format_names[] = {
 	FORMAT(G723_24_1B),
 	FORMAT(G723_40),
 	FORMAT(G723_40_1B),
+	FORMAT(DSD_U8),
+	FORMAT(DSD_U16),
 };
 
 const char *snd_pcm_format_name(snd_pcm_format_t format)
-- 
1.8.1.4
