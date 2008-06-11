From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 03/10] ASoC: Tweak tlv320aicx reg_cache_size
Date: Wed, 11 Jun 2008 16:07:57 +0300
Message-ID: <20080611160757.be4be6ee.jarkko.nikula@nokia.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E5BC2481B
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 15:07:39 +0200 (CEST)
In-Reply-To: <1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 11 Jun 2008 13:47:08 +0100
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> ASoC codec drivers frequently set the register cache size using sizeof
> () rather than ARRAY_SIZE(). For tlv320aicx either is correct since
> the registers are 8 bit but update to use ARRAY_SIZE() for clarity.
> =

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

Acked-by: Jarkko Nikula=A0<jarkko.nikula@nokia.com>
