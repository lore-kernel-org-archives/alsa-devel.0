From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 1/2] ASoC: PXA: z2: Mute internal speaker when
	headphones are connected
Date: Fri, 11 Mar 2011 11:05:37 +0200
Message-ID: <1299834338-9185-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id DDAF82413F
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 10:06:23 +0100 (CET)
Received: by bwz10 with SMTP id 10so2467540bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 01:06:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Marek Vasut <marek.vasut@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/pxa/z2.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 3ceaef6..b0b6c8d 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -95,6 +95,11 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
 		.pin	= "Headphone Jack",
 		.mask	= SND_JACK_HEADPHONE,
 	},
+	{
+		.pin    = "Ext Spk",
+		.mask   = SND_JACK_HEADPHONE,
+		.invert = 1
+	},
 };
 
 /* Headset jack detection gpios */
-- 
1.7.4.1
