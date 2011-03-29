From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V2 5/5] sound: asoc: Adding support for
	SPEAr13XX in soc
Date: Tue, 29 Mar 2011 16:47:03 +0530
Message-ID: <1301397423-4693-6-git-send-email-rajeev-dlh.kumar@st.com>
References: <1301397423-4693-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-3-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-4-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-5-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
	[207.126.144.145])
	by alsa0.perex.cz (Postfix) with ESMTP id B441B1039A0
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 13:18:30 +0200 (CEST)
In-Reply-To: <1301397423-4693-5-git-send-email-rajeev-dlh.kumar@st.com>
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
Cc: alsa-devel@alsa-project.org, rajeev-dlh.kumar@st.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds the SPEAr13XX support by updating the Kconfig and Makefile
present in soc directory

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/Kconfig  |    1 +
 sound/soc/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 8224db5..31cceca 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -55,6 +55,7 @@ source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/spear/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 1ed61c5..dd9c624 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
-- 
1.6.0.2
