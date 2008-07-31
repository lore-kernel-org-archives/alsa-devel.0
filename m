From: "Aaron J. Grier" <agrier@poofygoof.com>
Subject: [PATCH - snd_pcm_sw_params_set_xfer_align doc update
	2fix grammatical error
Date: Thu, 31 Jul 2008 16:09:22 -0700
Message-ID: <1217545762-6229-2-git-send-email-agrier@poofygoof.com>
References: <s5hvdyriwol.wl%tiwai@suse.de>
	<1217545762-6229-1-git-send-email-agrier@poofygoof.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1217545762-6229-1-git-send-email-agrier@poofygoof.com>
In-Reply-To: <s5hvdyriwol.wl%tiwai@suse.de>
References: <s5hvdyriwol.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Aaron J. Grier" <agrier@poofygoof.com>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Aaron J. Grier <agrier@poofygoof.com>

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index a937b40..ada697a 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -5703,7 +5703,7 @@ int snd_pcm_sw_params_get_period_event(const snd_pcm_sw_params_t *params, int *v
  * <tiwai@suse.de>
  *
  * If fixed-size transfers are required, use \ref snd_pcm_avail_update
- * if to determine the number of frames available before reading or
+ * to determine the number of frames available before reading or
  * writing.
  */
 #ifndef DOXYGEN
-- 
1.5.4.1
