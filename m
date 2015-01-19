From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: wm97xx touch does not work after ac97 delayed dev
	reg removal
Date: Mon, 19 Jan 2015 19:28:42 +0100
Message-ID: <54BD4CDA.50309@metafoo.de>
References: <CAOLZvyE3tEec4QpdeYrJwNJEjcf18zodjF1XtQjzaeRdHA32wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060600070806020902030806"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-175.synserver.de
 [212.40.185.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 517472612D1
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 19:26:48 +0100 (CET)
In-Reply-To: <CAOLZvyE3tEec4QpdeYrJwNJEjcf18zodjF1XtQjzaeRdHA32wg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060600070806020902030806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 01/19/2015 04:46 PM, Manuel Lauss wrote:
> Hi Lars,
>
> Since commit 6794f709b7124ff1e574c4f4c9494418ab56c4b4
> (ASoC: ac97: Drop delayed device registration) the wm9712 ts on
> my MIPS DB1300 board doesn't work any more:
>
> wm97xx-ts 0-0:wm9712-codec.1: Device with vendor 0000 is not a wm97xx
> db1200-ac97 db1300-ac97.0: wm9712-hifi <-> au1xpsc_ac97.1 mapping ok
> wm9712-codec wm9712-codec.1: ASoC: mux Differential Source has no paths
> wm9712-codec wm9712-codec.1: ASoC: mux Capture Phone Mux has no paths
> db1200-ac97 db1300-i2s.0: wm8731-hifi <-> au1xpsc_i2s.2 mapping ok
>
> whereas before this patch:
> [    1.820000] db1200-ac97 db1300-ac97.0: wm9712-hifi <->
> au1xpsc_ac97.1 mapping ok
> [    1.820000] wm9712-codec wm9712-codec.1: ASoC: mux Differential
> Source has no paths
> [    1.830000] wm9712-codec wm9712-codec.1: ASoC: mux Capture Phone
> Mux has no paths
> [    1.840000] wm97xx-ts 0-0:wm9712-codec.1: detected a wm9712 codec
> [    1.850000] input: wm97xx touchscreen as
> /devices/platform/db1300-ac97.0/0-0:wm9712-codec.1/input/input0
> [    1.860000] db1200-ac97 db1300-i2s.0: wm8731-hifi <-> au1xpsc_i2s.2
> mapping ok
>
>
> Do you have any ideas how to solve this?

For a proper fix probably rewrite the AC97 bus support. But can you try if the 
attached patch works as a workaround?

Thanks,
- Lars


--------------060600070806020902030806
Content-Type: text/x-diff;
 name="0001-ASoC-wm9712-Reset-before-registering-AC97-device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ASoC-wm9712-Reset-before-registering-AC97-device.patch"

>From f75567f0966ce55e03cfae295fafded37bd8d0e7 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 19 Jan 2015 19:25:09 +0100
Subject: [PATCH] ASoC: wm9712: Reset before registering AC97 device

---
 sound/soc/codecs/wm9712.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index e04643d..998c140 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -666,6 +666,10 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
+	ret = wm9712_reset(codec, 0);
+	if (ret < 0)
+		return ret;
+
 	wm9712->ac97 = snd_soc_new_ac97_codec(codec);
 	if (IS_ERR(wm9712->ac97)) {
 		ret = PTR_ERR(wm9712->ac97);
@@ -673,18 +677,10 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	ret = wm9712_reset(codec, 0);
-	if (ret < 0)
-		goto reset_err;
-
 	/* set alc mux to none */
 	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);
 
 	return 0;
-
-reset_err:
-	snd_soc_free_ac97_codec(wm9712->ac97);
-	return ret;
 }
 
 static int wm9712_soc_remove(struct snd_soc_codec *codec)
-- 
1.7.10.4


--------------060600070806020902030806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060600070806020902030806--
