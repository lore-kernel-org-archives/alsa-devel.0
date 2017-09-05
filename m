From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Date: Tue, 5 Sep 2017 17:14:31 -0300
Message-ID: <CAOMZO5DULuCZowTeNKXGKJjtiguN+ZX9hPgKvWSAx-r4E-NpdQ@mail.gmail.com>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de> <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@denx.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Lukasz,

On Tue, Sep 5, 2017 at 5:35 AM, =C5=81ukasz Majewski <lukma@denx.de> wrote:

> Note:
> [*] - I could workaround this problem by setting:
>
> system-clock-frequency =3D <0> in
>
>                         dailink_master: cpu {
>                             sound-dai =3D <&ssi2>;
>                         };
>

Which mx6 type are you using? Can you post the complete audio related
bindings of your dts?

Still trying to understand why we do not see this error on other imx6 board=
s.
