From: sutar.mounesh@gmail.com
Subject: [PATCH 1/2] plugin:dshare: wrong state reporting
Date: Tue,  4 Apr 2017 11:59:52 +0530
Message-ID: <1491287392-11251-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: Mounesh Sutar <sutar.mounesh@gmail.com>, alsa-devel@alsa-project.org, Andreas Pape <apape@de.adit-jv.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

If plugin dshare detects underrun, it reports this to the user
via return value -EPIPE and setting dshare state to 'xrun' which is correct.
But, if user after this wants to check the stream state, it is misleadingly
reported as 'running' instead of 'xrun'.
With this behavior aplay e.g. will not do a proper underrun handling
(restarting stream) but terminates streaming.
This is due to plugin dshare always returns state of the slave pcm,
in pcm_ops->state() which is not correct.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>

diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 331f799..4c57fb4 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -244,7 +244,7 @@ static int snd_pcm_dshare_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 	default:
 		break;
 	}
-
+	status->state = snd_pcm_state(pcm);
 	status->trigger_tstamp = dshare->trigger_tstamp;
 	status->avail = snd_pcm_mmap_playback_avail(pcm);
 	status->avail_max = status->avail > dshare->avail_max ? status->avail : dshare->avail_max;
-- 
2.7.4
