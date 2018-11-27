From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: RE: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset
Date: Tue, 27 Nov 2018 17:53:03 +0000
Message-ID: <DM6PR11MB3131108A98DB6394C3009D4BE7D00@DM6PR11MB3131.namprd11.prod.outlook.com>
References: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
 <20181127115035.GB3206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127115035.GB3206@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Grant Grundler <grundler@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Benson Leung <bleung@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown <broonie@kernel.org>
>Sent: Tuesday, November 27, 2018 3:51 AM
>To: Ryan Lee <RyanS.Lee@maximintegrated.com>
>Cc: Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela
><perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Grant Grundler
><grundler@chromium.org>; Kuninori Morimoto
><kuninori.morimoto.gx@renesas.com>; Benson Leung
><bleung@chromium.org>; alsa-devel@alsa-project.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH] ASoC: max98373: Added max98373_reset for stable amp
>reset
>
>On Mon, Nov 26, 2018 at 06:46:05PM +0000, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
>> ---
>
>This really needs a changelog to explain what is going on here, and we nee=
d
>some more documentation in the code.  It is *extremely* unusual to have to
>poll for reset like this, and if the failure mode is I/O errors that's goi=
ng to be
>pretty painful.
OK. I agree that this is very unusual. I wanted to make this code change ve=
ry conservative and this caused unusual overhead.
Let me fix this.
