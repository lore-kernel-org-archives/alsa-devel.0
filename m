From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 09/32] ASoC: rt5651: Do not modify the LDO
	voltage control bits from set_bias_level()
Date: Sun, 25 Feb 2018 11:46:50 +0100
Message-ID: <20180225104713.4745-10-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 68FB22673C4
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:31 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The PWR_ANLG1 reg not only contains various power on/off bits, it also
contains 2 bits which select if the LDO generates 1.0, 1.1 or 1.2V. Note
there is a separate on/off bit for the LDO.

rt5651_set_bias_level(BIAS_OFF) used to unconditionally clear the entire
register, when jack-detection support was introduced a special case for
jack-detect was added which hard-codes a register value to keep the LDO
voltage at 1.2 volt.

This commit removes the jack-detect special case, instead simply always
leaving the LDO voltage control bits as is on BIAS_OFF.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 90e800416a8e..22f233e00ef9 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1550,11 +1550,12 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 		snd_soc_component_write(component, RT5651_PWR_DIG2, 0x0000);
 		snd_soc_component_write(component, RT5651_PWR_VOL, 0x0000);
 		snd_soc_component_write(component, RT5651_PWR_MIXER, 0x0000);
+		/* Do not touch the LDO voltage select bits on bias-off */
+		snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
+			~RT5651_PWR_LDO_DVO_MASK, 0);
 		if (rt5651->jd_src) {
 			snd_soc_component_write(component, RT5651_PWR_ANLG2, 0x0204);
-			snd_soc_component_write(component, RT5651_PWR_ANLG1, 0x0002);
 		} else {
-			snd_soc_component_write(component, RT5651_PWR_ANLG1, 0x0000);
 			snd_soc_component_write(component, RT5651_PWR_ANLG2, 0x0000);
 		}
 		break;
-- 
2.14.3
