From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: RE: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Date: Fri, 30 Nov 2018 03:17:57 +0000
Message-ID: <DM6PR11MB3131F092601136FF5E626A96E7D30@DM6PR11MB3131.namprd11.prod.outlook.com>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
 <20181128094955.GG6828@sirena.org.uk>
 <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
 <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
 <20181129112612.GB10570@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129112612.GB10570@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Grant Grundler <grundler@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Benson Leung <bleung@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown <broonie@kernel.org>
>Sent: Thursday, November 29, 2018 3:26 AM
>To: Grant Grundler <grundler@chromium.org>
>Cc: Ryan Lee <RyanS.Lee@maximintegrated.com>; Liam Girdwood
><lgirdwood@gmail.com>; perex@perex.cz; tiwai@suse.com; Kuninori
>Morimoto <kuninori.morimoto.gx@renesas.com>; Benson Leung
><bleung@chromium.org>; alsa-devel@alsa-project.org; LKML <linux-
>kernel@vger.kernel.org>; ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable
>amp reset
>
>On Wed, Nov 28, 2018 at 05:55:48PM -0800, Grant Grundler wrote:
>> On Wed, Nov 28, 2018 at 9:07 AM Ryan Lee
><RyanS.Lee@maximintegrated.com> wrote:
>
>> > >Not seeing a changelog here like I asked for :(
>
>> > Actually I added changelog as below. Do you mean this is not sufficien=
t?
>
>> The text is probably sufficient but not in a format that Mark can
>> directly apply.
>> Please take a quick look at Documentation/process/submitting-patches.rst=
.
>
>> Mark wants the "commit message" to be before the '---' line. So move
>> the "Changes:" text up to become the commit message and drop the
>> "Changes" line. That should explain why this commit is needed and
>> include the S-o-B line.
>
>Right.  If you compare what's in git and what you're sending with other
>commits and mails and make sure everything looks similar you're probably o=
n
>the right track.
I'm sorry for the mistake. Let me fix it.
