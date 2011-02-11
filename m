From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Ensure supplies are maintained for force
	enabled widgets
Date: Fri, 11 Feb 2011 11:44:13 +0000
Message-ID: <1297424653-20320-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03FD324525
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 12:43:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, swarren@nvidia.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If a widget has been force enabled then not only do we need to keep the
widget itself enabled, we also need to keep any supplies the widget
requires enabled. The user could force all the individual widgets on but
this requires too much knowledge of device internals.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This is only compile tested so far.

 sound/soc/soc-dapm.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b30eda6..1bd24d5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -712,7 +712,15 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 		    !path->connected(path->source, path->sink))
 			continue;
 
-		if (path->sink && path->sink->power_check &&
+		if (!path->sink)
+			continue;
+
+		if (path->sink->force) {
+			power = 1;
+			break;
+		}
+
+		if (path->sink->power_check &&
 		    path->sink->power_check(path->sink)) {
 			power = 1;
 			break;
-- 
1.7.2.3
