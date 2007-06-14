From: vignesh babu <vignesh.babu@wipro.com>
Subject: [KJ] [PATCH]is_power_of_2-sound/pcm_params.h
Date: Thu, 14 Jun 2007 13:39:52 +0530
Message-ID: <1181808592.2474.13.camel@merlin.linuxcoe.com>
Reply-To: vignesh.babu@wipro.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/kernel-janitors>
List-Post: <mailto:kernel-janitors@lists.linux-foundation.org>
List-Help: <mailto:kernel-janitors-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.linux-foundation.org?subject=subscribe>
Sender: kernel-janitors-bounces@lists.linux-foundation.org
Errors-To: kernel-janitors-bounces@lists.linux-foundation.org
To: perex@suse.cz
Cc: Kernel Janitors List <kernel-janitors@lists.osdl.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Replacing (n & (n-1)) in the context of power of 2 checks
with is_power_of_2

Signed-off-by: vignesh babu <vignesh.babu@wipro.com>
--- 
diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 85cf1cf..dee298e 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -21,6 +21,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
+#include <linux/log2.h>
 
 int snd_pcm_hw_param_first(struct snd_pcm_substream *pcm, 
 			   struct snd_pcm_hw_params *params,
@@ -170,7 +171,7 @@ static inline int snd_mask_single(const struct snd_mask *mask)
 	for (i = 0; i < SNDRV_MASK_SIZE; i++) {
 		if (! mask->bits[i])
 			continue;
-		if (mask->bits[i] & (mask->bits[i] - 1))
+		if (!is_power_of_2(mask->bits[i]))
 			return 0;
 		if (c)
 			return 0;

-- 
Vignesh Babu BM 
_____________________________________________________________ 
"Why is it that every time I'm with you, makes me believe in magic?"
