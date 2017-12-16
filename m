From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/5] media: i2c: Add TDA1997x HDMI receiver
	driver
Date: Sat, 16 Dec 2017 17:32:47 -0200
Message-ID: <CAOMZO5BUyF_E3aQByD2=4CxB-+DP189QAXMUA=AgOnq99wzmRg@mail.gmail.com>
References: <1510253136-14153-1-git-send-email-tharvey@gateworks.com>
 <1510253136-14153-4-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C1CD3266AE1
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 20:32:49 +0100 (CET)
Received: by mail-oi0-f41.google.com with SMTP id u193so8302666oie.1
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 11:32:49 -0800 (PST)
In-Reply-To: <1510253136-14153-4-git-send-email-tharvey@gateworks.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Shawn Guo <shawnguo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Tim,

On Thu, Nov 9, 2017 at 4:45 PM, Tim Harvey <tharvey@gateworks.com> wrote:

> +static int tda1997x_set_power(struct tda1997x_state *state, bool on)
> +{
> +       int ret = 0;
> +
> +       if (on) {
> +               ret = regulator_bulk_enable(TDA1997X_NUM_SUPPLIES,
> +                                            state->supplies);
> +               msleep(300);

Didn't you miss a 'return ret' here?

Otherwise regulator_bulk_disable() will always be called below.

> +       }
> +
> +       ret = regulator_bulk_disable(TDA1997X_NUM_SUPPLIES,
> +                              state->supplies);
> +       return ret;
> +}
