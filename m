From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: rt5640: Add RT5642 ACPI ID for Intel
	Baytrail
Date: Fri, 23 Jan 2015 14:15:30 +0200
Message-ID: <1422015330-10483-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B8952606C7
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 13:15:44 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Asus T100TAF uses ACPI ID "10EC5642" for its audio codec. I suppose it is
updated ACPI ID for the RT5642 codec since some earlier platforms are using
"10EC5640" with the RT5642 too.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
---
ACPI ID found from the DSDT table of Asus T100TAF. This makes the rt5640
codec driver probing but the audio itself is not working due a bit different
ACPI data and perhaps HW differences too compared to for instance Asus
T100TA.
---
 sound/soc/codecs/rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index b386958de042..178e55d4d481 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2125,6 +2125,7 @@ MODULE_DEVICE_TABLE(of, rt5640_of_match);
 static struct acpi_device_id rt5640_acpi_match[] = {
 	{ "INT33CA", 0 },
 	{ "10EC5640", 0 },
+	{ "10EC5642", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
-- 
2.1.4
