From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
 format in OMAP McBSP DAI driver
Date: Fri, 17 Apr 2009 12:43:03 +0300
Message-ID: <20090417124303.af9c11f0.jarkko.nikula@nokia.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<20090416134724.dfb3e57a.jarkko.nikula@nokia.com>
	<dfeb90390904160420l3461f155u25d632d22388391e@mail.gmail.com>
	<200904161427.30707.peter.ujfalusi@nokia.com>
	<dfeb90390904160605m478dbf66yf78a0c012c2efc58@mail.gmail.com>
	<49E7A498.8060804@boundarydevices.com>
	<20090417095923.6392f82e.jarkko.nikula@nokia.com>
	<dfeb90390904170216q4eaa90e0kf66271de4651c27a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F526103809
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 11:42:25 +0200 (CEST)
In-Reply-To: <dfeb90390904170216q4eaa90e0kf66271de4651c27a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Arun KS <getarunks@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, ext Mark Brown <broonie@sirena.org.uk>, ext Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 17 Apr 2009 11:16:34 +0200
ext Arun KS <getarunks@gmail.com> wrote:

> > Interesting codec. Arun, how is the right channel working with I2S
> > if you try to run with higher rate? E.g. aplay -r [48000 |
> > 96000] /dev/urandom
> 
> Its the same. Right channel remains blank and left channel is playing.
> 
There is a note for the register "Digital Audio Interface Format
(Address: 0000111)" but I cannot find is this true for all formats or
probably only for I2S. If it's only for I2S then this would explain as
MCLK is 12 MHz in OSK5912.

"2. In master mode, BCLK = MCLK/4 for all sample rates except for 88.2
kHz and 96 kHz. For 88.2 kHz and 96 kHz sample rate, BCLK = MCLK."

Do you have possibility to measure this with an oscilloscope that are
there more bit clock cycles than 32?


Jarkko
