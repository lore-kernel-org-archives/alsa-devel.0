From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH v3 2/4] ARM: tegra: Add Harmony sound platform
	data type
Date: Thu, 20 Jan 2011 13:52:09 -0700
Message-ID: <1295556731-25165-3-git-send-email-swarren@nvidia.com>
References: <1295556731-25165-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E8637243F1
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 21:52:21 +0100 (CET)
In-Reply-To: <1295556731-25165-1-git-send-email-swarren@nvidia.com>
In-Reply-To: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/harmony_audio.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/harmony_audio.h

diff --git a/arch/arm/mach-tegra/include/mach/harmony_audio.h b/arch/arm/mach-tegra/include/mach/harmony_audio.h
new file mode 100644
index 0000000..5c46391
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/harmony_audio.h
@@ -0,0 +1,19 @@
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
+	int gpio_spkr_en;
+};
-- 
1.7.1
