From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v2 02/12] ASoC: alc5632: Fixed voice DAC volume
	step.
Date: Sat, 11 Feb 2012 23:26:28 +0200
Message-ID: <1328995598-8788-3-git-send-email-leon@leon.nu>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BBCC1103A16
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:26:52 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id n11so1209112eaa.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:26:52 -0800 (PST)
In-Reply-To: <1328995598-8788-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

From: Andrey Danin <danindrey@mail.ru>

Remove extra zero from volume step in DECLARE_TLV_DB_SCALE macro.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 0d574aa..fce5e76 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -153,7 +153,7 @@ static const unsigned int boost_tlv[] = {
 /* 0db min scale, 6 db steps, no mute */
 static const DECLARE_TLV_DB_SCALE(dig_tlv, 0, 600, 0);
 /* 0db min scalem 0.75db steps, no mute */
-static const DECLARE_TLV_DB_SCALE(vdac_tlv, -3525, 075, 0);
+static const DECLARE_TLV_DB_SCALE(vdac_tlv, -3525, 75, 0);
 
 static const struct snd_kcontrol_new alc5632_vol_snd_controls[] = {
 	/* left starts at bit 8, right at bit 0 */
-- 
1.7.3.4
