From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [alsa-devel] [PATCH v1 1/4] ASoC: codec: Inno codec driver for
 RK3036 SoC
Date: Mon, 19 Oct 2015 08:56:51 +0200
Message-ID: <alpine.DEB.2.02.1510190855250.4075@lnxricardw1.se.axis.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com> <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shunqian Zheng <zhengsq@rock-chips.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "heiko@sntech.de" <heiko@sntech.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "benzh@chromium.org" <benzh@chromium.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 13 Oct 2015, Shunqian Zheng wrote:

> +static const struct of_device_id rk3036_codec_of_match[] =3D {
> +       { .compatible =3D "rk3036-codec", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, rk3036_codec_of_match);

Isn't a compatible string normally in the form "rockchip,rk3036-codec" =
?

/Ricard
--=20
Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
