From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct
	the?DSP_B	mode
Date: Tue, 14 Apr 2009 11:47:07 +0100
Message-ID: <20090414104707.GF12678@sirena.org.uk>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090414120221.f0e89499.jarkko.nikula@nokia.com>
	<20090414093133.GB12678@sirena.org.uk>
	<200904141334.33497.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DBD34103839
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 12:47:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904141334.33497.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 14, 2009 at 01:34:33PM +0300, Peter Ujfalusi wrote:

> To have the DSP_B mode correctly (for the tvl320aic32 codec used in osk5912 
> board) the FS polarity has to be handled by the mcbsp as it has been inverted. 
> If we don't do this, there is no way to have the MSB at the correct place (it 
> has to be available when the FS is high).

> The DSP_A mode can use the FS polarity 'correctly' - as it is. Or we can also 
> consider to require to invert the FS polarity, than add 1 bit delay for DSP_A 
> mode.

As Jarkko says the driver should be hiding all this from users - it
should just set the port up as best it can, refusing to do anything that
can't be supported by the hardware.  The default polarity the hardware
uses shouldn't be visible outside the driver.

> a) The proposal in the series
> DSP_B mode (the MSB is transmitted when the FS is high, the length for the 
> pulse is 1):

> DSP_A mode (the MSB is transmitted when the FS went low, the length for the 
> pulse is still 1, but the FS stays low for (wlen * channels - 1) cycles):

The difference between the two modes shouldn't be edge of FS used, it
should be a clock cycle, though with a 1 BCLK pulse on FS the effect
will probably line up.  The MSB data needs to be available for sampling
on the appropriate rising edge of BCLK.
