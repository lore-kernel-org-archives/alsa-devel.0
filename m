From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH] MAINTAINERS: add entry for STM32 audio drivers
Date: Fri, 20 Jul 2018 10:02:51 +0200
Message-ID: <1532073771-8600-2-git-send-email-arnaud.pouliquen@st.com>
References: <1532073771-8600-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 990AA26770A
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 10:03:52 +0200 (CEST)
In-Reply-To: <1532073771-8600-1-git-send-email-arnaud.pouliquen@st.com>
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

Add sound/soc/stm drivers entry for STM32 audio drivers from
ST Microelectronics.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50a7a53..e220d1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13594,6 +13594,14 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/usb/stk1160/
 
+STM32 AUDIO (ASoC) DRIVERS
+M:	Olivier Moysan <olivier.moysan@st.com>
+M:	Arnaud Pouliquen <arnaud.pouliquen@st.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/st,stm32-*.txt
+F:	sound/soc/stm/
+
 STM32 TIMER/LPTIMER DRIVERS
 M:	Fabrice Gasnier <fabrice.gasnier@st.com>
 S:	Maintained
-- 
2.7.4
