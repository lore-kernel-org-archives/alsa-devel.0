From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2200: Correct types of mixer texts and
	values
Date: Thu, 10 Nov 2016 15:34:52 +0000
Message-ID: <1478792092-5990-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 337C826663B
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 16:34:39 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The core expects "const char * const" and "unsigned int" for enum
controls, the mixer control definitions in wm2200 use "const char *"
and "int".  This patch corrects the type of these arrays.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 606bf88..d83dab5 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -999,7 +999,7 @@ static DECLARE_TLV_DB_SCALE(in_tlv, -6300, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
 static DECLARE_TLV_DB_SCALE(out_tlv, -6400, 100, 0);
 
-static const char *wm2200_mixer_texts[] = {
+static const char * const wm2200_mixer_texts[] = {
 	"None",
 	"Tone Generator",
 	"AEC Loopback",
@@ -1033,7 +1033,7 @@ static const char *wm2200_mixer_texts[] = {
 	"DSP2.6",
 };
 
-static int wm2200_mixer_values[] = {
+static unsigned int wm2200_mixer_values[] = {
 	0x00,
 	0x04,   /* Tone */
 	0x08,   /* AEC */
-- 
2.1.4
