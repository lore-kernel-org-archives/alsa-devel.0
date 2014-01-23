From: Olivier Langlois <olivier@trillion01.com>
Subject: [PATCH] alsa-libs: initialize pcm_dmix monotonic field
Date: Wed, 22 Jan 2014 19:04:45 -0500
Message-ID: <1390435485-15180-1-git-send-email-olivier@trillion01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy7-pub.mail.unifiedlayer.com
 (oproxy7-pub.mail.unifiedlayer.com [67.222.55.9])
 by alsa0.perex.cz (Postfix) with SMTP id 6FC99265099
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 01:05:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Olivier Langlois <olivier@trillion01.com>
List-Id: alsa-devel@alsa-project.org

not doing so, leaves the pcm object in an inconsistent state since
'info' field is copied from the slave which is then used when
snd_pcm_hw_params_is_monotonic() is called.

For instance, when using dmix with aplay and an underrun is occuring, the following
info is returned:

underrun!!! (at least 1248687948.256 ms long)
Status:
  state       : XRUN
  trigger_time: 1390347762.628483000
  tstamp      : 1390347766.184350000
  delay       : -635
  avail       : 15687
  avail_max   : 15675

now is computed from CLOCK_MONOTONIC while pcm status tstamps are from gettimeofday().

After the fix, underruns are still occuring on my setup but at least the displayed info
is correct:

underrun!!! (at least 7630.409 ms long)
Status:
  state       : XRUN
  trigger_time: 7652.739201431
  tstamp      : 7660.369600636
  delay       : -624
  avail       : 15676
  avail_max   : 15664

Signed-off-by: Olivier Langlois <olivier@trillion01.com>
---
 src/pcm/pcm_direct.c | 2 ++
 src/pcm/pcm_dmix.c   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 899c250..5416cf7 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -857,6 +857,7 @@ static void save_slave_setting(snd_pcm_direct_t *dmix, snd_pcm_t *spcm)
 	COPY_SLAVE(buffer_time);
 	COPY_SLAVE(sample_bits);
 	COPY_SLAVE(frame_bits);
+	COPY_SLAVE(monotonic);
 }
 
 #undef COPY_SLAVE
@@ -1220,6 +1221,7 @@ static void copy_slave_setting(snd_pcm_direct_t *dmix, snd_pcm_t *spcm)
 	COPY_SLAVE(buffer_time);
 	COPY_SLAVE(sample_bits);
 	COPY_SLAVE(frame_bits);
+	COPY_SLAVE(monotonic);
 
 	spcm->info &= ~SND_PCM_INFO_PAUSE;
 	spcm->boundary = recalc_boundary_size(dmix->shmptr->s.boundary, spcm->buffer_size);
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 2bd5d39..4aa6d4e 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -1104,7 +1104,7 @@ int snd_pcm_dmix_open(snd_pcm_t **pcmp, const char *name,
 		
 	pcm->poll_fd = dmix->poll_fd;
 	pcm->poll_events = POLLIN;	/* it's different than other plugins */
-		
+	pcm->monotonic = spcm->monotonic;
 	pcm->mmap_rw = 1;
 	snd_pcm_set_hw_ptr(pcm, &dmix->hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &dmix->appl_ptr, -1, 0);
-- 
1.8.5.3
