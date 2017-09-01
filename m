From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: RE: [PATCH 5/9] ASoC: max98927: Removed obsolete variables
Date: Fri, 1 Sep 2017 21:38:33 +0000
Message-ID: <BY2PR11MB0837C940D1C26C78A4D1224CE7920@BY2PR11MB0837.namprd11.prod.outlook.com>
References: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
 <1503963061-14763-5-git-send-email-ryans.lee@maximintegrated.com>
 <20170831115359.bjw3wbihjzcuh3nh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831115359.bjw3wbihjzcuh3nh@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Thursday, August 31, 2017 4:54 AM
>To: Ryan Lee <RyanS.Lee@maximintegrated.com>
>Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com;
>kuninori.morimoto.gx@renesas.com; alsa-devel@alsa-project.org; linux-
>kernel@vger.kernel.org; ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH 5/9] ASoC: max98927: Removed obsolete variables
>
>On Mon, Aug 28, 2017 at 04:30:57PM -0700, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
>
>Why are these variables obsolete?  If their use was removed in earlier pat=
ches in
>the series they should be handled in that patch, if they're just unused sa=
y so.  In
>general your changelogs could really benefit from being a bit longer and
>explaining why changes are being made.
>
>>  mode change 100644 =3D> 100755 sound/soc/codecs/max98927.h
>
>This also changes the permissions to be executable which isn't what we wan=
t.

Thank you for your comment.
I wanted to remove these variables because it have never been referred in m=
ax98927.c from the beginning.
