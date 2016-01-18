From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 0/3] ASoC: pcm179x: Add I2C support, declare support for
 continuous rates
Date: Mon, 18 Jan 2016 17:06:25 +0100
Message-ID: <CAOf5uwnjnGXckA6smscwOwu0EzsXHiVrS_ZvZXQ-cBthC+U_Fw@mail.gmail.com>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Siverskog <jacob@teenage.engineering>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Jacob

On Mon, Jan 18, 2016 at 4:57 PM, Jacob Siverskog
<jacob@teenage.engineering> wrote:
> This series add support for I2C and declares support for continuous
> sample rates.
>
> Please note that this has only been tested using I2C and PCM1791A. I'd
> be grateful if someone can test it with other devices in the PCM179X
> family and/or SPI.
>

Thank you for this patcheset. I have only one patch that is pending and I don't
think that you have rebased on the last one that add constraints of the format.

Mark, I can even rebase my last patch on top of this patchset and make Jacob
life more easy

Michael

> These patches are against linux-next.
>
> Jacob Siverskog (3):
>   ASoC: pcm179x: Split into core and SPI parts
>   ASoC: pcm179x: Add I2C interface driver
>   ASoC: pcm179x: Support continuous rates
>
>  .../devicetree/bindings/sound/pcm179x.txt          | 11 ++-
>  sound/soc/codecs/Kconfig                           | 20 +++++-
>  sound/soc/codecs/Makefile                          |  4 ++
>  sound/soc/codecs/pcm179x-i2c.c                     | 82 ++++++++++++++++++++++
>  sound/soc/codecs/pcm179x-spi.c                     | 81 +++++++++++++++++++++
>  sound/soc/codecs/pcm179x.c                         | 64 +++--------------
>  sound/soc/codecs/pcm179x.h                         | 14 +++-
>  7 files changed, 215 insertions(+), 61 deletions(-)
>  create mode 100644 sound/soc/codecs/pcm179x-i2c.c
>  create mode 100644 sound/soc/codecs/pcm179x-spi.c
>
> --
> 2.7.0
>



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
