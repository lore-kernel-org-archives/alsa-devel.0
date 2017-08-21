From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Mon, 21 Aug 2017 11:36:24 -0700
Message-ID: <CABCoZhATXrkyxxgvVW5jAiZ4YYc600RQ55G_rFO4xN850cpM7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f193.google.com (mail-ua0-f193.google.com
 [209.85.217.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7F87266C78
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 20:36:26 +0200 (CEST)
Received: by mail-ua0-f193.google.com with SMTP id q40so1751905uag.2
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 11:36:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

>
> When num_params is defined as one in case of
> codec to codec dai link, there is no point in
> allocating memory for kcontrol.
>
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  include/sound/soc-dapm.h |   1 -
>  sound/soc/soc-dapm.c     | 147 ++++++++++++++++++++++++-----------------------

>>This is a very big change and that commit log doesn't describe it in any
>>detail or really motivate it.  What exactly does this do and why?

Currently in codec to codec dai link if there are multiple params defined then
dapm can use created kcontrol to decide which param to apply at runtime.

However, in case there is only single param configuration then there is no
point in creating the kcontrol (this is currently happening) and also there
is no point in allocating memory for kcontrol.

In the snd_soc_dapm_new_pcm function, there is memory allocation happening
for kcontrol which is later used or not used based on num_param. It is better
to not allocate memory when there is only a single configuration. This change
is to remedy that anomaly and also it remove unnecessary checks.
