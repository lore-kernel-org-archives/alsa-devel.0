From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/34] pcm: change code formatting for
	snd_pcm_direct_initialize_poll_fd()
Date: Thu, 14 Jul 2016 23:07:24 +0900
Message-ID: <1468505271-5769-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 4F35826590B
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:08 +0200 (CEST)
In-Reply-To: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit applies code format according to typical and moderate rule,
for snd_pcm_direct_initialize_poll_fd().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_direct.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 5984d7f..8a53cef 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1189,14 +1189,16 @@ int snd_pcm_direct_initialize_poll_fd(snd_pcm_direct_t *dmix)
 		return ret;
 	}
 	sprintf(name, "hw:CLASS=%i,SCLASS=0,CARD=%i,DEV=%i,SUBDEV=%i",
-				(int)SND_TIMER_CLASS_PCM, 
-				snd_pcm_info_get_card(info),
-				snd_pcm_info_get_device(info),
-				snd_pcm_info_get_subdevice(info) * 2 + capture);
-	ret = snd_timer_open(&dmix->timer, name, SND_TIMER_OPEN_NONBLOCK | SND_TIMER_OPEN_TREAD);
+		(int)SND_TIMER_CLASS_PCM,
+		snd_pcm_info_get_card(info),
+		snd_pcm_info_get_device(info),
+		snd_pcm_info_get_subdevice(info) * 2 + capture);
+	ret = snd_timer_open(&dmix->timer, name,
+			     SND_TIMER_OPEN_NONBLOCK | SND_TIMER_OPEN_TREAD);
 	if (ret < 0) {
 		dmix->tread = 0;
-		ret = snd_timer_open(&dmix->timer, name, SND_TIMER_OPEN_NONBLOCK);
+		ret = snd_timer_open(&dmix->timer, name,
+				     SND_TIMER_OPEN_NONBLOCK);
 		if (ret < 0) {
 			SNDERR("unable to open timer '%s'", name);
 			return ret;
-- 
2.7.4
