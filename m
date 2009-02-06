From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [2.6.29-rc3][PATCH 1/2] ASoC: TLV320AIC3X:
	Fix	kcontrol's private value use in put callback
Date: Fri, 6 Feb 2009 10:55:00 +0000
Message-ID: <20090206105459.GA8723@sirena.org.uk>
References: <1233914465-2767-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A8EF1037E3
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 11:55:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233914465-2767-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 06, 2009 at 12:01:04PM +0200, Jarkko Nikula wrote:

> Function snd_soc_dapm_put_volsw_aic3x misuses the kcontrol's private value
> by still accessing it as bitfields even SOC_SINGLE_VALUE constructs it
> as a pointer into struct soc_mixer_control after the commit
> 4eaa9819dc08d7bfd1065ce530e31b18a119dcaf.

Applied both, thanks.
