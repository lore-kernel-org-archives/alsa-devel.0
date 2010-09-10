From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: crash with assertion (?)
Date: Sat, 11 Sep 2010 07:20:29 +0800
Message-ID: <AANLkTikqYR8WpfkT+5_1J1nQreo-KOyfnRCZ4yJ-5KJK@mail.gmail.com>
References: <4C8662AD.1040607@iem.at> <4C8670FD.5020906@ladisch.de>
	<4C874C1E.8040007@iem.at>
	<AANLkTi=5nxDDyfsUrvF3z+EpApiAjau6hbLK=a08WnKr@mail.gmail.com>
	<4C88AC51.9030803@iem.at>
	<AANLkTi=DVhWmzSvSDQW8+_vzCCDPp+aquy8LcTEFq0xY@mail.gmail.com>
	<4C89D8E8.2080305@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7EF7324644
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Sep 2010 01:20:33 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2114753ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 16:20:29 -0700 (PDT)
In-Reply-To: <4C89D8E8.2080305@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/10 Clemens Ladisch <clemens@ladisch.de>

> Raymond Yau wrote:
> > Yes, I can reprodued the assertion with a patched intel8x0 driver inside
> > virtualbox
> > since there is no error when using the emulated ac97 controller and codec
> > which support 8000Hz<->48000Hz
>
> How exactly did you patch it?
>

based on his log and his card seem support rate 48000 and 96000 only

 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000

the assertion also occur with snd-dummy model=ac97 with the above change in
rate constraint on Fedora 13

may need the output of alsa-info.sh to find out his ac97 codec and
snd_pcm_dump to find out the resampler
