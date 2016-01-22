From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v4 0/3] ASoC: pcm179x: Add I2C support,
 declare support for continuous rates
Date: Fri, 22 Jan 2016 14:45:00 +0100
Message-ID: <CAOf5uwkcm5xRPUE0de8NzyaLoCO-5kj0Svj5+tLKHHpS+bFY2A@mail.gmail.com>
References: <1453466395-7352-1-git-send-email-jacob@teenage.engineering>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id A6B4A260544
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 14:45:01 +0100 (CET)
Received: by mail-io0-f171.google.com with SMTP id q21so88436667iod.0
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 05:45:01 -0800 (PST)
In-Reply-To: <1453466395-7352-1-git-send-email-jacob@teenage.engineering>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jacob Siverskog <jacob@teenage.engineering>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi


On Fri, Jan 22, 2016 at 1:39 PM, Jacob Siverskog
<jacob@teenage.engineering> wrote:
> This series add support for I2C and declares support for continuous
> sample rates.
>
> Please note that this has only been tested using I2C and PCM1791A. I'd
> be grateful if someone can test it with other devices in the PCM179X
> family and/or SPI.
>
> These patches are against linux-next.
>
> [V4]: Move regmap error check to where the regmaps are
> allocated. Minor cosmetic changes.
>
> [V3]: Allocation of private data moved to common code.
>
> [V2]: Fix build issues found by kbuild test robot by adding static
> keyword and proper symbol exports.
>
> Jacob Siverskog (3):
>   ASoC: pcm179x: Split into core and SPI parts
>   ASoC: pcm179x: Add I2C interface driver
>   ASoC: pcm179x: Support continuous rates
>

For me are fine

Acked-by: Michael Trimarchi <michael@amarulasolutions.com>

I will rebase my stuff on top of this

Michael

>  .../devicetree/bindings/sound/pcm179x.txt          | 11 +++-
>  sound/soc/codecs/Kconfig                           | 20 +++++-
>  sound/soc/codecs/Makefile                          |  4 ++
>  sound/soc/codecs/pcm179x-i2c.c                     | 73 ++++++++++++++++++++++
>  sound/soc/codecs/pcm179x-spi.c                     | 72 +++++++++++++++++++++
>  sound/soc/codecs/pcm179x.c                         | 56 +++++------------
>  sound/soc/codecs/pcm179x.h                         |  9 +--
>  7 files changed, 196 insertions(+), 49 deletions(-)
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
