From: <twischer@de.adit-jv.com>
Subject: [PATCH - dmix v3 1/1] pcm: dmix: Align slave_hw_ptr to
	slave period boundary
Date: Tue, 6 Nov 2018 13:52:53 +0100
Message-ID: <1541508773-32718-1-git-send-email-twischer@de.adit-jv.com>
References: <bdf2f9ca-7ff1-40cb-271d-4a83b32ccf56@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <bdf2f9ca-7ff1-40cb-271d-4a83b32ccf56@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, patch@alsa-project.org
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

With this patch the slave_hw_ptr will always contain a period align value.

 src/pcm/pcm_dmix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 881154e..6c9e052 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -398,6 +398,8 @@ static int snd_pcm_dmix_sync_ptr0(snd_pcm_t *pcm, snd_pcm_uframes_t slave_hw_ptr
 	snd_pcm_sframes_t diff;
 	
 	old_slave_hw_ptr = dmix->slave_hw_ptr;
+	slave_hw_ptr = ((slave_hw_ptr / dmix->slave_period_size)
+				*  dmix->slave_period_size);
 	dmix->slave_hw_ptr = slave_hw_ptr;
 	diff = slave_hw_ptr - old_slave_hw_ptr;
 	if (diff == 0)		/* fast path */
@@ -560,6 +562,8 @@ static int snd_pcm_dmix_hwsync(snd_pcm_t *pcm)
 static void reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
 {
 	dmix->slave_appl_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
+	dmix->slave_hw_ptr = ((dmix->slave_hw_ptr / dmix->slave_period_size)
+				* dmix->slave_period_size);
 	if (pcm->buffer_size > pcm->period_size * 2)
 		return;
 	/* If we have too litte periods, better to align the start position
-- 
2.7.4
