From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH RFC 1/1] ASoC: WL1273 FM Radio: Eliminate
	unnecessary error return value.
Date: Fri, 10 Sep 2010 10:41:30 +0300
Message-ID: <1284104490-11226-2-git-send-email-matti.j.aaltonen@nokia.com>
References: <1284104490-11226-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AEC4244A5
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:41:45 +0200 (CEST)
In-Reply-To: <1284104490-11226-1-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

With this change it's not a error to call wl1273_set_audio_route
when the codec is active if the new routing value is the same
as the current active setting.

Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
---
 sound/soc/codecs/wl1273.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index a2323be..1bb0c83 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -50,6 +50,9 @@ static int wl1273_set_audio_route(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 
+	if (wl1273->mode == ucontrol->value.integer.value[0])
+		return 0;
+
 	/* Do not allow changes while stream is running */
 	if (codec->active)
 		return -EPERM;
-- 
1.6.1.3
