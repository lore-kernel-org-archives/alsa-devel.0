From: Stephen Warren <swarren@nvidia.com>
Subject: [GIT PULL] Branch to add harmony_audio.h to Tegra and
	ASoC
Date: Fri, 21 Jan 2011 22:18:35 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310955A8F@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ECEC243DF
	for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2011 07:18:51 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Colin Cross (ccross@google.com)" <ccross@google.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark, Colin,

Please pull:

http://avon.wwwdotorg.org/downloads/kernel.git tegra_harmony_asoc_platform_data

This is a branch that's suitable for merging into both ASoC's for-2.6.39 and
Tegra's for-next branch, and contains a single commit to add file
arch/arm/mach-tegra/include/mach/harmony_audio.h. It's branched off the
latest kernel tag that Tegra's for-next pulled in (v2.6.37-rc4) and merges
into both target branches without issues as far as I can tell.

Note that since I wanted to avoid having to do more similar merges in the
future, I added a few more fields to the platform data that I know will be
needed to fully describe Harmony; the commit is now as shown below.

Thanks!

commit 1b1fab5161c555d25c3e3ee26b423c05b393e54c
Author: Stephen Warren <swarren@nvidia.com>
Date:   Wed Jan 19 13:07:03 2011 -0700

    ARM: tegra: Add Harmony sound platform data type
    
    Signed-off-by: Stephen Warren <swarren@nvidia.com>

diff --git a/arch/arm/mach-tegra/include/mach/harmony_audio.h b/arch/arm/mach-tegra/include/mach/harmony_audio.h
new file mode 100644
index 0000000..aa136a7
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/harmony_audio.h
@@ -0,0 +1,23 @@
+/*
+ * arch/arm/mach-tegra/include/mach/harmony_audio.h
+ *
+ * Copyright 2011 NVIDIA, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+struct harmony_audio_platform_data {
+       int gpio_spkr_en;
+       int gpio_hp_det;
+       int gpio_int_mic_en;
+       int gpio_ext_mic_en;
+       int gpio_cdc_irq;
+};
