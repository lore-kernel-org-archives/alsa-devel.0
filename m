From: "Aaron J. Grier" <agrier@poofygoof.com>
Subject: [PATCH - snd_pcm_sw_params_set_xfer_align doc update
	1add notes regarding snd_pcm_sw_params_set_xfer_align's
	deprecation and
Date: Thu, 31 Jul 2008 16:09:21 -0700
Message-ID: <1217545762-6229-1-git-send-email-agrier@poofygoof.com>
References: <s5hvdyriwol.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hvdyriwol.wl%tiwai@suse.de>
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
index ee2300e..a937b40 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -5694,6 +5694,17 @@ int snd_pcm_sw_params_get_period_event(const snd_pcm_sw_params_t *params, int *v
  * \param params Software configuration container
  * \param val Chunk size (frames are attempted to be transferred in chunks)
  * \return 0 otherwise a negative error code
+ *
+ * "There is no replacement; the transfer alignment always is one
+ * frame[.]" -- Clemens Ladisch <clemens@ladisch.de>
+ *
+ * "Note that the transfer alignment was really buggy, and didn't work
+ * at all like what you imagined from its name." -- Takashi Iwai
+ * <tiwai@suse.de>
+ *
+ * If fixed-size transfers are required, use \ref snd_pcm_avail_update
+ * if to determine the number of frames available before reading or
+ * writing.
  */
 #ifndef DOXYGEN
 int snd_pcm_sw_params_set_xfer_align(snd_pcm_t *pcm ATTRIBUTE_UNUSED, snd_pcm_sw_params_t *params ATTRIBUTE_UNUSED, snd_pcm_uframes_t val ATTRIBUTE_UNUSED)
-- 
1.5.4.1
