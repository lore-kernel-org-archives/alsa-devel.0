From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [PATCH v3 0/6] VAG power control improvement for sgtl5000 codec
Date: Wed, 17 Jul 2019 16:34:09 +0000
Message-ID: <AM6PR05MB6535DC29316E859AFF3699C4F9C90@AM6PR05MB6535.eurprd05.prod.outlook.com>
References: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>,<CAOMZO5B00XRb5GqtYhyg==sVek_uWhLRDQeSStN1AzfKRnV+Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5B00XRb5GqtYhyg==sVek_uWhLRDQeSStN1AzfKRnV+Dw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hello Fabio,

Thank you for your feedback! I've prepared and sent a fixed patchset v4.

--
R&D Engineer
Oleksandr Suvorov

Toradex AG

________________________________________
From: Fabio Estevam <festevam@gmail.com>
Sent: Monday, July 15, 2019 10:06:57 PM
To: Oleksandr Suvorov
Cc: linux-kernel@vger.kernel.org; alsa-devel@alsa-project.org; Marcel Ziswi=
ler; Igor Opaniuk; Jaroslav Kysela; Mark Brown; Takashi Iwai; Liam Girdwood
Subject: Re: [PATCH v3 0/6] VAG power control improvement for sgtl5000 code=
c

Hi Oleksandr,

Your series looks good, thanks.

I only have one suggestion.

On Fri, Jul 12, 2019 at 11:56 AM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
>
> VAG power control is improved to fit the manual [1]. This patchset fixes =
as
> minimum one bug: if customer muxes Headphone to Line-In right after boot,
> the VAG power remains off that leads to poor sound quality from line-in.
>
> I.e. after boot:
> - Connect sound source to Line-In jack;
> - Connect headphone to HP jack;
> - Run following commands:
> $ amixer set 'Headphone' 80%
> $ amixer set 'Headphone Mux' LINE_IN

Could you please make the bug fix patch to appear as the first one in
the series with a Fixes tag and Cc stable?

This way the bug fix can be applied to the linux stable tree.
