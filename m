From: "Wael Nasreddine (a.k.a eMxyzptlk)" <mla@nasreddine.com>
Subject: Re: HDA Intel IDT 92HD71B7X - HP Pavilion DV7-1299EF -
	Only the left speaker is working
Date: Sat, 14 Nov 2009 15:25:01 +0100
Message-ID: <d3328e7b0911140625u745f08cdsd0f673c1482bf364@mail.gmail.com>
References: <d3328e7b0911110722l27597a8bl523052b035e9ec9d@mail.gmail.com>
	<d3328e7b0911110940x24676812pec25ffc176f21d43@mail.gmail.com>
	<s5h7htxgdlj.wl%tiwai@suse.de>
	<d3328e7b0911110958y5bbbf22fpbe4c74dfd6715608@mail.gmail.com>
	<s5hd43o6fp6.wl%tiwai@suse.de>
	<d3328e7b0911111115t3e2201c7r35302f6f7c66b88f@mail.gmail.com>
	<d3328e7b0911120146o317cd32fnc3282a2809aa908f@mail.gmail.com>
	<s5htyx0cak5.wl%tiwai@suse.de>
	<d3328e7b0911140446j6edf0646x5ca7c825ae780a0a@mail.gmail.com>
	<s5htywxmf7d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e65c7bc4df6a570478558b32
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F3F3103828
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 15:25:22 +0100 (CET)
Received: by fxm1 with SMTP id 1so10898586fxm.32
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 06:25:21 -0800 (PST)
In-Reply-To: <s5htywxmf7d.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, julien.cynober@free.fr
List-Id: alsa-devel@alsa-project.org

--0016e65c7bc4df6a570478558b32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2009 at 14:03, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Sat, 14 Nov 2009 13:46:37 +0100,
> Wael Nasreddine (a.k.a eMxyzptlk) wrote:
> >
> > [1 =C2=A0<multipart/alternative (7bit)>]
> > [1.1 =C2=A0<text/plain; UTF-8 (7bit)>]
> > On Thu, Nov 12, 2009 at 11:16, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Thu, 12 Nov 2009 10:46:24 +0100,
> > > Wael Nasreddine (a.k.a eMxyzptlk) wrote:
> > > >
> > > > Takashi,
> > > >
> > > > I tried the snapshot from
> > > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driv=
er-snapshot.tar.gz
> > > > last night with and without options still no go, the options I've
> > > > tried:
> > > >
> > > > - options snd-hda-intel enable_msi=3D
> > > > - options snd-hda-intel enable_msi=3D1 single_cmd=3D0
> > > > power_save_controller=3D0 power_save=3D0 model=3Dhp-dv5
> > >
> > > power_save should be irrelevant. =C2=A0And model=3Dhp-dv5 and enable_=
msi=3D1
> > > are already turned on as default in the recent version.
> > >
> > > The next would be model=3Dauto to avoid hp-dv5 quirk.
> > >
> > > Also, it's helpful if you give a summary of your problems again.
> > >
> > >
> > > Takashi
> > >
> >
> > Takashi,
> >
> > I just tried 'options snd-hda-intel enable_msi=3D1 model=3Dauto' Didn't
> > have much effect, the same problem (sound only from left speaker),
> > always the same result with 'speaker-test -c6 -twav' I can only hear
> > 'Front Left'
>
> OK. =C2=A0But the headphone works, right?
>
Yes Headphones works, even mics works

>
> > Summary:
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > I have an HP DV7-1299EF, BIOS (Version F.2C, F.2A and F.23) , Due to a =
BIOS
> > BUG, the
> > BIOS report only one speaker as an output so the driver does not know
> > how to use pins in order to have a stereo output ( at least that's
> > what you told me last month when you analysed the alsa-info output)... =
And
> > so one speaker, the left speaker is the only speaker currently working =
under
> > Linux.
> >
> >
> > First I suspected a hardware problem so 2 days ago I restored Windows,
> > tried the sound it works, and I updated my BIOS (it was version F.2A
> > before) but sadly it has the same BUG, I also tried reverting back to F=
.2A
> > and further back to F.23 same result...
> >
> > Attached to this mail, my alsa-info.txt
>
> The codec registers look OK through a quick look.
>
> You can try GPIO pin up/down for each pin. =C2=A0Also each pin has two
> directions, so you'll have 8 x 2 x 2 trials.
> For example, to test GPIO 3, pass 0x08 (=3D 1 << 3), try the commands
> below and check aplay at each. =C2=A0(the lines '//' are just my comments=
)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0// dir =3D 0, data =3D 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x=
08
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x0=
0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x=
08
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0// dir =3D 0, data =3D 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x=
08
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x0=
0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x=
00
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0// dir =3D 1, data =3D 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x=
08
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x0=
8
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x=
00
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0// dir =3D 1, data =3D 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x=
08
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x0=
8
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x=
08
>
> Repeat these for each GPIO pin, from 0 to 7.
>
> One another possibility is to use the output pin NID 0x0f.
> For testing this, build with the reconfig feature (usually enabled),
> then change the pin 0x0f default config, such as
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 0x0f 0x90171111 > /sys/class/sound/hwC0D0=
/user_pin_configs
>
> then quit all sound apps and reconfigure
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 1 > /sys/class/sound/hwC0D0/reconfig
>
> Restore the mixer setup once via alsactl
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0alsactl restore
>
> Then check the mixer volumes again, try aplay. =C2=A0With this setup,
> try GPIO procedures above, too.
>
>
> thanks,
>
> Takashi

