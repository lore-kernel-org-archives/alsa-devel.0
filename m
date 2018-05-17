From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: emu10k1: fix spelling mistake: "Caputre"
	-> "Capture"
Date: Thu, 17 May 2018 09:04:20 +0100
Message-ID: <20180517080420.23020-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FBF0266DF0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 10:04:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in audigy_outs arrays.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/emu10k1/emufx.c   | 2 +-
 sound/pci/emu10k1/emuproc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 608ff4857d70..b45a01bb73e5 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -170,7 +170,7 @@ static char *audigy_outs[32] = {
 	/* 0x0f */ "Rear Right",
 	/* 0x10 */ "AC97 Front Left",
 	/* 0x11 */ "AC97 Front Right",
-	/* 0x12 */ "ADC Caputre Left",
+	/* 0x12 */ "ADC Capture Left",
 	/* 0x13 */ "ADC Capture Right",
 	/* 0x14 */ NULL,
 	/* 0x15 */ NULL,
diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index bde0d1954f56..055227caa7ca 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -135,7 +135,7 @@ static void snd_emu10k1_proc_read(struct snd_info_entry *entry,
 		/* 15 */ "Rear Right",
 		/* 16 */ "AC97 Front Left",
 		/* 17 */ "AC97 Front Right",
-		/* 18 */ "ADC Caputre Left",
+		/* 18 */ "ADC Capture Left",
 		/* 19 */ "ADC Capture Right",
 		/* 20 */ "???",
 		/* 21 */ "???",
-- 
2.17.0
