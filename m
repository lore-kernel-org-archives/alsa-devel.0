From: Stas Sergeev <stsp@list.ru>
Subject: Re: [PATCH] ASoC: define playback and capture streams
	in dummy codec
Date: Tue, 16 Apr 2013 20:34:56 +0400
Message-ID: <516D7DB0.5040804@list.ru>
References: <5167E7C4.7080501@list.ru>
 <20130412105943.GU9243@opensource.wolfsonmicro.com>
 <20130412181943.0338083b@stas> <516824B4.20802@gmail.com>
 <51682633.70008@list.ru> <51682747.9070300@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030909030001020800000306"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [94.100.177.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D6042610B1
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 18:35:04 +0200 (CEST)
In-Reply-To: <51682747.9070300@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, stsp@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030909030001020800000306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

12.04.2013 19:24, Gabriel M. Beddingfield =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 04/12/2013 08:20 AM, Stas Sergeev wrote:
>>> He means that the commit message. Your commit message says what the
>>> patch does. It does not say why the patch is needed.
>> Yes.
>> But what should I add to the commit message, if the
>> only thing I know about this patch, is that I am not getting
>> any sound without it? :) The reason should be obvious for
>> whoever is familiar with that subsystem, but its not me.
>>
>
> Yep, just formalize the "I am not getting any sound with it"
> statement. :-)
Hi, Would something like the attached patch be good to
help formalizing this? With that patch I am getting:
---
[    2.800190] asoc: no playback or capture streams
available                 =20
[    2.805158] asoc: can't create pcm
Pri_Dai                                 =20
[    2.809241] asoc: failed to instantiate card I2S: -22
---
which is much better than before.
If I get any ACKs on this one, I'll submit it too.

--------------030909030001020800000306
Content-Type: text/x-patch;
 name="a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a.diff"

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 394fb3b..fb3a401 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2140,6 +2140,11 @@ static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	if (codec_dai->driver->capture.channels_min)
 		capture = 1;
 
+	if (playback + capture == 0) {
+		pr_err("asoc: no playback or capture streams available\n");
+		return -EINVAL;
+	}
+
 	dev_dbg(rtd->card->dev, "registered pcm #%d %s\n",num,new_name);
 	ret = snd_pcm_new(rtd->card->snd_card, new_name,
 			num, playback, capture, &pcm);

--------------030909030001020800000306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030909030001020800000306--
