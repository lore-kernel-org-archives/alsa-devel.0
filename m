From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: Re: ASoC: WM8804: fsi-wm8804
Date: Mon, 15 Nov 2010 15:54:14 +0100
Message-ID: <4CE14996.1060702@elproma.com.pl>
References: <4CE126FD.7000407@elproma.com.pl>
	<20101115123351.GB3338@sirena.org.uk>
	<4CE139CF.4070400@elproma.com.pl>
	<20101115135053.GC3338@sirena.org.uk>
	<4CE13DC8.30007@elproma.com.pl>
	<20101115140604.GD12986@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout.mailmx.agnat.pl
	[193.239.44.238])
	by alsa0.perex.cz (Postfix) with ESMTP id E79C510385B
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 15:54:15 +0100 (CET)
In-Reply-To: <20101115140604.GD12986@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> You need to enable this at the *top* of the file rather than part way
> through it - in particular, it needs to be before any #includes.
>   
Sorry about that, now it tells much more :) So what I did wrong was the 
.codec_name in snd_soc_dai_link structure. I have defined it as 
"wm8804.0-003a" while it should be "wm8804.1-003a". Btw. I know that 
003a represents the I2C address of the codec, but what this '1' or '0' 
stands for (that I had mistaken) ?

best regards,
Greg

(...)
Nov 15 14:24:15 ecovec kernel: wm8804 1-003a: codec register 1-003a
Nov 15 14:24:15 ecovec kernel: wm8804 1-003a: dai register 1-003a #1
Nov 15 14:24:15 ecovec kernel: Registered DAI 'wm8804-spdif'
Nov 15 14:24:15 ecovec kernel: Registered codec 'wm8804.1-003a'
(....)
Nov 15 14:24:15 ecovec kernel: Registered platform 'sh_fsi.0'
Nov 15 14:24:15 ecovec kernel: fsi-pcm-audio sh_fsi.0: dai register 
sh_fsi.0 #2
Nov 15 14:24:15 ecovec kernel: Registered DAI 'fsia-dai'
Nov 15 14:24:15 ecovec kernel: Registered DAI 'fsib-dai'
Nov 15 14:24:15 ecovec kernel: fsi_wm8804_sound_init
Nov 15 14:24:15 ecovec kernel: soc-audio soc-audio.1: binding WM8804 at 
idx 0
Nov 15 14:24:15 ecovec kernel: soc-audio soc-audio.1: CODEC 
wm8804.0-003a not registered
Nov 15 14:24:15 ecovec kernel: soc-audio soc-audio.1: Registered card 
'FSI (WM8804)'
(...)
