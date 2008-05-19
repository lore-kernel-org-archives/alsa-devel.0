From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Clarify API for bias configuration
Date: Mon, 19 May 2008 19:36:55 +0100
Message-ID: <20080519183654.GB30712@sirena.org.uk>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080519171558.c37b980b.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BF24E245FB
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 20:36:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080519171558.c37b980b.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 19, 2008 at 05:15:58PM +0300, Jarkko Nikula wrote:

> First impression: Is that somewhat confusing to refer power state event
> as a bias level? First what comes to my is this related to mic bias...

Bias here is being used to refer to general DC offset levels on the AC
inputs and outputs of the chip - microphone bias is just one of these
levels.  For a lot of codecs there's no or limited control of the baises
but some do provide fine grained control.

> If there's a need to change name of dapm_event callback, probably some
> dapm_device_event etc. would be better if need to separate from other
> dapm events?

Well, part of the goal was to make it clearer what sort of thing was
expected to be configured by this function.  I'm drawing a bit of a
blank on a better name right now, though.

The tlv320aicx driver is fairly unusual in controlling the PLL here,
though it shouldn't cause any problems either.  Incidentally, it looks
like this needs updating to reflect the support that was added for
bypassing the PLL - presumably if the PLL is bypassed then enabling it
during playback and record will consume power needlessly?

Most drivers expose clocking configuration like the PLL to machine
drivers in order to allow use of clocks generated on the codec
independently of the audio stream - if it's not needed outside of
playback then generally it'd be set up in hw_params() and stopped in
hw_free() or shutdown() to achieve a similar effect to what you're
doing.
