From: <twischer@de.adit-jv.com>
Subject: [PATCH] pcm: dmix: Align slave_hw_ptr to slave period
	boundary
Date: Mon, 29 Oct 2018 16:24:55 +0100
Message-ID: <1540826695-16021-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Laxmi Devi <Laxmi.Devi@in.bosch.com>, alsa-devel@alsa-project.org, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Laxmi Devi <Laxmi.Devi@in.bosch.com>

These changes are required due to the kernel commit 07b7acb51d283d8469696c906b91f1882696a4d4
("ASoC: rsnd: update pointer more accurate")

Issue is that snd_pcm_wait() goes back to waiting because the hw_ptr
is not period aligned. Therefore snd_pcm_wait() will block for a longer
time as required.

With these rcar driver changes the exact position of the dma is returned.
During snd_pcm_start they read hw_ptr as reference, and this hw_ptr
is now not period aligned, and is a little ahead over the period while it
is read. Therefore when the avail is calculated during snd_pcm_wait(),
it is missing the avail_min by a few frames.
Consider the below example:

Considering the application is trying to write 0x120 frames and the
period_size = 0x60, avail_min = 0x120 and buffersize = 0x360 :

rsnd_pointer=0x12c -> dma pointer at the end of second write during
snd_pcm_dmix_start().
Since another 0x120 buffer is available, application writes 0x120 and goes
to snd_pcm_wait().
It is woken up after 3 snd_pcm_period_elapsed() to see rsnd_pointer=0x248.
So hw_ptr = new_slave_hw_ptr - reference_slave_hw_ptr = 0x248 - 0x12c = 0x11c.
It needs 4 more frames to be able to write. And so it goes back to waiting.

But since 3 snd_pcm_period_elapsed(), 3 periods should be available and it
should have been able to write.
If rsnd_pointer during the start was 0x120 which is 3 periods
then 0x248 - 0x120 =  128 it could go on with write.

Signed-off-by: Laxmi Devi <Laxmi.Devi@in.bosch.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
We are not completely sure if this is the best approach but we had also no
better idea to solve this problem (with similar CPU usage).

Therefore if anyone has a better solution please feel free to describe
this one.

 src/pcm/pcm_dmix.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index a6a8f3a..d3e9319 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -560,11 +560,10 @@ static int snd_pcm_dmix_hwsync(snd_pcm_t *pcm)
 static void reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
 {
 	dmix->slave_appl_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
-	if (pcm->buffer_size > pcm->period_size * 2)
-		return;
-	/* If we have too litte periods, better to align the start position
-	 * to the period boundary so that the interrupt can be handled properly
-	 * at the right time.
+	dmix->slave_hw_ptr = ((dmix->slave_hw_ptr / dmix->slave_period_size)
+				* dmix->slave_period_size);
+	/* Better to align the start position to the period boundary so that
+	 * the interrupt can be handled properly at the right time.
 	 */
 	dmix->slave_appl_ptr = ((dmix->slave_appl_ptr + dmix->slave_period_size - 1)
 				/ dmix->slave_period_size) * dmix->slave_period_size;
-- 
2.7.4
