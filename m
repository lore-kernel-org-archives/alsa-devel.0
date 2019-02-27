From: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] ASoC: mediatek: btcvsd add loopback
Date: Wed, 27 Feb 2019 09:30:44 +0800
Message-ID: <1551231044-24062-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stephen.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

add direct loopback path from rx to tx

Signed-off-by: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 69 +++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index 1b8bcdaf..9a163d7 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -49,6 +49,7 @@ enum bt_sco_state {
 	BT_SCO_STATE_IDLE,
 	BT_SCO_STATE_RUNNING,
 	BT_SCO_STATE_ENDING,
+	BT_SCO_STATE_LOOPBACK,
 };
 
 enum bt_sco_direct {
@@ -486,7 +487,8 @@ static irqreturn_t mtk_btcvsd_snd_irq_handler(int irq_id, void *dev)
 	if (bt->rx->state != BT_SCO_STATE_RUNNING &&
 	    bt->rx->state != BT_SCO_STATE_ENDING &&
 	    bt->tx->state != BT_SCO_STATE_RUNNING &&
-	    bt->tx->state != BT_SCO_STATE_ENDING) {
+	    bt->tx->state != BT_SCO_STATE_ENDING &&
+	    bt->tx->state != BT_SCO_STATE_LOOPBACK) {
 		dev_warn(bt->dev, "%s(), in idle state: rx->state: %d, tx->state: %d\n",
 			 __func__, bt->rx->state, bt->tx->state);
 		goto irq_handler_exit;
@@ -512,6 +514,42 @@ static irqreturn_t mtk_btcvsd_snd_irq_handler(int irq_id, void *dev)
 	buf_cnt_tx = btsco_packet_info[packet_type][2];
 	buf_cnt_rx = btsco_packet_info[packet_type][3];
 
+	if (bt->tx->state == BT_SCO_STATE_LOOPBACK) {
+		u8 *src, *dst;
+		unsigned long connsys_addr_rx, ap_addr_rx;
+		unsigned long connsys_addr_tx, ap_addr_tx;
+
+		connsys_addr_rx = *bt->bt_reg_pkt_r;
+		ap_addr_rx = (unsigned long)bt->bt_sram_bank2_base +
+			     (connsys_addr_rx & 0xFFFF);
+
+		connsys_addr_tx = *bt->bt_reg_pkt_w;
+		ap_addr_tx = (unsigned long)bt->bt_sram_bank2_base +
+			     (connsys_addr_tx & 0xFFFF);
+
+		if (connsys_addr_tx == 0xdeadfeed ||
+		    connsys_addr_rx == 0xdeadfeed) {
+			/* bt return 0xdeadfeed if read reg during bt sleep */
+			dev_warn(bt->dev, "%s(), connsys_addr_tx == 0xdeadfeed\n",
+				 __func__);
+			goto irq_handler_exit;
+		}
+
+		src = (u8 *)ap_addr_rx;
+		dst = (u8 *)ap_addr_tx;
+
+		mtk_btcvsd_snd_data_transfer(BT_SCO_DIRECT_BT2ARM, src,
+					     bt->tx->temp_packet_buf,
+					     packet_length,
+					     packet_num);
+		mtk_btcvsd_snd_data_transfer(BT_SCO_DIRECT_ARM2BT,
+					     bt->tx->temp_packet_buf, dst,
+					     packet_length,
+					     packet_num);
+		bt->rx->rw_cnt++;
+		bt->tx->rw_cnt++;
+	}
+
 	if (bt->rx->state == BT_SCO_STATE_RUNNING ||
 	    bt->rx->state == BT_SCO_STATE_ENDING) {
 		if (bt->rx->xrun) {
@@ -1067,6 +1105,33 @@ static int btcvsd_band_set(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int btcvsd_loopback_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_btcvsd_snd *bt = snd_soc_component_get_drvdata(cmpnt);
+	bool lpbk_en = bt->tx->state == BT_SCO_STATE_LOOPBACK;
+
+	ucontrol->value.integer.value[0] = lpbk_en;
+	return 0;
+}
+
+static int btcvsd_loopback_set(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_btcvsd_snd *bt = snd_soc_component_get_drvdata(cmpnt);
+
+	if (ucontrol->value.integer.value[0]) {
+		mtk_btcvsd_snd_set_state(bt, bt->tx, BT_SCO_STATE_LOOPBACK);
+		mtk_btcvsd_snd_set_state(bt, bt->rx, BT_SCO_STATE_LOOPBACK);
+	} else {
+		mtk_btcvsd_snd_set_state(bt, bt->tx, BT_SCO_STATE_RUNNING);
+		mtk_btcvsd_snd_set_state(bt, bt->rx, BT_SCO_STATE_RUNNING);
+	}
+	return 0;
+}
+
 static int btcvsd_tx_mute_get(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
@@ -1202,6 +1267,8 @@ static int btcvsd_tx_timestamp_get(struct snd_kcontrol *kcontrol,
 static const struct snd_kcontrol_new mtk_btcvsd_snd_controls[] = {
 	SOC_ENUM_EXT("BTCVSD Band", btcvsd_enum[0],
 		     btcvsd_band_get, btcvsd_band_set),
+	SOC_SINGLE_BOOL_EXT("BTCVSD Loopback Switch", 0,
+			    btcvsd_loopback_get, btcvsd_loopback_set),
 	SOC_SINGLE_BOOL_EXT("BTCVSD Tx Mute Switch", 0,
 			    btcvsd_tx_mute_get, btcvsd_tx_mute_set),
 	SOC_SINGLE_BOOL_EXT("BTCVSD Tx Irq Received Switch", 0,
-- 
1.9.1
