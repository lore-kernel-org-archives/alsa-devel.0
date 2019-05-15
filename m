From: <vanitha.channaiah@in.bosch.com>
Subject: [PATCH v2 4/6] pcm: direct: Round up of slave_app_ptr
	pointer if buffer size is less than 2 period size.
Date: Wed, 15 May 2019 11:56:35 +0530
Message-ID: <1557901597-19215-5-git-send-email-vanitha.channaiah@in.bosch.com>
References: <1557901597-19215-1-git-send-email-vanitha.channaiah@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1557901597-19215-1-git-send-email-vanitha.channaiah@in.bosch.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: tiwai@suse.de, patch@alsa-project.org
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org, Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
List-Id: alsa-devel@alsa-project.org

From: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>

For buffer size less than two period size, the start position
of slave_app_ptr is rounded up in order to avoid xruns
For e.g.:
Considering below parameters and its values
Period size = 96
Buffer size = 191
slave_appl_ptr = slave_hw_ptr = unaligned value

Issue:
- During the start of the stream, app_ptr = hw_ptr = 0
- Application writes one period of data in the buffer i.e
  app_ptr = 96, hw_ptr = 0
- Now, the avail is just period-1 frames available.
  avail = hw_ptr + buffer_size - app_ptr = 95
  i.e. shortage of 1 frame space
- so application is waiting for the 1frame space to be available.
- slave_app_ptr and slave_hw_ptr would get updated to lower values
- This could lead to under run to occur.

Fix:
If we round Up the slave_app_ptr pointer,
- During the start of the stream, app_ptr = hw_ptr = 0
- Application writes one period of data in the buffer i.e
  app_ptr = 96, hw_ptr = 0
- Round Up of slave_app_ptr pointer leads to below calculation:
- slave_app_ptr rounded to 96
- slave_app_ptr and slave_hw_ptr would get updated to larger value nearing to 2 period size
- avail = greater than period size.
- Here, there is a lower chance of under run.

Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
---
 src/pcm/pcm_direct.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 54d9900..b56da85 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -2043,10 +2043,12 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 
 void snd_pcm_direct_reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
 {
-
+	/* For buffer size less than two period size, the start position
+	 * of slave app ptr is rounded up in order to avoid xruns
+	 */
 	if (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_ROUNDUP ||
 		(dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_AUTO &&
-		pcm->buffer_size <= pcm->period_size * 2))
+		pcm->buffer_size < pcm->period_size * 2))
 		dmix->slave_appl_ptr =
 			((dmix->slave_appl_ptr + dmix->slave_period_size - 1) /
 			dmix->slave_period_size) * dmix->slave_period_size;
-- 
2.7.4
