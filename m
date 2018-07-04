From: <twischer@de.adit-jv.com>
Subject: [PATCH - PCM rate 1/1] pcm: rate: Use signed variable
	for return of snd_pcm_avail_update
Date: Wed, 4 Jul 2018 13:28:56 +0200
Message-ID: <1530703736-2207-1-git-send-email-twischer@de.adit-jv.com>
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
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Without this changes a negative error code returned by
snd_pcm_avail_update() will be not handled correctly

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 4e0c7ca..031a43d 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -970,9 +970,12 @@ static snd_pcm_sframes_t snd_pcm_rate_avail_update(snd_pcm_t *pcm)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
 	snd_pcm_t *slave = rate->gen.slave;
-	snd_pcm_uframes_t slave_size;
+	snd_pcm_sframes_t slave_size;
 
 	slave_size = snd_pcm_avail_update(slave);
+	if (slave_size < 0)
+		return slave_size;
+
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE)
 		goto _capture;
 	snd_pcm_rate_sync_hwptr(pcm);
-- 
2.7.4
