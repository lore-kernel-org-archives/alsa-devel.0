From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/12] ALSA: msnd: Use NULL instead of 0
Date: Wed, 25 Jul 2018 23:00:50 +0200
Message-ID: <20180725210057.18017-6-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8364D267783
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:05 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 934ACB078
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Fix a sparse warning:
  sound/isa/msnd/msnd_pinnacle.c:813:1: warning: Using plain integer as NULL pointer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/msnd/msnd_pinnacle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 7e3f52c8a6c6..11af9c40bc05 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -810,7 +810,7 @@ module_param(calibrate_signal, int, 0444);
 #ifndef MSND_CLASSIC
 module_param_array(digital, int, NULL, 0444);
 module_param_hw_array(cfg, long, ioport, NULL, 0444);
-module_param_array(reset, int, 0, 0444);
+module_param_array(reset, int, NULL, 0444);
 module_param_hw_array(mpu_io, long, ioport, NULL, 0444);
 module_param_hw_array(mpu_irq, int, irq, NULL, 0444);
 module_param_hw_array(ide_io0, long, ioport, NULL, 0444);
-- 
2.18.0
