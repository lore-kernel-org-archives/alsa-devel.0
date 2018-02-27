From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] ASoC: imx-wm8962: Remove machine driver
Date: Mon, 26 Feb 2018 22:25:20 -0300
Message-ID: <CAOMZO5Cy1R5Jh28KZKEf2nka8q19==ej875kigiLjYGZVrOkxg@mail.gmail.com>
References: <1519672923-26886-1-git-send-email-festevam@gmail.com>
 <20180227004643.GA6370@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f182.google.com (mail-ot0-f182.google.com
 [74.125.82.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CA0E267651
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 02:25:21 +0100 (CET)
Received: by mail-ot0-f182.google.com with SMTP id p8so2338105otf.2
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 17:25:21 -0800 (PST)
In-Reply-To: <20180227004643.GA6370@Asurada-Nvidia>
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
Cc: alsa-devel@alsa-project.org, "S.j. Wang" <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 26, 2018 at 9:46 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> Did you verify it on a certain hardware? If so, I may give my Ack
> directly as it looks good to me. Otherwise, I would need to test.

Yes, I tested it on a imx6q-sabresd.

> And could you please also remove line 31 at
> Documentation/devicetree/bindings/sound/fsl-asoc-card.txt ?
>
> Since this imx-audio-wm8962.txt will be removed, that line could
> be removed too. Thanks.

Just sent v4 with your suggestion.
