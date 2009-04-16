From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix
	DSP_B	format in OMAP McBSP DAI driver
Date: Thu, 16 Apr 2009 11:12:16 +0100
Message-ID: <20090416101216.GI16318@sirena.org.uk>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<1239792497-31761-2-git-send-email-jarkko.nikula@nokia.com>
	<200904151404.37003.peter.ujfalusi@nokia.com>
	<20090415115606.GB9311@sirena.org.uk>
	<dfeb90390904160308t626cfe7axc78dedca915076@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EBEC210392A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 12:12:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <dfeb90390904160308t626cfe7axc78dedca915076@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <getarunks@gmail.com>
Cc: "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 03:38:07PM +0530, Arun KS wrote:

> This patch is working(tested on osk5912), but with
> SND_SOC_DAIFMT_NB_IF in the machine driver. When SND_SOC_DAIFMT_NB_NF
> used, noise on Right channel.

What sort of noise are you getting - is it just noise or is there some
signal underneath the noise?  Can you try playing a signal with no data
on the left channel and see what effect that has?

The CODEC doesn't support inverted frame so a configuration with
inverted frame clock can't be correct.
