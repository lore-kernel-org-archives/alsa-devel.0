From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: omap: mcbsp: Remove redundant checks
	for the st_data pointer
Date: Tue, 28 Feb 2012 10:07:32 +0200
Message-ID: <1330416452-7195-3-git-send-email-peter.ujfalusi@ti.com>
References: <1330416452-7195-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id DAF7324507
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 09:07:53 +0100 (CET)
Received: by mail-lpp01m010-f54.google.com with SMTP id z14so11874299lag.27
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 00:07:52 -0800 (PST)
In-Reply-To: <1330416452-7195-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The parent functions of omap_st_start/stop also checks the validity of the
st_data pointer so we do not need to do it again inside of omap_st_start/stop

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 79f6da6..5f6c21d 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -318,7 +318,7 @@ static int omap_st_start(struct omap_mcbsp *mcbsp)
 {
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 
-	if (st_data && st_data->enabled && !st_data->running) {
+	if (st_data->enabled && !st_data->running) {
 		omap_st_fir_write(mcbsp, st_data->taps);
 		omap_st_chgain(mcbsp);
 
@@ -350,7 +350,7 @@ static int omap_st_stop(struct omap_mcbsp *mcbsp)
 {
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 
-	if (st_data && st_data->running) {
+	if (st_data->running) {
 		if (!mcbsp->free) {
 			omap_st_off(mcbsp);
 			st_data->running = 0;
-- 
1.7.8.4
