From: "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
Subject: =?UTF-8?Q?Re:_[PATCH]_ALSA:_firewire-lib/fireworks:_fix_miss_detection_o?=
 =?UTF-8?Q?f_received_MIDI_messages?=
Date: Fri, 28 Jun 2019 23:56:33 +0900
Message-ID: <14b3cbbc-3ea2-4037-9174-24bbf0ecd6e2@www.fastmail.com>
References: <20190628052158.27693-1-o-takashi@sakamocchi.jp>
 <s5ho92i6qhi.wl-tiwai@suse.de>
 <bd65234a-9963-4e25-938f-1e79b053c4e1@www.fastmail.com>
 <s5h1rzd7m0b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5h1rzd7m0b.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Jun 29, 2019, at 00:44, Takashi Iwai wrote:
> On Fri, 28 Jun 2019 09:34:00 +0200,
> Takashi Sakamoto wrote:
> >=20
> > Hi,
> >=20
> > On Fri, Jun 28, 2019, at 17:53, Takashi Iwai wrote:
> > > On Fri, 28 Jun 2019 07:21:58 +0200,
> > > Takashi Sakamoto wrote:
> > > >=20
> > > > In IEC 61883-6, 8 MIDI data streams are multiplexed into single
> > > > MIDI conformant data channel. The index of stream is calculated =
by
> > > > modulo 8 of the value of data block counter.
> > > >=20
> > > > In fireworks, the value of data block counter in CIP header has =
a quirk
> > > > with firmware version v5.0.0, v5.7.3 and v5.8.0. This brings ALS=
A
> > > > IEC 61883-1/6 packet streaming engine to miss detection of MIDI
> > > > messages.
> > > >=20
> > > > This commit fixes the miss detection to modify the value of data=
 block
> > > > counter for the modulo calculation.
> > > >=20
> > > > For maintainers, this bug exists since a commit 18f5ed365d3f ("A=
LSA:
> > > > fireworks/firewire-lib: add support for recent firmware quirk") =
in Linux
> > > > kernel v4.2. There're many changes since the commit.  This fix c=
an be
> > > > backported to Linux kernel v4.4 or later. I tagged a base commit=
 to the
> > > > backport for your convenience.
> > > >=20
> > > > Fixes: df075feefbd3 ("ALSA: firewire-lib: complete AM824 data bl=
ock processing layer")
> > > > Cc: <stable@vger.kernel.org> # v4.4+
> > > > Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > >=20
> > > This doesn't seem applicable to the latest 5.2-rc tree due to your=

> > > recent refactoring.  Could you resubmit the fix for 5.2?  I'll res=
olve
> > > the merge conflict in my side.
> >=20
> > Mmm. Do you actually encounter any conflict when applying this patch=
 to
> > your v5.2 tree?
> >=20
> > This patch includes changes for `sound/firewire/amdtp-am824.c`. On t=
he other
> > hand, my recent work is mainly for `sound/firewire/amdtp-stream.c`. =
Actually,
> > the last change for `amdtp-am824.c` was done 2017-10-25.
> > https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/=
sound/firewire/amdtp-am824.c?h=3Dfor-linus
>=20
> It's not about file conflicts but the compilation fails after the
> patch.
> sound/firewire/amdtp-am824.c: In function =E2=80=98read_midi_messages=E2=
=80=99:
> sound/firewire/amdtp-am824.c:324:16: error: =E2=80=98struct amdtp_stre=
am=E2=80=99 has=20
> no member named =E2=80=98ctx_data=E2=80=99
>    port =3D (8 - s->ctx_data.tx.first_dbc + s->data_block_counter + f)=
 %=20
> 8;
>                 ^~

Oops, now I got it... I just checked its application but should have had=

compile test with old trees.

But I'm in short vacation. The revised patch will be posted next Monday,=

sorry.


Thanks

Takashi Sakamoto
