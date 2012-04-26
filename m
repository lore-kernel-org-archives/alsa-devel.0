From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: soc-core: Remove unused variable 'min'
Date: Thu, 26 Apr 2012 01:51:59 -0300
Message-ID: <1335415919-28526-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E22D104B8D
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 06:52:14 +0200 (CEST)
Received: by yenl1 with SMTP id l1so725717yen.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2012 21:52:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

commit 4183eed2 (ASoC: core: Add signed multi register control) introduced
the variable 'min',but it is not used.

Remove it to fix the following build warning:

sound/soc/soc-core.c: In function 'snd_soc_put_xr_sx':
sound/soc/soc-core.c:2990: warning: unused variable 'min'

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/soc-core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c46ece5..5b0688e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2987,7 +2987,6 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	unsigned int regwmask = (1<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
-	long min = mc->min;
 	long max = mc->max;
 	long val = ucontrol->value.integer.value[0];
 	unsigned int i, regval, regmask;
-- 
1.7.1
