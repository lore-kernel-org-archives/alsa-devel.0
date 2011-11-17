From: Timo Juhani Lindfors <timo.lindfors@iki.fi>
Subject: [PATCH] wm8753: Skip noop reconfiguration of DAI mode
Date: Thu, 17 Nov 2011 02:52:50 +0200
Message-ID: <1321491170-12297-1-git-send-email-timo.lindfors@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsi1.inet.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B9861039C6
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 01:52:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, ian@opensource.wolfsonmicro.com, dp@opensource.wolfsonmicro.com
Cc: Timo Juhani Lindfors <timo.lindfors@iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch makes it possible to set DAI mode to its currently applied
value even if codec is active. This is necessary to allow

aplay -t raw -r 44100 -f S16_LE -c 2 < /dev/urandom &
alsactl store -f backup.state
alsactl restore -f backup.state

to work without returning errors. This patch is based on a patch sent
by Klaus Kurzmann <mok@fluxnetz.de>.

Signed-off-by: Timo Juhani Lindfors <timo.lindfors@iki.fi>
---
 sound/soc/codecs/wm8753.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index a950471..3a629d0 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -190,6 +190,9 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	u16 ioctl;
 
+	if (wm8753->dai_func == ucontrol->value.integer.value[0])
+		return 0;
+
 	if (codec->active)
 		return -EBUSY;
 
-- 
1.7.2.5
