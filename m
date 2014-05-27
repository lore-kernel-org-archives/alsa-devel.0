From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/12] fireworks/bebob: Change type of argument
	for sampling rate
Date: Wed, 28 May 2014 00:14:40 +0900
Message-ID: <1401203687-4189-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id ACFF3265868
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:15:15 +0200 (CEST)
In-Reply-To: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, dan.carpenter@oracle.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Originally, I intent to this argument given with 'struct snd_pcm_runtime.rate'
or params_rate(). They return value of 'unsigned int'. So 'unsigned int' is
better for the type of this argument.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h                | 2 +-
 sound/firewire/bebob/bebob_stream.c         | 2 +-
 sound/firewire/fireworks/fireworks.h        | 2 +-
 sound/firewire/fireworks/fireworks_stream.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 91b26b0..6aef152 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -211,7 +211,7 @@ int snd_bebob_stream_discover(struct snd_bebob *bebob);
 int snd_bebob_stream_map(struct snd_bebob *bebob,
 			 struct amdtp_stream *stream);
 int snd_bebob_stream_init_duplex(struct snd_bebob *bebob);
-int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, int rate);
+int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate);
 void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_update_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 452e936..fbe938c 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -483,7 +483,7 @@ end:
 	return err;
 }
 
-int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, int rate)
+int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 {
 	struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
 	struct amdtp_stream *master, *slave;
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 14395e3..d2b36be 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -205,7 +205,7 @@ int snd_efw_command_get_sampling_rate(struct snd_efw *efw, unsigned int *rate);
 int snd_efw_command_set_sampling_rate(struct snd_efw *efw, unsigned int rate);
 
 int snd_efw_stream_init_duplex(struct snd_efw *efw);
-int snd_efw_stream_start_duplex(struct snd_efw *efw, int sampling_rate);
+int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate);
 void snd_efw_stream_stop_duplex(struct snd_efw *efw);
 void snd_efw_stream_update_duplex(struct snd_efw *efw);
 void snd_efw_stream_destroy_duplex(struct snd_efw *efw);
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index eaab8f6..5415690 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -195,7 +195,7 @@ end:
 	return err;
 }
 
-int snd_efw_stream_start_duplex(struct snd_efw *efw, int rate)
+int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 {
 	struct amdtp_stream *master, *slave;
 	atomic_t *slave_substreams;
-- 
1.8.3.2
