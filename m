From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: fix dependencies for wm8962
Date: Tue, 30 Sep 2014 13:37:57 -0700
Message-ID: <20140930203756.GA13613@Alpha>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
 <CAOMZO5B3LztUdafDCo8bzLwbmeBB3N-rpQLxXMvb0pXgtGVugA@mail.gmail.com>
 <20140930194340.GA13318@Alpha>
 <CAOMZO5AZri8dofH6-Bqqj64_itu-W6nUEi5W5koGnQCqqVpbfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id C6718260442
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 22:38:37 +0200 (CEST)
Received: by mail-pa0-f53.google.com with SMTP id kq14so8179748pab.26
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 13:38:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AZri8dofH6-Bqqj64_itu-W6nUEi5W5koGnQCqqVpbfw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 30, 2014 at 04:48:01PM -0300, Fabio Estevam wrote:
> >> -       select SND_SOC_CS42XX8_I2C
> >> -       select SND_SOC_SGTL5000
> >> -       select SND_SOC_WM8962
> >
> > Okay..if Mark means this...I think it makes sense to me now.
> >
> > But in this case, we shall add them into imx_v6_v7_defconfig instead.
> 
> We already have
> CONFIG_SND_SOC_IMX_WM8962=y
> CONFIG_SND_SOC_IMX_SGTL5000=y
> 
> in imx_v6_v7_defconfig.

Yea, and these are two things I plan to drop...

So when enabling the FSL_ASOC_CARD, I also needs to put those three
into it as well.
