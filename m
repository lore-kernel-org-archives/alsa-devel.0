From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: PLL computation in TLV320AIC3x SoC driver
Date: Wed, 9 Dec 2009 15:01:19 +0100 (CET)
Message-ID: <alpine.DEB.2.00.0912091447230.17383@hippogriff.cosy.sbg.ac.at>
References: <alpine.DEB.2.00.0912081127460.22770@hippogriff.cosy.sbg.ac.at>
	<4B1E66C8.4070402@gmail.com>
	<alpine.DEB.2.00.0912081552430.22770@hippogriff.cosy.sbg.ac.at>
	<4B1E74D7.9080400@gmail.com> <4B1E7965.6030000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pitbull.cosy.sbg.ac.at (pitbull.cosy.sbg.ac.at [141.201.2.122])
	by alsa0.perex.cz (Postfix) with ESMTP id C5F7C10381A
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 15:01:27 +0100 (CET)
In-Reply-To: <4B1E7965.6030000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vladimir Barinov <batareich@gmail.com>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Meerwald <pmeerw@pmeerw.net>
List-Id: alsa-devel@alsa-project.org

Hello,

> > > > > I'm trying to use the SoC TLV320AIC3x codec driver with sysclk
> > > > > 16384000 and
> > > > > ran into some problems with setting PLL; below is a patch against
> > > > > linux-2.6-asoc

> > I just tested your patch works fine with sysclk=16384000 and 12288000 but
> > fails with 11286900: it returns FSREF=45467 instead of desired 44100. I
> > think that this is a valuable difference. Please check it.
> Please check  also 33868800  sysclk, it  returns  FSREF=47545 instead of
> 48000.

I have put the proposed code at http://pmeerw.net/clk/ for review;

'make test' gives me:
clk(16384000,48000): r 1 p 1 d 0 j 6; 6000 == 6000; 48000.000000
clk_orig(16384000,48000): r 1 p 1 d 0 j 6; 6000 == 6000; 48000.000000
clk(16384000,44100): r 1 p 1 d 5125 j 5; 5512 == 5512; 44100.000000
clk_orig(16384000,44100): r 1 p 1 d 5120 j 5; 5512 == 5512; 44096.000000
clk(11286900,48000): r 1 p 1 d 7095 j 8; 8709 == 8710; 47999.636499
clk_orig(11286900,48000): r 1 p 1 d 7100 j 8; 8710 == 8710; 48002.392090
clk(11286900,44100): r 1 p 1 d 19 j 8; 8001 == 8002; 44099.924370
clk_orig(11286900,44100): r 1 p 1 d 20 j 8; 8002 == 8002; 44100.475488
clk(12288000,48000): r 1 p 1 d 0 j 8; 8000 == 8000; 48000.000000
clk_orig(12288000,48000): r 1 p 1 d 0 j 8; 8000 == 8000; 48000.000000
clk(12288000,44100): r 1 p 1 d 3500 j 7; 7350 == 7350; 44100.000000
clk_orig(12288000,44100): r 1 p 1 d 3500 j 7; 7350 == 7350; 44100.000000
clk(33868800,48000): r 1 p 4 d 6099 j 11; 2902 == 2902; 47999.680313
clk_orig(33868800,48000): r 1 p 1 d 9020 j 2; 2902 == 2902; 47991.825000
clk(33868800,44100): r 1 p 3 d 0 j 8; 2666 == 2666; 44100.000000
clk_orig(33868800,44100): r 1 p 1 d 6660 j 2; 2666 == 2666; 44088.975000
clk(12000000,48000): r 1 p 1 d 1920 j 8; 8192 == 8192; 48000.000000
clk_orig(12000000,48000): r 1 p 1 d 1920 j 8; 8192 == 8192; 48000.000000
clk(12000000,44100): r 1 p 1 d 5264 j 7; 7526 == 7526; 44100.000000
clk_orig(12000000,44100): r 1 p 1 d 5260 j 7; 7526 == 7526; 44097.656250

where clk is my proposed code and clk_orig is the code currently in 
tlv320aic3x.c; results include all test cases mentioned

in parenthesis  is the input (sysclk, fsref), the last column is the 
approximation to fsref

note that the proposed code has less deviation from fsref in all cases and 
manages to stay within recommended settings for sysclk 33868800 

I have modified the following line to get rid of rounding errors as much 
as possible:
/* do not use codec_clk here since we'd loose precision */
d = ((2048 * p * fsref) - j * sysclk) * 100 / (sysclk/100);
and fixed a bug which always set pll_p = 1 in case d!=0

if code looks good, I'll submit a patch against linux-sound-2.6 as Mark 
suggested

regards, p.

-- 

Peter Meerwald
Kaigasse 3 / 8
A-5020 Salzburg / AUSTRIA
+43-664-2444418 (mobile)
