From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: sgtl5000: add support for a fixed sysclk frequency
Date: Mon, 16 Oct 2017 09:19:57 -0200
Message-ID: <CAOMZO5CsRyTsOSU2L8jv0A=Db-o5RcA-ceCvokCWLKNj__htug@mail.gmail.com>
References: <20171006083449.24038-1-jakob.unterwurzacher@theobroma-systems.com>
 <AM5PR0401MB2627DE7F266788214268424BE34E0@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <EA6FEF1C-263E-4529-AC8E-16F50C27030F@theobroma-systems.com>
 <CAOMZO5D-2iFsAUk2Ldo4RD5Xg71Q5HOBuasYc0t=tV3hZbaO2g@mail.gmail.com> <9A3652B7-C0ED-44DE-AC6F-9D883076E9B8@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9A3652B7-C0ED-44DE-AC6F-9D883076E9B8-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jakob Unterwurzacher <jakob.unterwurzacher-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Klaus Goger <klaus.goger-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Richard Leitner <richard.leitner-WcANXNA0UjBBDgjK7y7TUQ@public.gmane.org>, Bhumika Goyal <bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Jakob,

On Mon, Oct 16, 2017 at 9:17 AM, Jakob Unterwurzacher
<jakob.unterwurzacher-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org> wrote:

> Hi Fabio,
>
> if this ( https://patchwork.kernel.org/patch/9952385/ ) is the patch, the=
n it seems to be
> specific to the Freescale I2S controller. We use the SGTL5000 together wi=
th a Rockchip CPU.

Yes, it is specific to the SSI interface on i.MX. I thought you were
using i.MX, sorry.

> I think I see a way to fix this without adding a DTS property, I=E2=80=99=
ll send out a patch later this afternoon.

Ok, great.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
