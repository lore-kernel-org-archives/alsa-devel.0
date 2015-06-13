From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 1/4] ASoC: max98090: Constify ACPI device ids
	and register map
Date: Sat, 13 Jun 2015 14:25:13 +0200
Message-ID: <1434198316-8400-2-git-send-email-minipli@googlemail.com>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 84CD8260561
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 14:25:28 +0200 (CEST)
Received: by wigg3 with SMTP id g3so36818104wig.1
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 05:25:28 -0700 (PDT)
In-Reply-To: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mathias Krause <minipli@googlemail.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

Constify the ACPI device ID array and the register map, no need to have
them writable at runtime.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 sound/soc/codecs/max98090.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 3e33ef2acf3c..2b7f1097bee8 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -27,7 +27,7 @@
 #include "max98090.h"
 
 /* Allows for sparsely populated register maps */
-static struct reg_default max98090_reg[] = {
+static const struct reg_default max98090_reg[] = {
 	{ 0x00, 0x00 }, /* 00 Software Reset */
 	{ 0x03, 0x04 }, /* 03 Interrupt Masks */
 	{ 0x04, 0x00 }, /* 04 System Clock Quick */
@@ -2696,7 +2696,7 @@ static const struct of_device_id max98090_of_match[] = {
 MODULE_DEVICE_TABLE(of, max98090_of_match);
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id max98090_acpi_match[] = {
+static const struct acpi_device_id max98090_acpi_match[] = {
 	{ "193C9890", MAX98090 },
 	{ }
 };
-- 
1.7.10.4
