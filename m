From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC
	driver
Date: Wed, 31 Jan 2018 18:56:43 +0200
Message-ID: <CAHp75VfmP2zYycht01fo-RPh9o=tRSk4RS6UW02XBjsn7mKgFQ@mail.gmail.com>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAOMZO5BToV0OKEc_f8M1=zSL-X=qSXnokFyEfEEX2tGTUO=a-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 47BBC267656
 for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2018 17:56:44 +0100 (CET)
Received: by mail-qt0-f171.google.com with SMTP id l20so22641905qtj.11
 for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2018 08:56:44 -0800 (PST)
In-Reply-To: <CAOMZO5BToV0OKEc_f8M1=zSL-X=qSXnokFyEfEEX2tGTUO=a-A@mail.gmail.com>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, shengjiu.wang@nxp.com, linux-kernel <linux-kernel@vger.kernel.org>, wakasugi.jb@om.asahi-kasei.co.jp, Mihai Serban <mihai.serban@nxp.com>, Mark Brown <broonie@kernel.org>, linux-imx@nxp.com, cosmin.samoila@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>, mihai.serban@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 31, 2018 at 6:20 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Daniel,

Fabio, +1 to your review. It seems it repeats some of the points I made.


>> +       ak5558->pdn_gpio = of_get_named_gpio(np, "ak5558,pdn-gpio", 0);
>
> It does not match the property in the binding doc: asahi-kasei,pdn-gpios

Btw, it must be simple "reset" as a widely used for the same purpose.

-- 
With Best Regards,
Andy Shevchenko
