From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 2/2] alsa-lib: bring pcm.h and pcm.c in sync
	with the kernel list
Date: Sat,  6 Apr 2013 13:50:14 +0200
Message-ID: <1365249014-2457-2-git-send-email-zonque@gmail.com>
References: <1365249014-2457-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id E470C262635
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 13:50:09 +0200 (CEST)
In-Reply-To: <1365249014-2457-1-git-send-email-zonque@gmail.com>
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

In particular, this adds definitions and descriptions for G.723 and
DSD types.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 include/pcm.h | 14 +++++++++++++-
 src/pcm/pcm.c | 12 ++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/pcm.h b/include/pcm.h
index 2235678..768a4a7 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -199,7 +199,19 @@ typedef enum _snd_pcm_format {
 	SND_PCM_FORMAT_U18_3LE,
 	/** Unsigned 18bit Big Endian in 3bytes format */
 	SND_PCM_FORMAT_U18_3BE,
-	SND_PCM_FORMAT_LAST = SND_PCM_FORMAT_U18_3BE,
+	/* G.723 (ADPCM) 24 kbit/s, 8 samples in 3 bytes */
+	SND_PCM_FORMAT_G723_24,
+	/* G.723 (ADPCM) 24 kbit/s, 1 sample in 1 byte */
+	SND_PCM_FORMAT_G723_24_1B,
+	/* G.723 (ADPCM) 40 kbit/s, 8 samples in 3 bytes */
+	SND_PCM_FORMAT_G723_40,
+	/* G.723 (ADPCM) 40 kbit/s, 1 sample in 1 byte */
+	SND_PCM_FORMAT_G723_40_1B,
+	/* Direct Stream Digital (DSD) in 1-byte DOP samples (x8) */
+	SND_PCM_FORMAT_DSD_DOP_U8,
+	/* Direct Stream Digital (DSD) in 2-byte DOP samples (x16) */
+	SND_PCM_FORMAT_DSD_DOP_U16,
+	SND_PCM_FORMAT_LAST = SND_PCM_FORMAT_DSD_DOP_U16,
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 	/** Signed 16 bit CPU endian */
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 2963711..60b840f 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1554,6 +1554,12 @@ static const char *const snd_pcm_format_names[] = {
 	FORMAT(S18_3BE),
 	FORMAT(U18_3LE),
 	FORMAT(U18_3BE),
+	FORMAT(G723_24),
+	FORMAT(G723_24_1B),
+	FORMAT(G723_40),
+	FORMAT(G723_40_1B),
+	FORMAT(DSD_DOP_U8),
+	FORMAT(DSD_DOP_U16),
 };
 
 static const char *const snd_pcm_format_aliases[SND_PCM_FORMAT_LAST+1] = {
@@ -1607,6 +1613,12 @@ static const char *const snd_pcm_format_descriptions[] = {
 	FORMATD(S18_3BE, "Signed 18 bit Big Endian in 3bytes"),
 	FORMATD(U18_3LE, "Unsigned 18 bit Little Endian in 3bytes"),
 	FORMATD(U18_3BE, "Unsigned 18 bit Big Endian in 3bytes"),
+	FORMATD(G723_24, "G.723 (ADPCM) 24 kbit/s, 8 samples in 3 bytes"),
+	FORMATD(G723_24_1B, "G.723 (ADPCM) 24 kbit/s, 1 sample in 1 byte"),
+	FORMATD(G723_40, "G.723 (ADPCM) 40 kbit/s, 8 samples in 3 bytes"),
+	FORMATD(G723_40_1B, "G.723 (ADPCM) 40 kbit/s, 1 sample in 1 byte"),
+	FORMATD(DSD_DOP_U8,  "Direct Stream Digital (DSD), 1-byte DOP samples (x8)"),
+	FORMATD(DSD_DOP_U16, "Direct Stream Digital (DSD), 2-byte DOP samples (x16)"),
 };
 
 static const char *const snd_pcm_type_names[] = {
-- 
1.8.1.4
