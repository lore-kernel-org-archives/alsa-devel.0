From: Tom Rini <trini@konsulko.com>
Subject: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Tue, 22 Aug 2017 21:51:46 -0400
Message-ID: <1503453106-5564-1-git-send-email-trini@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
 [209.85.161.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 792C2266834
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 03:51:39 +0200 (CEST)
Received: by mail-yw0-f196.google.com with SMTP id y64so244886ywf.1
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 18:51:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Not all devices with ACPI and this combination of sound devices will
have the required information provided via ACPI.  Reintroduce the I2C
device ID to restore sound functionality on on the Chromebook 'Samus'
model.

Fixes: a36afb0ab648 ("ASoC: rt5677: Introduce proper table for ACPI enumeration")
Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
CC: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
This is a regression from v4.12 on my laptop (a Chromebook 'Samus'
that's not running ChromeOS).  My fault for getting out of the habit of
trying -rc1 when it comes out and not spotting this sooner.  I'm not
100% sure if this fix is correct for all cases as I'm only able to test
my hardware here, and this does fix my laptop.
---
 sound/soc/codecs/rt5677.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 36e530a36c82..6f629278d982 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5021,6 +5021,7 @@ static int rt5677_write(void *context, unsigned int reg, unsigned int val)
 static const struct i2c_device_id rt5677_i2c_id[] = {
 	{ "rt5677", RT5677 },
 	{ "rt5676", RT5676 },
+	{ "RT5677CE:00", RT5677 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
-- 
1.9.1
