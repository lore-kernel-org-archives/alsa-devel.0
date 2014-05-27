From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/12] bebob: Add static specifier to
	identifier with file scope
Date: Wed, 28 May 2014 00:14:45 +0900
Message-ID: <1401203687-4189-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 367C526586D
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:15:18 +0200 (CEST)
In-Reply-To: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, dan.carpenter@oracle.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some variables were declared without static even if they're not referred
to from external files. This commit make them local symbols for better
information-hiding by file unit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c           | 2 +-
 sound/firewire/bebob/bebob_focusrite.c | 4 ++--
 sound/firewire/bebob/bebob_terratec.c  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index b5e8f99..0e9d625 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -313,7 +313,7 @@ static void bebob_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(bebob->card);
 }
 
-struct snd_bebob_rate_spec normal_rate_spec = {
+static struct snd_bebob_rate_spec normal_rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
 	.set	= &snd_bebob_stream_set_rate
 };
diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
index e71066d..45a0eed 100644
--- a/sound/firewire/bebob/bebob_focusrite.c
+++ b/sound/firewire/bebob/bebob_focusrite.c
@@ -256,7 +256,7 @@ static struct snd_bebob_clock_spec saffire_both_clk_spec = {
 	.get	= &saffire_both_clk_src_get,
 };
 /* Saffire LE */
-struct snd_bebob_meter_spec saffire_le_meter_spec = {
+static struct snd_bebob_meter_spec saffire_le_meter_spec = {
 	.num	= ARRAY_SIZE(saffire_le_meter_labels),
 	.labels	= saffire_le_meter_labels,
 	.get	= &saffire_meter_get,
@@ -267,7 +267,7 @@ struct snd_bebob_spec saffire_le_spec = {
 	.meter	= &saffire_le_meter_spec
 };
 /* Saffire */
-struct snd_bebob_meter_spec saffire_meter_spec = {
+static struct snd_bebob_meter_spec saffire_meter_spec = {
 	.num	= ARRAY_SIZE(saffire_meter_labels),
 	.labels	= saffire_meter_labels,
 	.get	= &saffire_meter_get,
diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
index 2a89c1c..eef8ea7 100644
--- a/sound/firewire/bebob/bebob_terratec.c
+++ b/sound/firewire/bebob/bebob_terratec.c
@@ -38,13 +38,13 @@ phase24_series_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 	return avc_audio_get_selector(bebob->unit, 0, 4, id);
 }
 
-struct snd_bebob_rate_spec phase_series_rate_spec = {
+static struct snd_bebob_rate_spec phase_series_rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
 	.set	= &snd_bebob_stream_set_rate,
 };
 
 /* PHASE 88 Rack FW */
-struct snd_bebob_clock_spec phase88_rack_clk = {
+static struct snd_bebob_clock_spec phase88_rack_clk = {
 	.num	= ARRAY_SIZE(phase88_rack_clk_src_labels),
 	.labels	= phase88_rack_clk_src_labels,
 	.get	= &phase88_rack_clk_src_get,
@@ -56,7 +56,7 @@ struct snd_bebob_spec phase88_rack_spec = {
 };
 
 /* 'PHASE 24 FW' and 'PHASE X24 FW' */
-struct snd_bebob_clock_spec phase24_series_clk = {
+static struct snd_bebob_clock_spec phase24_series_clk = {
 	.num	= ARRAY_SIZE(phase24_series_clk_src_labels),
 	.labels	= phase24_series_clk_src_labels,
 	.get	= &phase24_series_clk_src_get,
-- 
1.8.3.2
