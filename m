From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH V4] ASoC: cs42xx8: add reset-gpios in binding document
Date: Thu, 16 May 2019 08:37:27 -0300
Message-ID: <CAOMZO5DhbsCqO4ePKRXm=s=5Vf6rhBJgfeXKUe1w+_RRV5YWQg@mail.gmail.com>
References: <7df2d60911f6c4323c9d11b5fe5341ee31e3940c.1558006342.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7df2d60911f6c4323c9d11b5fe5341ee31e3940c.1558006342.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 16, 2019 at 8:36 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:

>  cs42888: codec@48 {
> @@ -25,4 +30,5 @@ cs42888: codec@48 {
>         VD-supply = <&reg_audio>;
>         VLS-supply = <&reg_audio>;
>         VLC-supply = <&reg_audio>;
> +       reset-gpios = <&pca9557_b 1 1>;

 reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;  please
