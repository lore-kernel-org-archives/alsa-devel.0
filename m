From: sutar.mounesh@gmail.com
Subject: [PATCH v3 6/6] pcm:plug: save converter config
Date: Fri,  3 Mar 2017 15:28:29 +0530
Message-ID: <1488535109-11572-1-git-send-email-sutar.mounesh@gmail.com>
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
index 266707b..c643278 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -64,6 +64,10 @@ static int snd_pcm_plug_close(snd_pcm_t *pcm)
 	snd_pcm_plug_t *plug = pcm->private_data;
 	int err, result = 0;
 	free(plug->ttable);
+	if (plug->rate_converter) {
+		snd_config_delete((snd_config_t*)plug->rate_converter);
+		plug->rate_converter = NULL;
+	}
 	assert(plug->gen.slave == plug->req_slave);
 	if (plug->gen.close_slave) {
 		snd_pcm_unlink_hw_ptr(pcm, plug->req_slave);
@@ -1108,7 +1112,14 @@ int snd_pcm_plug_open(snd_pcm_t **pcmp,
 	plug->sformat = sformat;
 	plug->schannels = schannels;
 	plug->srate = srate;
-	plug->rate_converter = rate_converter;
+	if (rate_converter) {
+		if ((err = snd_config_copy((snd_config_t**)&plug->rate_converter,
+					   (snd_config_t *)rate_converter)) < 0) {
+			free(plug);
+			return err;
+		}
+	}
+
 	plug->gen.slave = plug->req_slave = slave;
 	plug->gen.close_slave = close_slave;
 	plug->route_policy = route_policy;
@@ -1119,6 +1130,10 @@ int snd_pcm_plug_open(snd_pcm_t **pcmp,
 	
 	err = snd_pcm_new(&pcm, SND_PCM_TYPE_PLUG, name, slave->stream, slave->mode);
 	if (err < 0) {
+		if (plug->rate_converter) {
+			snd_config_delete((snd_config_t*)plug->rate_converter);
+			plug->rate_converter = NULL;
+		}
 		free(plug);
 		return err;
 	}
-- 
2.7.4
