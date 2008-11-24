From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [topic/asoc][RFC 0/1] ASoC: OMAP: Add support for
	mono link configuration to McBSP DAI
Date: Mon, 24 Nov 2008 13:28:57 +0000
Message-ID: <20081124132850.GA22394@sirena.org.uk>
References: <1227532164-2612-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 43071243F7
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 14:29:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227532164-2612-1-git-send-email-jarkko.nikula@nokia.com>
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

On Mon, Nov 24, 2008 at 03:09:23PM +0200, Jarkko Nikula wrote:

> I'm trying to cover also pure mono codecs like bluetooth audio with McBSP DAI
> driver. Protocol part is trivial like patch here but interfacing with machine
> driver is somewhat question mark.

>  struct snd_soc_dai omap_mcbsp_dai[] = {

> +	OMAP_MCBSP_DAI_BUILDER(0, 2, 2),
> +	OMAP_MCBSP_DAI_BUILDER(1, 2, 2),

...

> +struct snd_soc_dai omap_mcbsp_dai_mono[] = {
> +	OMAP_MCBSP_DAI_BUILDER(0, 1, 1),
> +	OMAP_MCBSP_DAI_BUILDER(1, 1, 1),

Is it not possible to have the DAI switch between mono and stereo at
runtime rather than having a DAI for each?  That's the normal approach.
The core should constrain things based on the capabilities of the
connected device.
