From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/5] sh: fix an SIU device name mismatch
Date: Fri, 17 Sep 2010 12:30:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009171212280.4988@axis700.grange>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Paul Mundt <lethal@linux-sh.org>
List-Id: alsa-devel@alsa-project.org

Recent ASoC changes unified all PCM names, fix the platform code to match.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 156ccc9..d551ed8 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -551,7 +551,7 @@ static struct resource siu_resources[] = {
 };
 
 static struct platform_device siu_device = {
-	.name		= "sh_siu",
+	.name		= "siu-pcm-audio",
 	.id		= -1,
 	.dev = {
 		.platform_data	= &siu_platform_data,
-- 
1.7.1

