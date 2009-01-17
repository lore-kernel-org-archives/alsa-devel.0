From: Stefanie <21_halfthetruth@web.de>
Subject: Re: hda_codec: Unknown model for ALC268
Date: Sat, 17 Jan 2009 22:39:45 +0100
Message-ID: <49725021.5050708@web.de>
References: <49691579.2070600@web.de> <20090112020424.GB7505@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id EEE061037FD
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 22:37:37 +0100 (CET)
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 528E9F6AB2FC
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 22:37:37 +0100 (CET)
Received: from [80.142.253.233] (helo=Mescalin.local)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1LOIrJ-00070W-00
	for alsa-devel@alsa-project.org; Sat, 17 Jan 2009 22:37:37 +0100
In-Reply-To: <20090112020424.GB7505@localhost>
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
List-Id: alsa-devel@alsa-project.org

Hello Fengguang,

thanks for your answer.

Wu Fengguang wrote:
> Hi Stefanie,
>
> There are some pre-defined models for ALC268:
>
> static const char *alc268_models[ALC268_MODEL_LAST] = {
>         [ALC267_QUANTA_IL1]     = "quanta-il1",
>         [ALC268_3ST]            = "3stack",
>         [ALC268_TOSHIBA]        = "toshiba",
>         [ALC268_ACER]           = "acer",
>         [ALC268_ACER_DMIC]      = "acer-dmic",
>         [ALC268_ACER_ASPIRE_ONE]        = "acer-aspire",
>         [ALC268_DELL]           = "dell",
>         [ALC268_ZEPTO]          = "zepto",
> #ifdef CONFIG_SND_DEBUG
>         [ALC268_TEST]           = "test",
> #endif  
>         [ALC268_AUTO]           = "auto",
> };      
>
> You can try them with commands like
>
>         modprobe snd-hda-intel model=3stack
>
> and report the one works for you, so that we integrate this knowledge
> into future kernel versions.
>   

I've loaded the module with different model parameters. Afterwards, I
tried alsamixer. As this didn't work, I used aumix to maximize all
levels. Finally, I used aplay to play some audio files.

"quanta-il1", "toshiba":

from alsamixer:
  ALSA lib simple_none.c:1520:(simple_add1) helem (MIXER,'Headphone
Playback Switch',0,2,0) appears twice or more
  alsamixer: function snd_mixer_load failed: Invalid argument

-works, but hardly audible


"dell":

Too many audio devices

from alsamixer:
  ALSA lib simple_none.c:1520:(simple_add1) helem (MIXER,'Headphone
Playback Switch',0,2,0) appears twice or more
  alsamixer: function snd_mixer_load failed: Invalid argument

-works, but hardly audible


"acer", "acer-aspire":

from alsamixer:
  ALSA lib simple_none.c:1520:(simple_add1) helem (MIXER,'Master
Playback Switch',0,2,0) appears twice or more
  alsamixer: function snd_mixer_load failed: Invalid argument

-nothing audible


"3stack", "acer-dmic", "zepto", "test", and "auto":

  HDA Intel: probe of 0000:00:1b.0 failed with error -16



> You are also welcome to provide your hardware information by running 
>         http://www.alsa-project.org/alsa-info.sh
> and upload the data collected by it.
>   

http://www.alsa-project.org/db/?f=1db7143668062f92f8cab7c2c214744743b96d44


Yours,
Stefanie
