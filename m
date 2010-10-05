From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] sound/soc/nuc900: remove duplicated include
Date: Tue, 5 Oct 2010 14:11:40 +0200
Message-ID: <20101005141140.0276dc14@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Wan ZongShun <mcuos.com@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Remove duplicated include.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 sound/soc/nuc900/nuc900-ac97.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index caa7c90..265a950 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -20,7 +20,6 @@
 #include <sound/pcm.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
-#include <linux/device.h>
 #include <linux/clk.h>
 
 #include <mach/mfp.h>
-- 
1.7.2.2
