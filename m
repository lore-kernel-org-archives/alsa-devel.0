From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 0/1] ASoC: Added OMAP3 EVM Support
Date: Thu,  7 May 2009 21:38:30 +0530
Message-ID: <1241712510-16191-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, getarunks@gmail.com
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

With refernce to the discussion at:

http://marc.info/?l=linux-omap&m=124169330310075&w=2

I am resending the patch to add OMAP3 EVM support in ASoC. It
has been built/checked against the tip.

Anuj Aggarwal (1):
  ASoC: Added OMAP3 EVM support in ASoC.

 sound/soc/omap/Kconfig    |    8 +++
 sound/soc/omap/Makefile   |    2 +
 sound/soc/omap/omap3evm.c |  147 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap3evm.c

