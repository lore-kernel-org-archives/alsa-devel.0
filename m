From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 2/2] ASoC: Fix WM9712 mixer_event DAPM widget
	function type
Date: Thu, 28 Feb 2008 11:53:10 +0200
Message-ID: <1204192390-16304-3-git-send-email-jarkko.nikula@nokia.com>
References: <1204192390-16304-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B8FF524533
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 10:53:18 +0100 (CET)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m1S9rD1P018288
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 11:53:16 +0200
In-Reply-To: <1204192390-16304-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Add kcontrol argument to function since the API was changed by the commit
9af6d9562414568ecadf96aaef5b88e7e8b19821.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/wm9712.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 590baea..524f745 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -176,7 +176,8 @@ static int wm9712_add_controls(struct snd_soc_codec *codec)
  * the codec only has a single control that is shared by both channels.
  * This makes it impossible to determine the audio path.
  */
-static int mixer_event (struct snd_soc_dapm_widget *w, int event)
+static int mixer_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
 {
 	u16 l, r, beep, line, phone, mic, pcm, aux;
 
-- 
1.5.3.8
