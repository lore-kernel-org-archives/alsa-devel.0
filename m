From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 17/31] HDA patch_via.c: Add second S/PDIF
	out control for VT1708S and VT1702.
Date: Tue, 6 Oct 2009 23:43:20 +0800
Message-ID: <16685ee0910060843q57923499q5fa80d642362fb6e@mail.gmail.com>
References: <16685ee0910050727n4f3eb80ah113d214815de6342@mail.gmail.com>
	<s5h63at6fff.wl%tiwai@suse.de>
	<16685ee0910052201n74138c01g69c08e5fe7f59f04@mail.gmail.com>
	<s5hfx9xrrci.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 71FED243EC
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 17:43:21 +0200 (CEST)
Received: by bwz25 with SMTP id 25so12622768bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 08:43:20 -0700 (PDT)
In-Reply-To: <s5hfx9xrrci.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 6, 2009 at 2:03 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 6 Oct 2009 13:01:42 +0800,
> Li Bo wrote:
>>
>> They are separate S/PDIFs, and in our test, slave SPDIF =A0seems can work
>> =A0independently with master SPDIF. I'll do some test later.
>
> The problem is that master SPDIF will change both master and slaves.
> In your implementation, the slave can be used freely only while the
> master isn't used. =A0Or, it'll conflict later once when the master is
> used.
>
>
> Takashi
>

Oh I understand, thank you. We'll update this patch to build independent
control & substreams for 2nd SPDIF.

>> On Mon, Oct 5, 2009 at 11:14 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Mon, 5 Oct 2009 22:27:35 +0800,
>> > Li Bo wrote:
>> >>
>> >> [ALSA] HDA VIA: Add second S/PDIF out control for VT1708S and VT1702.
>> >>
>> >> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>> >
>> > The slave SPDIFs are really slaves. =A0They are supposed to have ident=
ical
>> > SPDIF status bits as the master. =A0So, creating the individual SPDIF =
status
>> > controls is wrong.
>> >
>> > If they have to be handled separately, we shouldn't use slave SPDIF but
>> > create different streams, etc.
>> >
>> >
>> > Takashi
>> >
>> >
>> >>
>> >> Index: sound-2.6/sound/pci/hda/patch_via.c
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> --- sound-2.6.orig/sound/pci/hda/patch_via.c =A02009-10-05 15:10:59.0=
00000000 +0800
>> >> +++ sound-2.6/sound/pci/hda/patch_via.c =A0 =A0 =A0 2009-10-05 15:11:=
02.000000000 +0800
>> >> @@ -1265,6 +1265,13 @@
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.share_spdif =3D 1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* lydia add for second spdif out */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (spec->slave_dig_outs[0]) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D snd_hda_create_spdi=
f_out_ctls(codec,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->slave_dig_outs[0]);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 if (spec->dig_in_nid) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D snd_hda_create_spdif_in_ctls(code=
c, spec->dig_in_nid);
>> >> @@ -3127,7 +3134,7 @@
>> >> =A0};
>> >>
>> >> =A0static struct hda_pcm_stream vt1708S_pcm_digital_playback =3D {
>> >> - =A0 =A0 .substreams =3D 1,
>> >> + =A0 =A0 .substreams =3D 2,
>> >> =A0 =A0 =A0 .channels_min =3D 2,
>> >> =A0 =A0 =A0 .channels_max =3D 2,
>> >> =A0 =A0 =A0 /* NID is set in via_build_pcms */
>> >>
>> >
>>
>
