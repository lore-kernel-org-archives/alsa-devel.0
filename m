From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [topic/asoc][RFC 0/1] ASoC: OMAP: Add support for
 mono link configuration to McBSP DAI
Date: Mon, 24 Nov 2008 15:45:33 +0200
Message-ID: <20081124154533.4a722b03.jarkko.nikula@nokia.com>
References: <1227532164-2612-1-git-send-email-jarkko.nikula@nokia.com>
	<20081124132850.GA22394@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 984012440F
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 14:46:08 +0100 (CET)
In-Reply-To: <20081124132850.GA22394@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Nov 2008 13:28:57 +0000
"ext Mark Brown" <broonie@sirena.org.uk> wrote:

> > +struct snd_soc_dai omap_mcbsp_dai_mono[] = {
> > +	OMAP_MCBSP_DAI_BUILDER(0, 1, 1),
> > +	OMAP_MCBSP_DAI_BUILDER(1, 1, 1),
> 
> Is it not possible to have the DAI switch between mono and stereo at
> runtime rather than having a DAI for each?  That's the normal approach.
> The core should constrain things based on the capabilities of the
> connected device.
>
OMAP McBSP DAI can do almost anything :-)

My problem was this kind of switching correct to do in machine driver?

	cpu_dai->playback.channels_min = 1;
	cpu_dai->playback.channels_max = 1;
	cpu_dai->capture.channels_min = 1;
	cpu_dai->capture.channels_max = 1;

Defining channels_min = 1 in omap_mcbsp_dai initializer would cause that
link is then switching between mono/stereo depending what user space is
asking.

Like "aplay -c 1 /dev/urandom" causes that all machines having codec
with "channels_min = 1" and "channels_max = 2" would cause incorrect
mono link configuration where alsalib should do the mono->stereo
conversion instead and vice versa for pure mono link.


Jarkko
