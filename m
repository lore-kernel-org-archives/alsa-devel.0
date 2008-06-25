From: <Ashwin.Chandra@corel.com>
Subject: Re: Alsa Issue - Sound playback starts on left
	speaker	only
Date: Thu, 26 Jun 2008 02:07:05 +0800
Message-ID: <6AA7F928714999469B70E7707C87F82C53168A@TW-EVS02.corelcorp.corel.ics>
References: <6AA7F928714999469B70E7707C87F82C531570@TW-EVS02.corelcorp.corel.ics><4860AF67.7060507@cox.net><6AA7F928714999469B70E7707C87F82C5315A8@TW-EVS02.corelcorp.corel.ics>
	<s5hlk0tolt4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8D6EE.3E26A91A"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from twmail.corel.com (unknown [220.128.92.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 63CFF2440D
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 20:07:08 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <s5hlk0tolt4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8D6EE.3E26A91A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,
Thanks for your info. I took readouts of both modes and notice they are
both in 16LE format but mplayer/smplayer is using oss emulation. Is
there a way to try them with native Alsa? I have attached the dumps. Is
there anything I can do for this (besides switch to OSS)?

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]=20
Sent: Wednesday, June 25, 2008 3:23 AM
To: Ashwin Chandra
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Alsa Issue - Sound playback starts on left
speaker only

At Wed, 25 Jun 2008 01:52:16 +0800,
<Ashwin.Chandra@corel.com> wrote:
>=20
> I have an Intel ALC861VD. Other players (mplayer, smplayer, aplay)
don't
> seem to exhibit this problem. Is there any workaround I can do in my
> application so that upon first time sound playback, I can get it to
play
> on both channels?

