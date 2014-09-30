From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: fix dependencies for wm8962
Date: Tue, 30 Sep 2014 16:48:01 -0300
Message-ID: <CAOMZO5AZri8dofH6-Bqqj64_itu-W6nUEi5W5koGnQCqqVpbfw@mail.gmail.com>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
 <CAOMZO5B3LztUdafDCo8bzLwbmeBB3N-rpQLxXMvb0pXgtGVugA@mail.gmail.com>
 <20140930194340.GA13318@Alpha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 by alsa0.perex.cz (Postfix) with ESMTP id EC06A26047A
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 21:48:01 +0200 (CEST)
Received: by mail-lb0-f174.google.com with SMTP id p9so2165079lbv.19
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 12:48:01 -0700 (PDT)
In-Reply-To: <20140930194340.GA13318@Alpha>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 30, 2014 at 4:43 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Tue, Sep 30, 2014 at 02:38:49PM -0300, Fabio Estevam wrote:
>> On Tue, Sep 30, 2014 at 1:45 PM, Mark Brown <broonie@kernel.org> wrote:
>> > That select shouldn't be there in the first place, I asked Nicolin to
>> > fix this when I applied the driver but he's not got round to it yet.
>>
>> Would the below change be a proper fix?
>>
>> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
>> index 6164e78..081e406 100644
>> --- a/sound/soc/fsl/Kconfig
>> +++ b/sound/soc/fsl/Kconfig
>
>> -       select SND_SOC_CS42XX8_I2C
>> -       select SND_SOC_SGTL5000
>> -       select SND_SOC_WM8962
>
> Okay..if Mark means this...I think it makes sense to me now.
>
> But in this case, we shall add them into imx_v6_v7_defconfig instead.

We already have
CONFIG_SND_SOC_IMX_WM8962=y
CONFIG_SND_SOC_IMX_SGTL5000=y

in imx_v6_v7_defconfig.
