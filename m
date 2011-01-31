From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ARM: tegra: Add to struct
	harmony_audio_platform_data
Date: Mon, 31 Jan 2011 15:37:15 -0700
Message-ID: <1296513435-14792-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B2361037EA
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 23:37:24 +0100 (CET)
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

Add fields to describe all the audio-related GPIOs on Harmony, except for
the codec's GPIO IRQ, which will be passed in its i2c_board_info.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Mark, can you please apply this to your tegra-arch branch, and merge that.
Thanks!

 arch/arm/mach-tegra/include/mach/harmony_audio.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/harmony_audio.h b/arch/arm/mach-tegra/include/mach/harmony_audio.h
index 5c46391..af08650 100644
--- a/arch/arm/mach-tegra/include/mach/harmony_audio.h
+++ b/arch/arm/mach-tegra/include/mach/harmony_audio.h
@@ -16,4 +16,7 @@
 
 struct harmony_audio_platform_data {
 	int gpio_spkr_en;
+	int gpio_hp_det;
+	int gpio_int_mic_en;
+	int gpio_ext_mic_en;
 };
-- 
1.7.1
