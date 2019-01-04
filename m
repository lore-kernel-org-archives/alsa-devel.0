From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: eliminate left-over from Raumfeld
	machine driver removal
Date: Fri,  4 Jan 2019 19:55:30 +0100
Message-ID: <20190104185530.30920-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 93ED1267B50
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 19:55:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Commit f84a6273dd9107c ("ASoC: pxa: remove raumfeld machine driver")
removed the Raumfeld ASoC machine driver but forgot to kill one line
in the Makefile.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/pxa/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 0ab2a9dcb720..ea4929d73318 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -30,7 +30,6 @@ snd-soc-magician-objs := magician.o
 snd-soc-mioa701-objs := mioa701_wm9713.o
 snd-soc-z2-objs := z2.o
 snd-soc-imote2-objs := imote2.o
-snd-soc-raumfeld-objs := raumfeld.o
 snd-soc-brownstone-objs := brownstone.o
 snd-soc-ttc-dkb-objs := ttc-dkb.o
 
-- 
2.19.2
