From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 1/3] pxa: Enable pxa-pcm-audio on pxa210/pxa25x
	platform
Date: Wed, 23 Feb 2011 02:29:09 +0300
Message-ID: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f49.google.com (mail-bw0-f49.google.com
	[209.85.214.49])
	by alsa0.perex.cz (Postfix) with ESMTP id B41E3103804
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 00:30:09 +0100 (CET)
Received: by bwz1 with SMTP id 1so1367161bwz.8
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 15:30:09 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

pxa25x platforms were left out of major ASoC Update patch.
Since f0fba2ad1b a registration of pxa-pcm-audio device is required for
ASoC to function on pxa platforms. Register one also for pxa210/pxa25x.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/pxa25x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index fbc5b77..b166b1d 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -347,6 +347,7 @@ static struct platform_device *pxa25x_devices[] __initdata = {
 	&pxa25x_device_assp,
 	&pxa25x_device_pwm0,
 	&pxa25x_device_pwm1,
+	&pxa_device_asoc_platform,
 };
 
 static struct sys_device pxa25x_sysdev[] = {
-- 
1.7.2.3
