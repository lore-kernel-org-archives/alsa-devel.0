From: Caleb Crome <caleb@crome.org>
Subject: ASoC: multicodec: How to specify one codec as master
 and all others as slave
Date: Tue, 12 Jan 2016 15:24:05 -0800
Message-ID: <CAG5mAdxuEaKDyB6X=N0bqM1q5Ddg7OnGbSEC6po1bGieKBsPig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
 [209.85.213.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 11320260508
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 00:24:26 +0100 (CET)
Received: by mail-ig0-f173.google.com with SMTP id t15so132964116igr.0
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 15:24:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Roberto Fichera <kernel@tekno-soft.it>
List-Id: alsa-devel@alsa-project.org

Hi there,
   With a multi-codec setup, what's the 'correct' way to tell one
codec to be master (i.e. send bit/word clock) and all the others to be
slave?

For example, I've got 8 stereo codecs (4x aic34), labeled, say aic_a,
aic_b, aic_c, aic_d, aic_e, aic_f, aic_g, aic_h, and I want

aic_a:
SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_A

and all others to see
SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_DSP_A

Is there an elegant way to do that?

I see in soc-core.c:snd_soc_runtime_set_dai_fmt(rtd, dai_fmt) that it
sets all codecs to the same format, then flips the polarity for the
CPU.

It seems this is not really correct behavior in multicodec mode when
the codec is master, right?  Should there be some way to mark one of
the many possibilities as the master?

My current thinking is to not set snd_soc_dai_link.dai_fmt to prevent
snd_soc_runtime_set_dai_fmt from doing the wrong thing, then call each
individual snd_soc_dai_set_fmt from the init function.

Thanks,
  --Caleb
