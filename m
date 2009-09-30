From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/2] pcm_rate_linear: Annotate unused function
	parameter to avoid compiler warnings.
Date: Wed, 30 Sep 2009 12:36:13 +0200
Message-ID: <1254306974-26016-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 376E0243DD
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 12:36:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Stefan Schmidt <stefan@slimlogic.co.uk>

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/pcm/pcm_rate_linear.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_rate_linear.c b/src/pcm/pcm_rate_linear.c
index 8b2d2d0..7481b38 100644
--- a/src/pcm/pcm_rate_linear.c
+++ b/src/pcm/pcm_rate_linear.c
@@ -405,15 +405,15 @@ static void linear_close(void *obj)
 	free(obj);
 }
 
-static int get_supported_rates(void *rate, unsigned int *rate_min,
-			       unsigned int *rate_max)
+static int get_supported_rates(ATTRIBUTE_UNUSED void *rate,
+			       unsigned int *rate_min, unsigned int *rate_max)
 {
 	*rate_min = SND_PCM_PLUGIN_RATE_MIN;
 	*rate_max = SND_PCM_PLUGIN_RATE_MAX;
 	return 0;
 }
 
-static void linear_dump(void *rate, snd_output_t *out)
+static void linear_dump(ATTRIBUTE_UNUSED void *rate, snd_output_t *out)
 {
 	snd_output_printf(out, "Converter: linear-interpolation\n");
 }
@@ -432,7 +432,8 @@ static const snd_pcm_rate_ops_t linear_ops = {
 	.dump = linear_dump,
 };
 
-int SND_PCM_RATE_PLUGIN_ENTRY(linear) (unsigned int version, void **objp, snd_pcm_rate_ops_t *ops)
+int SND_PCM_RATE_PLUGIN_ENTRY(linear) (ATTRIBUTE_UNUSED unsigned int version,
+				       void **objp, snd_pcm_rate_ops_t *ops)
 {
 	struct rate_linear *rate;
 
-- 
1.6.4.3
