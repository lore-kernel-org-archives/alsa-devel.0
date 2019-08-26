From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
Date: Mon, 26 Aug 2019 10:53:15 +0800
Message-ID: <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
References: <20190824210426.16218-1-katsuhiro@katsuster.net> <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 26, 2019 at 1:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 24-08-19 23:04, Katsuhiro Suzuki wrote:
> > This patch limits Headphone mixer volume to 4 from 7.
> > Because output sound suddenly becomes very loudly with many noise if
> > set volume over 4.

That sounds like something that should be limited in UCM.

> Higher then 4 not working matches my experience, see this comment from
> the UCM file: alsa-lib/src/conf/ucm/codecs/es8316/EnableSeq.conf :
>
> # Set HP mixer vol to -6 dB (4/7) louder does not work
> cset "name=3D'Headphone Mixer Volume' 4"

What does "does not work" mean more precisely?

I checked the spec, there is indeed something wrong in the kernel driver he=
re.
The db scale is not a simple scale as the kernel source suggests.

Instead it is:
0000 =E2=80=93 -12dB
0001 =E2=80=93 -10.5dB
0010 =E2=80=93 -9dB
0011 =E2=80=93 -7.5dB
0100 =E2=80=93 -6dB
1000 =E2=80=93 -4.5dB
1001 =E2=80=93 -3dB
1010 =E2=80=93 -1.5dB
1011 =E2=80=93 0dB

So perhaps we can fix the kernel to follow this table and then use UCM
to limit the volume if its too high on a given platform?

Thanks
Daniel
