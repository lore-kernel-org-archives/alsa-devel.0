From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/17] ASoC: rt5645: add support for RT5648
Date: Thu, 26 Jan 2017 14:09:36 -0600
Message-ID: <1485461385-14544-9-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 65E0726779E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:25 +0100 (CET)
In-Reply-To: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

add ACPI ID 10EC5648 found e.g on Asus X205TA and use
rt5645 driver

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5645.c               | 1 +
 sound/soc/intel/boards/cht_bsw_rt5645.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 37fb2b6..17317c9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3545,6 +3545,7 @@ MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
+	{ "10EC5648", 0 },
 	{ "10EC5650", 0 },
 	{ "10EC5640", 0 },
 	{},
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index f504a0e..73efb38 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -344,6 +344,7 @@ static struct snd_soc_card snd_soc_card_chtrt5650 = {
 static struct cht_acpi_card snd_soc_cards[] = {
 	{"10EC5640", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
 	{"10EC5645", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
+	{"10EC5648", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
 	{"10EC5650", CODEC_TYPE_RT5650, &snd_soc_card_chtrt5650},
 };
 
-- 
2.7.4
