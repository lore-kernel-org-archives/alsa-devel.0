Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E4C2260815
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 15:53:00 +0200 (CEST)
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
 by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s76Dr0qU006400
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:53:00 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
 by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76Dr0Bd003492
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:53:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76DqwiP005480	for
 <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:59 -0500
From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 6 Aug 2014 16:52:45 +0300
Message-ID: <c7676065fda99d1cbbf782fc39643877d2522850.1407332062.git.jsarha@ti.com>
In-Reply-To: <cover.1407332062.git.jsarha@ti.com>
References: <cover.1407332062.git.jsarha@ti.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH 8/9] ARM: OMAP2+: omap2plus_defconfig: TDA998X
	HDMI trough tilcdc, slave
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-ID: <alsa-devel@alsa-project.org>

Select CONFIG_DRM=m, CONFIG_DRM_I2C_NXP_TDA998X=m, and
CONFIG_DRM_TILCDC=m, for Beaglebone-Black HDMI video support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 536a137..8b07fda 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -191,6 +191,9 @@ CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_PBIAS=y
+CONFIG_DRM=m
+CONFIG_DRM_I2C_NXP_TDA998X=m
+CONFIG_DRM_TILCDC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.9.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
