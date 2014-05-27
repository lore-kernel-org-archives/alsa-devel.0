From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/12] fireworks/bebob: Use the same type of
	variables as function parameters
Date: Wed, 28 May 2014 00:14:41 +0900
Message-ID: <1401203687-4189-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id B09F5265869
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

The second argument of snd_efw_command_get_sampling_rate() means sampling
rate and its type is 'unsigned int'. But 'int' variable is passed as parameter.
It's better to apply the same type for the variable as its argument.

Similally, the type of variable for snd_efw_command_get_clock_source() and
avc_bridgeco_get_plug_type() should be the same type as each argument.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c      | 3 ++-
 sound/firewire/fireworks/fireworks_pcm.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index fbe938c..38aee33 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -852,7 +852,8 @@ static int
 seek_msu_sync_input_plug(struct snd_bebob *bebob)
 {
 	u8 plugs[AVC_PLUG_INFO_BUF_BYTES], addr[AVC_BRIDGECO_ADDR_BYTES];
-	unsigned int i, type;
+	unsigned int i;
+	enum avc_bridgeco_plug_type type;
 	int err;
 
 	/* Get the number of Music Sub Unit for both direction. */
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index ed211d0..8a34753 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -195,8 +195,8 @@ end:
 static int pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_efw *efw = substream->private_data;
-	int sampling_rate;
-	unsigned int clock_source;
+	unsigned int sampling_rate;
+	enum snd_efw_clock_source clock_source;
 	int err;
 
 	err = snd_efw_stream_lock_try(efw);
-- 
1.8.3.2
