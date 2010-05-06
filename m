From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2] ASoC: omap: Add basic audio support for
 Nokia RX-51/N900
Date: Thu, 06 May 2010 09:52:28 +0100
Message-ID: <1273135948.2992.19.camel@odin>
References: <1273047262-5288-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 5E1DB24614
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 10:52:34 +0200 (CEST)
Received: by wyb40 with SMTP id 40so1891620wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 01:52:34 -0700 (PDT)
In-Reply-To: <1273047262-5288-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-05-05 at 11:14 +0300, Jarkko Nikula wrote:
> This patch adds support for integrated stereo speakers and digital
> microphone found on Nokia RX-51 hardware. This is a cut down version based
> on Maemo kernel sources and earlier patchset by Eduardo Valentin et al.
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-October/022033.html
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> ---
> 
> This is for sound-2.6.git. This is independent and boot safe patch but audio
> codec doesn't probe without a few patches to
> arch/arm/mach-omap2/board-rx51-peripherals.c. See
> 
> http://marc.info/?l=linux-omap&m=127290212826770&w=2
> 
> Some audio features would need more work and some, even being trivial to
> add, need more testing are there support for them in mainline. Thus this
> heavily simplified and little bit cleaned up version.
> ---
>  sound/soc/omap/Kconfig  |   10 ++
>  sound/soc/omap/Makefile |    2 +
>  sound/soc/omap/rx51.c   |  294 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 306 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/omap/rx51.c

Applied.

Thanks

Liam
