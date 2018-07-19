From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: wm_adsp: Take prefix into account in
	control name length
Date: Thu, 19 Jul 2018 11:50:36 +0100
Message-ID: <20180719105039.28312-2-ckeepax@opensource.cirrus.com>
References: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A5442267815
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 12:50:43 +0200 (CEST)
In-Reply-To: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
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
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently when creating ALSA control names for the DSP the length of any
prefix applied to the CODEC is not taken into account. Whilst this is
mostly harmless it does result in ALSA doing the truncation of the
control names and printing a warning. It is better to have the driver do
the truncation so it can truncate from the start of parameter name
itself to give a greater chance of the result maintain a unique name.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 99108d18de8d..eec73c98a141 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1343,6 +1343,9 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 			int avail = SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret - 2;
 			int skip = 0;
 
+			if (dsp->component->name_prefix)
+				avail -= strlen(dsp->component->name_prefix) + 1;
+
 			if (subname_len > avail)
 				skip = subname_len - avail;
 
-- 
2.11.0
