From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: omap: mcbsp: Use uniform st_data
	pointer initialization
Date: Tue, 28 Feb 2012 10:07:31 +0200
Message-ID: <1330416452-7195-2-git-send-email-peter.ujfalusi@ti.com>
References: <1330416452-7195-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71]) by alsa0.perex.cz (Postfix) with ESMTP id ADE6B244F8
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 09:07:48 +0100 (CET)
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so3078766laa.38
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 00:07:47 -0800 (PST)
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

In this way we can save few lines, and have uniform way of initializing the
st_data in all functions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index fe4734e..79f6da6 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -273,11 +273,9 @@ static void omap_st_chgain(struct omap_mcbsp *mcbsp)
 
 int omap_st_set_chgain(struct omap_mcbsp *mcbsp, int channel, s16 chgain)
 {
-	struct omap_mcbsp_st_data *st_data;
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 	int ret = 0;
 
-	st_data = mcbsp->st_data;
-
 	if (!st_data)
 		return -ENOENT;
 
@@ -298,11 +296,9 @@ int omap_st_set_chgain(struct omap_mcbsp *mcbsp, int channel, s16 chgain)
 
 int omap_st_get_chgain(struct omap_mcbsp *mcbsp, int channel, s16 *chgain)
 {
-	struct omap_mcbsp_st_data *st_data;
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 	int ret = 0;
 
-	st_data = mcbsp->st_data;
-
 	if (!st_data)
 		return -ENOENT;
 
@@ -337,9 +333,7 @@ static int omap_st_start(struct omap_mcbsp *mcbsp)
 
 int omap_st_enable(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp_st_data *st_data;
-
-	st_data = mcbsp->st_data;
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 
 	if (!st_data)
 		return -ENODEV;
@@ -368,11 +362,9 @@ static int omap_st_stop(struct omap_mcbsp *mcbsp)
 
 int omap_st_disable(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp_st_data *st_data;
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 	int ret = 0;
 
-	st_data = mcbsp->st_data;
-
 	if (!st_data)
 		return -ENODEV;
 
@@ -386,14 +378,11 @@ int omap_st_disable(struct omap_mcbsp *mcbsp)
 
 int omap_st_is_enabled(struct omap_mcbsp *mcbsp)
 {
-	struct omap_mcbsp_st_data *st_data;
-
-	st_data = mcbsp->st_data;
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 
 	if (!st_data)
 		return -ENODEV;
 
-
 	return st_data->enabled;
 }
 
-- 
1.7.8.4
