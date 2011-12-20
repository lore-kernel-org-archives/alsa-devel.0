From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dsd1791: Introduce driver for TI
 DSD1791 stereo codec
Date: Tue, 20 Dec 2011 00:40:35 +0000
Message-ID: <20111220004034.GF2860@opensource.wolfsonmicro.com>
References: <1324320810-17948-1-git-send-email-michael.williamson@criticallink.com>
	<1324331070.7421.6.camel@odin> <4EEFBA29.4090903@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9275103A25
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 01:40:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EEFBA29.4090903@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Liam Girdwood <lrg@ti.com>, leon@leon.nu
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 19, 2011 at 05:26:49PM -0500, Michael Williamson wrote:
> On 12/19/2011 04:44 PM, Liam Girdwood wrote:

> > Looks mostly fine, just a few comments :-

> Thanks for the review.  I will address your comments. One question, below.

Guys, please delete irrelevant context from your mails.

> >> +{
> >> +	snd_soc_unregister_codec(&spi->dev);

> > What about your private data ?

> My understanding is devm_kzalloc'd memory would be
> freed up by the device framework.  Is this not 
> correct?

Your understanding is correct, that's the whole point of devm_kzalloc().
