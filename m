From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: fix dependencies for wm8962
Date: Tue, 30 Sep 2014 14:38:49 -0300
Message-ID: <CAOMZO5B3LztUdafDCo8bzLwbmeBB3N-rpQLxXMvb0pXgtGVugA@mail.gmail.com>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C4E3B26042E
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 19:38:50 +0200 (CEST)
Received: by mail-la0-f44.google.com with SMTP id gi9so10390834lab.31
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 10:38:49 -0700 (PDT)
In-Reply-To: <20140930164510.GF4273@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 30, 2014 at 1:45 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 30, 2014 at 01:43:41PM +0200, Arnd Bergmann wrote:
>> The wm8962 driver uses the input subsystem, but is selected by
>> SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
>> resulting in this link error:
>
> That select shouldn't be there in the first place, I asked Nicolin to
> fix this when I applied the driver but he's not got round to it yet.

Would the below change be a proper fix?

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6164e78..081e406 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -288,9 +288,6 @@ config SND_SOC_FSL_ASOC_CARD
        select SND_SOC_FSL_ESAI
        select SND_SOC_FSL_SAI
        select SND_SOC_FSL_SSI
-       select SND_SOC_CS42XX8_I2C
-       select SND_SOC_SGTL5000
-       select SND_SOC_WM8962
        help
         ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
         ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
