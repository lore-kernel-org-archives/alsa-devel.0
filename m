From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V2 9/9] sound:asoc: Update Kconfig and
	Makefile(sound/soc/) to support SPEAr audio
Date: Thu, 21 Jun 2012 15:54:57 +0530
Message-ID: <622034b1515236d5c0d57e66816b8f03efefea5e.1340273261.git.rajeev-dlh.kumar@st.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 5624210B9C8
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 11:04:37 +0200 (CEST)
In-Reply-To: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch update Kconfig and Makefile present in soc directory to
support SPEAr

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/Kconfig  |    1 +
 sound/soc/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index c5de0a8..8309589 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -46,6 +46,7 @@ source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/spear/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 source "sound/soc/ux500/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 00a555a..4a8c886 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
 obj-$(CONFIG_SND_SOC)	+= ux500/
-- 
1.7.0.4