Check /proc/asound/card0/pcm0p/sub0/* files and compare between
working and non-working states.  I guess the working case uses OSS
emulation or 16bit format.

If so, try to add the following to ~/.asoundrc:

  defaults.pcm.dmix.format S16_LE


Takashi

>=20
> -----Original Message-----
> From: stan [mailto:ghjeold_i_mwee@cox.net]=20
> Sent: Tuesday, June 24, 2008 1:25 AM
> To: Ashwin Chandra
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Alsa Issue - Sound playback starts on left
> speaker only
>=20
> Ashwin.Chandra@corel.com wrote:
> > =20
> >
> > Hello,
> >
> > I am having an issue with my playback application where upon
playback
> > start, only the left speaker is outputted. But if I mute and unmute
> > (either through my application or using alsamixer), the sound
playback
> > resumes on both left and right speakers. This only happens on a
> > particular system too (out of 5 systems). But I know it is my issue
> > because mplayer or smplayer works fine.
> >
> > =20
> >
> > I believe I am setting the correct HW params (ie. 2 channels), etc.
> >
> > =20
> >
> > Any ideas?
> >
> > =20
> >
> > Thanks!
> >
> >  =20
> The ICE1724 driver has exactly this behavior.  It is a known bug and
has
>=20
> been there for years.
> You don't say what chip is having the problem, but I would guess that=20
> this is it.  Most people
> just program a script to adjust the volume at startup to cure it.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20

------_=_NextPart_001_01C8D6EE.3E26A91A
Content-Type: text/plain;
	name="alsa.txt"
Content-Transfer-Encoding: base64
Content-Description: alsa.txt
Content-Disposition: attachment;
	filename="alsa.txt"

YWNjZXNzOiBNTUFQX0lOVEVSTEVBVkVEDQpmb3JtYXQ6IFMxNl9MRQ0Kc3ViZm9ybWF0OiBTVEQN
CmNoYW5uZWxzOiAyDQpyYXRlOiA0ODAwMCAoNDgwMDAvMSkNCnBlcmlvZF9zaXplOiAxMDI0DQpi
dWZmZXJfc2l6ZTogMTYzODQNCnRpY2tfdGltZTogMTAwMDANCmNhcmQ6IDANCmRldmljZTogMA0K
c3ViZGV2aWNlOiAwDQpzdHJlYW06IFBMQVlCQUNLDQppZDogQUxDODYxVkQgQW5hbG9nDQpuYW1l
OiBBTEM4NjFWRCBBbmFsb2cNCnN1Ym5hbWU6IHN1YmRldmljZSAjMA0KY2xhc3M6IDANCnN1YmNs
YXNzOiAwDQpzdWJkZXZpY2VzX2NvdW50OiAxDQpzdWJkZXZpY2VzX2F2YWlsOiAwDQo2NA0KMTAy
NA0Kc3RhdGU6IFJVTk5JTkcNCnRyaWdnZXJfdGltZTogMTIxNDQxNzQ4MS4wMzczODE0NzUNCnRz
dGFtcCAgICAgIDogMTIxNDQxNzQ4Mi41NjAzOTA5MDANCmRlbGF5ICAgICAgIDogLTczMTQ0DQph
dmFpbCAgICAgICA6IDg5NTI4DQphdmFpbF9tYXggICA6IDg5NTI4DQotLS0tLQ0KaHdfcHRyICAg
ICAgOiA3MzE0NA0KYXBwbF9wdHIgICAgOiAwDQp0c3RhbXBfbW9kZTogTk9ORQ0KcGVyaW9kX3N0
ZXA6IDENCnNsZWVwX21pbjogMA0KYXZhaWxfbWluOiAxMDI0DQp4ZmVyX2FsaWduOiAxMDI0DQpz
dGFydF90aHJlc2hvbGQ6IDENCnN0b3BfdGhyZXNob2xkOiAxMDczNzQxODI0DQpzaWxlbmNlX3Ro
cmVzaG9sZDogMA0Kc2lsZW5jZV9zaXplOiAxMDczNzQxODI0DQpib3VuZGFyeTogMTA3Mzc0MTgy
NA0K

------_=_NextPart_001_01C8D6EE.3E26A91A
Content-Type: text/plain;
	name="alsa-oss.txt"
Content-Transfer-Encoding: base64
Content-Description: alsa-oss.txt
Content-Disposition: attachment;
	filename="alsa-oss.txt"

YWNjZXNzOiBSV19JTlRFUkxFQVZFRA0KZm9ybWF0OiBTMTZfTEUNCnN1YmZvcm1hdDogU1REDQpj
aGFubmVsczogMg0KcmF0ZTogNDQxMDAgKDQ0MTAwLzEpDQpwZXJpb2Rfc2l6ZTogMTAyNA0KYnVm
ZmVyX3NpemU6IDE2Mzg0DQp0aWNrX3RpbWU6IDEwMDAwDQpPU1MgZm9ybWF0OiBTMTZfTEUNCk9T
UyBjaGFubmVsczogMg0KT1NTIHJhdGU6IDQ0MTAwDQpPU1MgcGVyaW9kIGJ5dGVzOiA0MDk2DQpP
U1MgcGVyaW9kczogMTYNCk9TUyBwZXJpb2QgZnJhbWVzOiAxMDI0DQpjYXJkOiAwDQpkZXZpY2U6
IDANCnN1YmRldmljZTogMA0Kc3RyZWFtOiBQTEFZQkFDSw0KaWQ6IEFMQzg2MVZEIEFuYWxvZw0K
bmFtZTogQUxDODYxVkQgQW5hbG9nDQpzdWJuYW1lOiBzdWJkZXZpY2UgIzANCmNsYXNzOiAwDQpz
dWJjbGFzczogMA0Kc3ViZGV2aWNlc19jb3VudDogMQ0Kc3ViZGV2aWNlc19hdmFpbDogMA0KNjQN
CjEwMjQNCnN0YXRlOiBSVU5OSU5HDQp0cmlnZ2VyX3RpbWU6IDEyMTQ0MTY0OTMuNzA0NjEyOTQy
DQp0c3RhbXAgICAgICA6IDEyMTQ0MTY0OTguNTUwMjUwNTAyDQpkZWxheSAgICAgICA6IDE1NjQ4
DQphdmFpbCAgICAgICA6IDczNg0KYXZhaWxfbWF4ICAgOiAxNzQwMA0KLS0tLS0NCmh3X3B0ciAg
ICAgIDogMjEzNzI4DQphcHBsX3B0ciAgICA6IDIyOTM3Ng0KdHN0YW1wX21vZGU6IE5PTkUNCnBl
cmlvZF9zdGVwOiAxDQpzbGVlcF9taW46IDANCmF2YWlsX21pbjogMQ0KeGZlcl9hbGlnbjogMQ0K
c3RhcnRfdGhyZXNob2xkOiAxDQpzdG9wX3RocmVzaG9sZDogMTYzODQNCnNpbGVuY2VfdGhyZXNo
b2xkOiAxMDQwDQpzaWxlbmNlX3NpemU6IDEwNDANCmJvdW5kYXJ5OiAxMDczNzQxODI0DQo=

------_=_NextPart_001_01C8D6EE.3E26A91A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------_=_NextPart_001_01C8D6EE.3E26A91A--
