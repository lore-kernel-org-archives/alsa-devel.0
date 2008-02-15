From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: [PATCH 1/1] Add __devinit macro to at73c213 sound
	driver probe functions
Date: Fri, 15 Feb 2008 10:35:26 +0100
Message-ID: <12030681261798-git-send-email-hcegtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 881F82445E
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 10:36:56 +0100 (CET)
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
Cc: kernel@avr32linux.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds __devinit to the functions used when probing. Will also reduce
the memory footprint a bit if CONFIG_HOTPLUG is not enabled.

Signed-off-by: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
---
 sound/spi/at73c213.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index fee869b..83fa475 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -744,7 +744,7 @@ cleanup:
 /*
  * Device functions
  */
-static int snd_at73c213_ssc_init(struct snd_at73c213 *chip)
+static int __devinit snd_at73c213_ssc_init(struct snd_at73c213 *chip)
 {
 	/*
 	 * Continuous clock output.
@@ -774,7 +774,7 @@ static int snd_at73c213_ssc_init(struct snd_at73c213 *chip)
 	return 0;
 }
 
-static int snd_at73c213_chip_init(struct snd_at73c213 *chip)
+static int __devinit snd_at73c213_chip_init(struct snd_at73c213 *chip)
 {
 	int retval;
 	unsigned char dac_ctrl = 0;
@@ -939,7 +939,7 @@ out:
 	return retval;
 }
 
-static int snd_at73c213_probe(struct spi_device *spi)
+static int __devinit snd_at73c213_probe(struct spi_device *spi)
 {
 	struct snd_card			*card;
 	struct snd_at73c213		*chip;
-- 
1.5.2.5
