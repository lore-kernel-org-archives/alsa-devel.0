From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add max98088 CODEC driver
Date: Wed, 13 Oct 2010 11:32:24 +0100
Message-ID: <20101013103224.GK6424@rakim.wolfsonmicro.main>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	<B2150E1E4418E1438554A300EA5040E40D469C124F@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC35610381C
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 12:32:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40D469C124F@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Marroquin <Jesse.Marroquin@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2010 at 06:20:10PM -0700, Peter Hsiang wrote:

This looks pretty good, waiting for Liam's review but I think we can do
further stuff incrementally.  Minor comments:

> +
> +       /* Setup an array of texts for the equalizer enum.
> +        * This is based on Mark Brown's equalizer driver code.
> +        * It has been extended to support multiple equalizers.
> +        */

The code that you're basing this on supports multiple equalizers too -
things like the WM8994 have several.  Given that all those supported by
the original code are identical there didn't seem to be any point in
restricting which EQ a given setup can be deployed on - it's just one
more thing that can go wrong.

> +static int max98088_remove(struct snd_soc_codec *codec)
> +{
> +       if (codec->control_data)
> +               max98088_set_bias_level(codec, SND_SOC_BIAS_OFF);

The control_data check should be redundant here.
