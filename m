From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Tue, 4 Apr 2017 14:12:33 -0300
Message-ID: <CAOMZO5A8AExfYR+JuBaLAQsRNUs3Og13PGv9ychD7j4rwMhx2A@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <CAOMZO5BiRrRurJUsLb_pgSEw+ByZSSg6b3sRz17tKUXT1wRaSw@mail.gmail.com>
 <CAG5mAdyjWDaijQHFzKc3v3F0A_2BsBByxXygeits5NfFiQTSpA@mail.gmail.com>
 <CAOMZO5DzNqKdOHOb_SXQwzEDfD1B4yQVjYxYaHhFHzWNUSE-ig@mail.gmail.com>
 <CAG5mAdzKuWHMQLiDOzabdp9Xxs1z5sYNdkt17kGge-4wop5nFA@mail.gmail.com>
 <e5c3ee01-e807-e74d-f90f-2c207a74e539@invoxia.com>
 <CAOMZO5Ahe7fYxZH28J7B0wDFmRc1J2aJv6qoktHoKo15s4b9uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 24FE6266834
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 19:12:35 +0200 (CEST)
Received: by mail-oi0-f44.google.com with SMTP id b187so170810127oif.0
 for <alsa-devel@alsa-project.org>; Tue, 04 Apr 2017 10:12:35 -0700 (PDT)
In-Reply-To: <CAOMZO5Ahe7fYxZH28J7B0wDFmRc1J2aJv6qoktHoKo15s4b9uQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <kernel@pengutronix.de>, Timur Tabi <timur@tabi.org>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 4, 2017 at 8:38 AM, Fabio Estevam <festevam@gmail.com> wrote:

> I have the following SSI1 values (with the original 4.1-rc5 + pictrl patch):
>
> # cat /sys/kernel/debug/regmap/2028000.ssi/registers
> 00: 00000200
> 04: 00000000
> 10: 0000105b

Bits 6-5 (I2S_MODE) of register SCR are 10 of register SCR, which
means I2S slave mode.

The MX6 Reference Manual states:

"In I2S slave mode(SSI_SCR[6:5]=10), the following settings are
internally overridden by
the hardware:

Normal mode is selected (SSI_SCR[3]=0)
Tx frame sync length set to one-bit-long-frame (SSI_STCR[1]=1)
Rx frame sync length set to one-bit-long-frame (SSI_SRCR[1]=1)"

so I tried not to use the the one-bit-long-frame (since ENGcm06222 is
about bit length frame sync) override and changed it to I2S normal
mode instead:

--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -973,7 +973,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
                        ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_MASTER;
                        break;
                case SND_SOC_DAIFMT_CBM_CFM:
-                       ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
+                       ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_NORMAL;
                        break;
                default:
                        return -EINVAL;

and I do not get the channel swap anymore.

In what cases could we safely switch to I2S normal mode?

Thanks
