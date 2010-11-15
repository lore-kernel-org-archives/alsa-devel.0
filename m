From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: WM8804: fsi-wm8804
Date: Mon, 15 Nov 2010 15:13:20 +0000
Message-ID: <20101115151320.GE12986@rakim.wolfsonmicro.main>
References: <4CE126FD.7000407@elproma.com.pl>
	<20101115123351.GB3338@sirena.org.uk>
	<4CE139CF.4070400@elproma.com.pl>
	<20101115135053.GC3338@sirena.org.uk>
	<4CE13DC8.30007@elproma.com.pl>
	<20101115140604.GD12986@rakim.wolfsonmicro.main>
	<4CE14996.1060702@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C15C5244A9
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 16:13:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CE14996.1060702@elproma.com.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 15, 2010 at 03:54:14PM +0100, Grzegorz Daniluk wrote:

> Sorry about that, now it tells much more :) So what I did wrong was

Good to hear.

> the .codec_name in snd_soc_dai_link structure. I have defined it as
> "wm8804.0-003a" while it should be "wm8804.1-003a". Btw. I know that
> 003a represents the I2C address of the codec, but what this '1' or
> '0' stands for (that I had mistaken) ?

It's the I2C bus number - many platforms have multiple I2C buses so we
need to distinguish between them.
