From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ASoC]Changing the order of trigger in
	soc_pcm_trigger
Date: Wed, 6 Jun 2007 18:54:06 +0530
Message-ID: <8d6898730706060624h72b75c51m8b317f1769e912c1@mail.gmail.com>
References: <8d6898730706060606ree4bb6ahf8b4fd0b07453408@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5201324490
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2007 15:24:08 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so179419wag
	for <alsa-devel@alsa-project.org>; Wed, 06 Jun 2007 06:24:07 -0700 (PDT)
In-Reply-To: <8d6898730706060606ree4bb6ahf8b4fd0b07453408@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I feel i am wrong because as soon as controller is triggered it will
request for data from DMA.
 So this is my controller implementation problem.

On 6/6/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> Liam,
>
> I have one suggestion.
>
> Can we use this
>
> if (rtd->codec_dai->ops.trigger) {
>                 ret = rtd->codec_dai->ops.trigger(substream, cmd);
>                 if (ret < 0)
>                         return ret;
>         }
>
> if (rtd->cpu_dai->ops.trigger) {
>         ret = rtd->cpu_dai->ops.trigger(substream, cmd);
>         if (ret < 0)
>                 return ret;
> }
> if (platform->pcm_ops->trigger) {
>         ret = platform->pcm_ops->trigger(substream, cmd);
>         if (ret < 0)
>                 return ret;
> }
>
> Instead of
>
> if (rtd->codec_dai->ops.trigger) {
>                 ret = rtd->codec_dai->ops.trigger(substream, cmd);
>                 if (ret < 0)
>                         return ret;
>         }
>
> if (platform->pcm_ops->trigger) {
>         ret = platform->pcm_ops->trigger(substream, cmd);
>         if (ret < 0)
>                 return ret;
> }
>
> if (rtd->cpu_dai->ops.trigger) {
>         ret = rtd->cpu_dai->ops.trigger(substream, cmd);
>         if (ret < 0)
>                 return ret;
> }
>
>
> That means trigger the Cpu before pcm. Because most of the controllers
> needs to be initialized and triggered before external DMA is
> triggered.
>
> Correct me if i am going wrong.
>
> This was causing so many problems in my hardware.
>
> Nobin Mathew
>
