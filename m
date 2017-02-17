From: sutar.mounesh@gmail.com
Subject: [PATCH 4/6] pcm: status dump fix timestamp formatting
Date: Fri, 17 Feb 2017 12:47:36 +0530
Message-ID: <1487315856-9078-1-git-send-email-sutar.mounesh@gmail.com>
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

nanosecond part formatted with %06 will give incorrect/confusing results:

trigger_time: 154.9748287
trigger_time: 154.60109090
trigger_time: 154.110425257

time seems to run backwards...

This patch converts to us before printing
which gives the correct/expected result:

trigger_time: 154.009748
trigger_time: 154.060109
trigger_time: 154.110425

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 493e903..a16fd86 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -2194,9 +2194,10 @@ int snd_pcm_status_dump(snd_pcm_status_t *status, snd_output_t *out)
 	assert(status);
 	snd_output_printf(out, "  state       : %s\n", snd_pcm_state_name((snd_pcm_state_t) status->state));
 	snd_output_printf(out, "  trigger_time: %ld.%06ld\n",
-		status->trigger_tstamp.tv_sec, status->trigger_tstamp.tv_nsec);
+			  status->trigger_tstamp.tv_sec,
+			  status->trigger_tstamp.tv_nsec / 1000);
 	snd_output_printf(out, "  tstamp      : %ld.%06ld\n",
-		status->tstamp.tv_sec, status->tstamp.tv_nsec);
+		status->tstamp.tv_sec, status->tstamp.tv_nsec / 1000);
 	snd_output_printf(out, "  delay       : %ld\n", (long)status->delay);
 	snd_output_printf(out, "  avail       : %ld\n", (long)status->avail);
 	snd_output_printf(out, "  avail_max   : %ld\n", (long)status->avail_max);
-- 
2.7.4
