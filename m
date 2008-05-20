From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Clarify API for bias configuration
Date: Tue, 20 May 2008 12:53:25 +0300
Message-ID: <20080520125325.b17ba0b3.jarkko.nikula@nokia.com>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080519171558.c37b980b.jarkko.nikula@nokia.com>
	<20080519183654.GB30712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DCE82434A
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 11:56:40 +0200 (CEST)
In-Reply-To: <20080519183654.GB30712@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 19 May 2008 19:36:55 +0100
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> Bias here is being used to refer to general DC offset levels on the AC
> inputs and outputs of the chip - microphone bias is just one of these
> levels.  For a lot of codecs there's no or limited control of the
> baises but some do provide fine grained control.
> 
It came to my mind only afterwards but probably usual set_power
convention fits here well, doesn't confuse with DAPM and doesn't limit
to thinking only mic bias :-)

> The tlv320aicx driver is fairly unusual in controlling the PLL here,
> though it shouldn't cause any problems either.  Incidentally, it looks
> like this needs updating to reflect the support that was added for
> bypassing the PLL - presumably if the PLL is bypassed then enabling it
> during playback and record will consume power needlessly?
> 
Ah, you are right. There seems to be needless PLL power-up between
dapm_event and aic3x_hw_params in case of PLL bypass even the
aic3x_hw_parms disables it.

Also how on earth I was able to test my ASoC drivers for OMAP in case
of codec slave since driver is enabling PLL only for master case.
Hmm... what a hack I was using then.

Seems that some fixes are needed there.

> Most drivers expose clocking configuration like the PLL to machine
> drivers in order to allow use of clocks generated on the codec
> independently of the audio stream - if it's not needed outside of
>
Some integrated chips might require it as well if there is some
(undocumented) interdependencies inside the integrated chip. IRCC e.g.
TSC2301 keypad and touchscreen were using audio clock in some occasions.


Jarkko
