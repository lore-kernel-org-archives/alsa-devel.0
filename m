From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH] MAINTAINERS: add entry for STI audio drivers
Date: Fri, 20 Jul 2018 10:02:50 +0200
Message-ID: <1532073771-8600-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id AB43C2675D4
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 10:03:51 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, olivier.moysan@st.com, Mark Brown <broonie@kernel.org>, arnaud.pouliquen@st.com, Alexandre TORGUE <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

Add sound/soc/sti drivers entry for STI audio drivers from
ST Microelectronics.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 192d7f7..50a7a53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13574,6 +13574,13 @@ L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	drivers/block/skd*[ch]
 
+STI AUDIO (ASoC) DRIVERS
+M:	Arnaud Pouliquen <arnaud.pouliquen@st.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
+F:	sound/soc/sti/
+
 STI CEC DRIVER
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 S:	Maintained
-- 
2.7.4
