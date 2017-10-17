From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: add support for a fixed sysclk frequency
Date: Tue, 17 Oct 2017 07:53:36 -0200
Message-ID: <CAOMZO5DpAJn7PPtM1=JmQrsAi=M1-ZdUUR1exg=Qvwwn9sWaGA@mail.gmail.com>
References: <20171006083449.24038-1-jakob.unterwurzacher@theobroma-systems.com>
 <AM5PR0401MB2627DE7F266788214268424BE34E0@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <EA6FEF1C-263E-4529-AC8E-16F50C27030F@theobroma-systems.com>
 <CAOMZO5D-2iFsAUk2Ldo4RD5Xg71Q5HOBuasYc0t=tV3hZbaO2g@mail.gmail.com>
 <9A3652B7-C0ED-44DE-AC6F-9D883076E9B8@theobroma-systems.com>
 <CAOMZO5CsRyTsOSU2L8jv0A=Db-o5RcA-ceCvokCWLKNj__htug@mail.gmail.com> <28F29E6E-B067-4C06-8D35-3786D4B43AAE@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <28F29E6E-B067-4C06-8D35-3786D4B43AAE@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Richard Leitner <richard.leitner@skidata.com>, Bhumika Goyal <bhumirks@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Jakob,

On Tue, Oct 17, 2017 at 7:01 AM, Jakob Unterwurzacher
<jakob.unterwurzacher@theobroma-systems.com> wrote:

> Hi Fabio, I think I found a way to get our use-case working with just DTS=
 configuration
> for simple-audio-card.
>
> When you define the =E2=80=9Cclocks=E2=80=9D property for the "simple-aud=
io-card,cpu=E2=80=9D sub-node,
> set_sysclk is called only once, on startup - like the IMX driver does.
>
> We should get away without changes to the codec driver.

Excellent! This looks better :-)
