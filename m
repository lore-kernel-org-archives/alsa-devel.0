From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [topic/asoc][RFC 0/1] ASoC: OMAP: Add support for
	mono link configuration to McBSP DAI
Date: Mon, 24 Nov 2008 14:33:04 +0000
Message-ID: <20081124143304.GG22394@sirena.org.uk>
References: <1227532164-2612-1-git-send-email-jarkko.nikula@nokia.com>
	<20081124132850.GA22394@sirena.org.uk>
	<20081124154533.4a722b03.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4245F103814
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 15:33:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081124154533.4a722b03.jarkko.nikula@nokia.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 24, 2008 at 03:45:33PM +0200, Jarkko Nikula wrote:
> My problem was this kind of switching correct to do in machine driver?

> 	cpu_dai->playback.channels_min = 1;
> 	cpu_dai->playback.channels_max = 1;
> 	cpu_dai->capture.channels_min = 1;
> 	cpu_dai->capture.channels_max = 1;

No, these should be constant.  Any dynamic constraints should be applied
with the constraints API.

> Defining channels_min = 1 in omap_mcbsp_dai initializer would cause that
> link is then switching between mono/stereo depending what user space is
> asking.

Yes.

> Like "aplay -c 1 /dev/urandom" causes that all machines having codec
> with "channels_min = 1" and "channels_max = 2" would cause incorrect
> mono link configuration where alsalib should do the mono->stereo
> conversion instead and vice versa for pure mono link.

So, this is a bit messy at the moment since we don't really have any
DAPM-style routing on the digital side yet.  What most of these codecs
should probably be doing is declaring a 2 channel minimuim - normally
that's what they require as a wire format even if they only actually use
the data from one of those channels.

This will be less efficient when these devices are used in a mono
configuration but is safer until we can map out the digital side better
in software; it's roughly what you're trying to do here on the CPU side.
