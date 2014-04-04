From: Andrew Eikum <aeikum@codeweavers.com>
Subject: [PATCH alsa-lib] pcm: rate: Don't return negative
 frame count on success in rewind
Date: Fri, 4 Apr 2014 13:27:25 -0500
Message-ID: <20140404182725.GQ24575@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_rewind is documented to return <0 on failure and >=0 on
success.

Signed-off-by: Andrew Eikum <aeikum@codeweavers.com>
---
I checked all other rewind implementations, and this was the only one
that obviously had this bug.

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 54a3e67..2eb4b1b 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -702,7 +702,7 @@ static snd_pcm_sframes_t snd_pcm_rate_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
 	snd_atomic_write_begin(&rate->watom);
 	n = snd_pcm_rate_move_applptr(pcm, -frames);
 	snd_atomic_write_end(&rate->watom);
-	return n;
+	return n < 0 ? -n : n;
 }
 
 static snd_pcm_sframes_t snd_pcm_rate_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
-- 
1.9.1
