From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for
	AK5558 ADC driver
Date: Mon, 5 Feb 2018 18:27:47 -0200
Message-ID: <CAOMZO5AvGLQfAAQsRzud15DmG21eyuCR9SOdSBD__VYDHxPZzg@mail.gmail.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
 <1517850115-24340-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2D262673DF
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 21:27:49 +0100 (CET)
Received: by mail-ot0-f193.google.com with SMTP id f56so11698491otj.13
 for <alsa-devel@alsa-project.org>; Mon, 05 Feb 2018 12:27:49 -0800 (PST)
In-Reply-To: <1517850115-24340-2-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh@kernel.org>, shengjiu.wang@nxp.com, linux-kernel <linux-kernel@vger.kernel.org>, wakasugi.jb@om.asahi-kasei.co.jp, Fabio Estevam <fabio.estevam@nxp.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, cosmin.samoila@nxp.com, Mihai Serban <mihai.serban@nxp.com>, Mihai Serban <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 5, 2018 at 3:01 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
> for digital audio systems.
>
> Datasheet is available at:
>
> https://www.akm.com/akm/en/file/datasheet/AK5558VN.pdf
>
> Initial patch includes support for normal and TDM modes.
>
> Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> [initial coding for 3.18 kernel]
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> [cleanups and porting to 4.9 kernel]
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> [tdm support]
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> [pm support, cleanups and porting to latest kernel]

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
