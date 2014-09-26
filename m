From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: codec->card removed
Date: Fri, 26 Sep 2014 15:19:47 -0400
Message-ID: <CAKON4OyqRaUxKPc0C2ALwOwvqeToMeSM25CJj9p00ndovh1ZSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 1667C2604EA
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 21:19:48 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id pv20so5416323lab.24
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 12:19:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

How should I rewrite this to reflect that codec->card has been removed?
This is codec is on the SOC chip, not an external one.

static int sunxi_codec_trigger(struct snd_pcm_substream *substream, int
cmd, struct snd_soc_dai *dai) {
struct snd_soc_pcm_runtime *rtd = substream->private_data;
struct snd_soc_dai *codec_dai = rtd->codec_dai;
struct snd_soc_codec *codec = codec_dai->codec;
struct snd_soc_card *card = codec->card;
struct sunxi_priv *priv = snd_soc_card_get_drvdata(card);
...

Complete file...
https://bitbucket.org/emiliolopez/linux/src/fbfc3e9c092c90574aee454062fc465e8c71703c/sound/soc/sunxi/sunxi-codec.c?at=sunxi-codec-exp


-- 
Jon Smirl
jonsmirl@gmail.com
