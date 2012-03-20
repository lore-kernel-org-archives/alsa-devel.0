From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH 8/8] sound:asoc: Update Kconfig and
	Makefile(sound/soc/) to support SPEAr audio
Date: Tue, 20 Mar 2012 17:03:52 +0530
Message-ID: <74835cc5bcd6d99d8b923d21ff9a8d1af2b34c0e.1332242166.git.rajeev-dlh.kumar@st.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
	[207.126.144.125])
	by alsa0.perex.cz (Postfix) with ESMTP id D67A8104255
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 12:34:59 +0100 (CET)
In-Reply-To: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, spear-devel@list.st.com, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch update Kconfig and Makefile present in soc directory to
support SPEAr.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/Kconfig  |    1 +
 sound/soc/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 35e662d..3860465 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -43,6 +43,7 @@ source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/spear/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 9ea8ac8..238da08 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -20,5 +20,6 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
-- 
1.7.2.2