For the tests I've created a little script (attached for review if I
done something wrong), Here's the results

0x01:
-------> dir =3D 0, data =3D 1  =3D=3D=3D=3D=3D> Front Left
-------> dir =3D 0, data =3D 0  =3D=3D=3D=3D=3D> Front Left
-------> dir =3D 1, data =3D 1  =3D=3D=3D=3D=3D> Front Left
-------> dir =3D 1, data =3D 0  =3D=3D=3D=3D=3D> No Sound

0x02:
-------> dir =3D 0, data =3D 1  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 0, data =3D 0  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 1, data =3D 1  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 1, data =3D 0  =3D=3D=3D=3D=3D> No Sound

0x04:
-------> dir =3D 0, data =3D 1  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 0, data =3D 0  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 1, data =3D 1  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 1, data =3D 0  =3D=3D=3D=3D=3D> No Sound

0x16:
-------> dir =3D 0, data =3D 1  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 0, data =3D 0  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 1, data =3D 1  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 1, data =3D 0  =3D=3D=3D=3D=3D> No Sound

0x32:
-------> dir =3D 0, data =3D 1  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 0, data =3D 0  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 1, data =3D 1  =3D=3D=3D=3D=3D> LFE
-------> dir =3D 1, data =3D 0  =3D=3D=3D=3D=3D> No Sound

0x64:
-------> dir =3D 0, data =3D 1  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 0, data =3D 0  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 1, data =3D 1  =3D=3D=3D=3D=3D> LFE
-------> dir =3D 1, data =3D 0  =3D=3D=3D=3D=3D> No Sound

0x128:
-------> dir =3D 0, data =3D 1  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 0, data =3D 0  =3D=3D=3D=3D=3D> No Sound
-------> dir =3D 1, data =3D 1  =3D=3D=3D=3D=3D> LFE
-------> dir =3D 1, data =3D 0  =3D=3D=3D=3D=3D> No Sound


I've got the same results with the NID 0x0f

--
Wael Nasreddine

Weem Chief-Development Officer - http://www.weem.com

Blog =C2=A0 =C2=A0: http://wael.nasreddine.com
E-mail =C2=A0: wael.nasreddine@weem.com
gTalk =C2=A0 : wael.nasreddine@gmail.com
Tel =C2=A0 =C2=A0 : +33.6.32.94.70.13
Skype =C2=A0 : eMxyzptlk
Twitter : @eMxyzptlk

PGP: 1024D/C8DD18A2 06F6 1622 4BC8 4CEB D724 =C2=A0DE12 5565 3945 C8DD 18A2

.: An infinite number of monkeys typing into GNU emacs,
=C2=A0 would never make a good program. (L. Torvalds 1995) :.

--0016e65c7bc4df6a570478558b32
Content-Type: application/x-sh; name="test.sh"
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g20gl5cw0

