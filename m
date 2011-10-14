From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v3 1/8] ASoC: da7210: bugfix for head phone
 volume control
Date: Fri, 14 Oct 2011 16:25:25 +0530
Message-ID: <1318589725.12107.502.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 22E542441D
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 12:44:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch takes care of reserved bits of headphone volume
register by using correct volume range.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index ff68247..0809f32 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -149,12 +149,14 @@
  * mute		: 0x10
  * reserved	: 0x00 - 0x0F
  *
- * ** FIXME **
- *
  * Reserved area are considered as "mute".
- * -> min = -79.5 dB
  */
-static const DECLARE_TLV_DB_SCALE(hp_out_tlv, -7950, 150, 1);
+static const unsigned int hp_out_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0x0, 0x10, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
+	/* -54 dB to +15 dB */
+	0x11, 0x3f, TLV_DB_SCALE_ITEM(-5400, 150, 0),
+};
 
 static const struct snd_kcontrol_new da7210_snd_controls[] = {
 
-- 
1.7.1
