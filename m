From: sutar.mounesh@gmail.com
Subject: [PATCH v5 6/6] pcm:plug: save converter config
Date: Tue, 21 Mar 2017 18:28:18 +0530
Message-ID: <1490101098-24998-1-git-send-email-sutar.mounesh@gmail.com>
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

Passed config is freed after call to open, thus it is invalid when
trying to extract the converter name. So config entry is saved
for later usage.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index 266707b..c4375ec 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -50,7 +50,7 @@ typedef struct {
 	snd_pcm_format_t sformat;
 	int schannels;
 	int srate;
-	const snd_config_t *rate_converter;
+	snd_config_t *rate_converter;
 	enum snd_pcm_plug_route_policy route_policy;
 	snd_pcm_route_ttable_entry_t *ttable;
 	int ttable_ok;
@@ -64,6 +64,10 @@ static int snd_pcm_plug_close(snd_pcm_t *pcm)
 	snd_pcm_plug_t *plug = pcm->private_data;
 	int err, result = 0;
 	free(plug->ttable);
+        if (plug->rate_converter) {
+                snd_config_delete(plug->rate_converter);
+                plug->rate_converter = NULL;
+        }
 	assert(plug->gen.slave == plug->req_slave);
 	if (plug->gen.close_slave) {
 		snd_pcm_unlink_hw_ptr(pcm, plug->req_slave);
@@ -1108,7 +1112,6 @@ int snd_pcm_plug_open(snd_pcm_t **pcmp,
 	plug->sformat = sformat;
 	plug->schannels = schannels;
 	plug->srate = srate;
-	plug->rate_converter = rate_converter;
 	plug->gen.slave = plug->req_slave = slave;
 	plug->gen.close_slave = close_slave;
 	plug->route_policy = route_policy;
@@ -1125,6 +1128,15 @@ int snd_pcm_plug_open(snd_pcm_t **pcmp,
 	pcm->ops = &snd_pcm_plug_ops;
 	pcm->fast_ops = slave->fast_ops;
 	pcm->fast_op_arg = slave->fast_op_arg;
+	if (rate_converter) {
+		err = snd_config_copy(&plug->rate_converter,
+				     (snd_config_t *)rate_converter);
+		if (err < 0) {
+			snd_pcm_free(pcm);
+			free(plug);
+			return err;
+		}
+	}
 	pcm->private_data = plug;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-- 
2.7.4
