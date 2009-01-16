From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/1] ASoC: atmel_pcm: Remove non-existant header
Date: Fri, 16 Jan 2009 17:10:24 +0000
Message-ID: <1232125824-1855-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090116170916.GA1832@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ABF7524395
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 18:10:25 +0100 (CET)
In-Reply-To: <20090116170916.GA1832@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ben Nizette <bn@niasdigital.com>
List-Id: alsa-devel@alsa-project.org

From: Ben Nizette <bn@niasdigital.com>

<mach/hardware.h> doesn't exist on AVR32 and therefore this driver won't
build on that arch.  AFAICT this driver doesn't actually use the content
of that header so easiest just to remove it.

Signed-off-by: Ben Nizette <bn@niasdigital.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/atmel-pcm.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 1fac5ef..3dcdc4e 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -44,8 +44,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <mach/hardware.h>
-
 #include "atmel-pcm.h"
 
 
-- 
1.5.6.5
