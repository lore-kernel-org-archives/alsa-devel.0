From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
	after reset
Date: Fri, 10 May 2013 16:18:58 -0300
Message-ID: <CAOMZO5Dj83WqD2tQBQDBz9FzvLQGyuv-4yvb4gwL=rRq6DxPuw@mail.gmail.com>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
 <518C4A8E.6020501@boundarydevices.com>
 <CAOMZO5AoWqhSdH5WVu=TFgejis=8mWNGYyHneRc5idwCd8RZWA@mail.gmail.com>
 <518D4660.9070202@boundarydevices.com>
 <518D4781.30507@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id C21DF261691
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 21:18:58 +0200 (CEST)
Received: by mail-vc0-f172.google.com with SMTP id m17so3961886vca.31
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 12:18:58 -0700 (PDT)
In-Reply-To: <518D4781.30507@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 10, 2013 at 4:16 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:

> Since Sabrelite uses "dummy" regulators (always on), have you tested with a
> boards that
> actually uses regulators?

I don't have any board that drives the sgtl5000 power supplies from a
PMIC, for example.

>
> I would think that some regulators would need to be on before you could even
> read
> the ID register.

Sure. That's why I placed the ID reading after turning on the regulators :-)
