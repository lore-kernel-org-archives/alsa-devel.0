From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Thu, 24 Sep 2009 10:26:12 -0700
Message-ID: <20090924172611.GA11448@sirena.org.uk>
References: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EEBAC10380D
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 19:26:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rick Bronson <rick@efn.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 24, 2009 at 10:06:07AM -0700, Rick Bronson wrote:

>  MUX_VAL(CP(McBSP_CLKS),  (OFF_IN_PD  | IEN  | PTD | DIS | M0)) /* McBSP_CLKS <- I2S_MCLK <- CLKOUT */\

...

> 5 Playing WAVE 'test48000.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> 6 aplay: pcm_write:1269: write error: Input/output error

This suggests that the DMA isn't happening which usually means that the
CPU isn't seeing all the clocks it's supposed to.  I'm not familiar
enough with the OMAP internals to know if you've set the CPU up
properly.

>   I get no audio output, other than a "click" when the 8731 is
> initialized upon boot.  When I look at the signals the McBSP2_DX line
> just goes low for the duration of the "aplay", it does not toggle. The
> other lines look fine.  The file is at

If you try a record then does the ADCDAT line show a signal?