IyEvYmluL2Jhc2gKIwojIHZpbTpzeW50YXg9c2g6c3c9NDp0cz00Om5vZXhwYW5kdGFiCgoKZnVu
Y3Rpb24gdGVzdEJpdHMoKQp7Cglmb3IgaSBpbiAkKHNlcSAwIDcpOyBkbwoJCWJpdD0iJFsgMSA8
PCAkaV0iCgkJaWYgWyAke2JpdH0gLWx0IDEwIF07IHRoZW4KCQkJYml0PSIwJHtiaXR9IgoJCWZp
CgkJYml0cz0iMHgke2JpdH0iCgoJCSMgZGlyID0gMCwgZGF0YSA9IDEKCQloZGEtdmVyYiAvZGV2
L3NuZC9od0MwRDAgMHgwMSBTRVRfR1BJT19NQVNLICR7Yml0c30KCQloZGEtdmVyYiAvZGV2L3Nu
ZC9od0MwRDAgMHgwMSBTRVRfR1BJT19ESVIgMHgwMAoJCWhkYS12ZXJiIC9kZXYvc25kL2h3QzBE
MCAweDAxIFNFVF9HUElPX0RBVEEgJHtiaXRzfQoKCQllY2hvICI+PiBkaXIgPSAwLCBkYXRhID0g
MSwgYml0cyA9ICR7Yml0c30iCgkJZWNobyAiPj4gUnVuIHRoZSB0ZXN0cyBhbmQgcHJlc3MgZW50
ZXIgd2hlbiBkb25lLiIKCQlyZWFkIGRvbmUKCgkJIyBkaXIgPSAwLCBkYXRhID0gMAoJCWhkYS12
ZXJiIC9kZXYvc25kL2h3QzBEMCAweDAxIFNFVF9HUElPX01BU0sgJHtiaXRzfQoJCWhkYS12ZXJi
IC9kZXYvc25kL2h3QzBEMCAweDAxIFNFVF9HUElPX0RJUiAweDAwCgkJaGRhLXZlcmIgL2Rldi9z
bmQvaHdDMEQwIDB4MDEgU0VUX0dQSU9fREFUQSAweDAwCgoJCWVjaG8gIj4+IGRpciA9IDAsIGRh
dGEgPSAwLCBiaXRzID0gJHtiaXRzfSIKCQllY2hvICI+PiBSdW4gdGhlIHRlc3RzIGFuZCBwcmVz
cyBlbnRlciB3aGVuIGRvbmUuIgoJCXJlYWQgZG9uZQoKCQkjIGRpciA9IDEsIGRhdGEgPSAwCgkJ
aGRhLXZlcmIgL2Rldi9zbmQvaHdDMEQwIDB4MDEgU0VUX0dQSU9fTUFTSyAke2JpdHN9CgkJaGRh
LXZlcmIgL2Rldi9zbmQvaHdDMEQwIDB4MDEgU0VUX0dQSU9fRElSICR7Yml0c30KCQloZGEtdmVy
YiAvZGV2L3NuZC9od0MwRDAgMHgwMSBTRVRfR1BJT19EQVRBIDB4MDAKCgkJZWNobyAiPj4gZGly
ID0gMSwgZGF0YSA9IDAsIGJpdHMgPSAke2JpdHN9IgoJCWVjaG8gIj4+IFJ1biB0aGUgdGVzdHMg
YW5kIHByZXNzIGVudGVyIHdoZW4gZG9uZS4iCgkJcmVhZCBkb25lCgoJCSMgZGlyID0gMSwgZGF0
YSA9IDEKCQloZGEtdmVyYiAvZGV2L3NuZC9od0MwRDAgMHgwMSBTRVRfR1BJT19NQVNLICR7Yml0
c30KCQloZGEtdmVyYiAvZGV2L3NuZC9od0MwRDAgMHgwMSBTRVRfR1BJT19ESVIgJHtiaXRzfQoJ
CWhkYS12ZXJiIC9kZXYvc25kL2h3QzBEMCAweDAxIFNFVF9HUElPX0RBVEEgJHtiaXRzfQoKCQll
Y2hvICI+PiBkaXIgPSAxLCBkYXRhID0gMSwgYml0cyA9ICR7Yml0c30iCgkJZWNobyAiPj4gUnVu
IHRoZSB0ZXN0cyBhbmQgcHJlc3MgZW50ZXIgd2hlbiBkb25lLiIKCQlyZWFkIGRvbmUKCglkb25l
Cn0KCmZ1bmN0aW9uIHNldHVwTklEKCkKewoJZWNobyAweDBmIDB4OTAxNzExMTEgPiAvc3lzL2Ns
YXNzL3NvdW5kL2h3QzBEMC91c2VyX3Bpbl9jb25maWdzCgllY2hvIDEgPiAvc3lzL2NsYXNzL3Nv
dW5kL2h3QzBEMC9yZWNvbmZpZwoKCWFsc2FjdGwgcmVzdG9yZQp9CgppZiBbIGBpZCAtdWAgLW5l
IDAgXTsgdGhlbgoJZWNobyAiUnVuIGFzIHJvb3QiCglleGl0IDEKZmkKCnRlc3RCaXRzCgplY2hv
ICI+PiBTdG9wIGFsbCB0aGUgcHJvZ3JhbXMgdXNpbmcgc291bmQgYW5kIHByZXNzIGVudGVyIgpy
ZWFkIGVudGVyCgplY2hvICI+PiBUZXN0aW5nIHdpdGggdGhlIE5JRCAweDBmIgpzZXR1cE5JRAoK
ZWNobyAiPj4gUnVuIHRoZSB0ZXN0cyBhbmQgcHJlc3MgZW50ZXIgd2hlbiBkb25lLiIKcmVhZCBk
b25lCgp0ZXN0Qml0cwoK
--0016e65c7bc4df6a570478558b32
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e65c7bc4df6a570478558b32--
