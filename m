From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V4] ASoC: cs42xx8: add reset-gpios in
 binding document
Date: Thu, 16 May 2019 11:41:46 +0000
Message-ID: <VE1PR04MB647937130B57B9C3F818F3DEE30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130048.outbound.protection.outlook.com [40.107.13.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17720F896B6
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 13:41:47 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

> On Thu, May 16, 2019 at 8:36 AM S.j. Wang <shengjiu.wang@nxp.com>
> wrote:
> 
> >  cs42888: codec@48 {
> > @@ -25,4 +30,5 @@ cs42888: codec@48 {
> >         VD-supply = <&reg_audio>;
> >         VLS-supply = <&reg_audio>;
> >         VLC-supply = <&reg_audio>;
> > +       reset-gpios = <&pca9557_b 1 1>;
> 
>  reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;  please
Ok, sent v5.

Best regards
Wang shengjiu
