From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/34] pcm: remove alloca() from
	snd_pcm_direct_initialize_poll_fd()
Date: Thu, 14 Jul 2016 23:07:25 +0900
Message-ID: <1468505271-5769-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 3E33B2658ED
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

Both of alloca() and automatic variables keeps storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_direct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 8a53cef..dbd7e2b 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1176,23 +1176,22 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 int snd_pcm_direct_initialize_poll_fd(snd_pcm_direct_t *dmix)
 {
 	int ret;
-	snd_pcm_info_t *info;
+	snd_pcm_info_t info = {0};
 	char name[128];
 	int capture = dmix->type == SND_PCM_TYPE_DSNOOP ? 1 : 0;
 
 	dmix->tread = 1;
 	dmix->timer_need_poll = 0;
-	snd_pcm_info_alloca(&info);
-	ret = snd_pcm_info(dmix->spcm, info);
+	ret = snd_pcm_info(dmix->spcm, &info);
 	if (ret < 0) {
 		SNDERR("unable to info for slave pcm");
 		return ret;
 	}
 	sprintf(name, "hw:CLASS=%i,SCLASS=0,CARD=%i,DEV=%i,SUBDEV=%i",
 		(int)SND_TIMER_CLASS_PCM,
-		snd_pcm_info_get_card(info),
-		snd_pcm_info_get_device(info),
-		snd_pcm_info_get_subdevice(info) * 2 + capture);
+		snd_pcm_info_get_card(&info),
+		snd_pcm_info_get_device(&info),
+		snd_pcm_info_get_subdevice(&info) * 2 + capture);
 	ret = snd_timer_open(&dmix->timer, name,
 			     SND_TIMER_OPEN_NONBLOCK | SND_TIMER_OPEN_TREAD);
 	if (ret < 0) {
-- 
2.7.4
