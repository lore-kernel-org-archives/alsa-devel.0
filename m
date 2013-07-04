From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 07/11] ALSA: hdspm - Refactor
	ENUMERATED_CTL_INFO into function
Date: Thu,  4 Jul 2013 15:16:34 +0200
Message-ID: <1372943796-18998-8-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1372943796-18998-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-7-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1372943796-18998-7-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ENUMERATED_CTL_INFO is a macro, so the binary code is generated multiple
times. To avoid code duplication, refactor the involved functionality
into a function and make ENUMERATED_CTL_INFO a call to this function.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 15f1e7b..50453f9 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2221,16 +2221,22 @@ static int hdspm_get_s1_sample_rate(struct hdspm *hdspm, unsigned int idx)
 	return (status >> (idx*4)) & 0xF;
 }
 
-#define ENUMERATED_CTL_INFO(info, texts) \
-{ \
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED; \
-	uinfo->count = 1; \
-	uinfo->value.enumerated.items = ARRAY_SIZE(texts); \
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items) \
-		uinfo->value.enumerated.item =	uinfo->value.enumerated.items - 1; \
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]); \
+static void snd_hdspm_set_infotext(struct snd_ctl_elem_info *uinfo,
+		char **texts, const int count)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = count;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item =
+			uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name,
+			texts[uinfo->value.enumerated.item]);
 }
 
+#define ENUMERATED_CTL_INFO(info, texts) \
+	snd_hdspm_set_infotext(info, texts, ARRAY_SIZE(texts));
+
 
 
 #define HDSPM_AUTOSYNC_SAMPLE_RATE(xname, xindex) \
-- 
1.8.3.1
