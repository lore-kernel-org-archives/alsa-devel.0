From: "Gilliland, Scott M" <scott.gilliland@gatech.edu>
Subject: Re: Bug in ALSA-utils/arecord with --max-file-time
Date: Fri, 23 Jun 2017 15:18:58 +0000
Message-ID: <CY4PR07MB3544205668C0A73D14F0C3C88DD80@CY4PR07MB3544.namprd07.prod.outlook.com>
References: <CY4PR07MB354415A92C4678709F99FD948DDB0@CY4PR07MB3544.namprd07.prod.outlook.com>,
 <s5hinjmn6ol.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_CY4PR07MB3544205668C0A73D14F0C3C88DD80CY4PR07MB3544namp_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0131.outbound.protection.outlook.com [104.47.33.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 73EEF266AE9
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 17:19:00 +0200 (CEST)
In-Reply-To: <s5hinjmn6ol.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_CY4PR07MB3544205668C0A73D14F0C3C88DD80CY4PR07MB3544namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

How does this look?=A0
--=A0
Scott Gilliland
imtc.gatech.edu/people/scott-gilliland
   =20
From: Takashi Iwai <tiwai@suse.de>
Sent: Friday, June 23, 2017 10:02:18 AM
To: Gilliland, Scott M
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Bug in ALSA-utils/arecord with --max-file-time
=A0  =20
On Fri, 23 Jun 2017 00:08:58 +0200,
Gilliland, Scott M wrote:
>=20
> Hi All,
>=20
> I seem to have found a minor bug in aplay, within alsa-utils 1.1.4. It's =
possible that I'm the first person who's ever hit it. This appears to be th=
e correct place to report it; if not, I humbly apologize, and ask for direc=
tion on where to submit this.
>=20
> In aplay.c, around line 3030, we do this calculation:
>=20
>=A0=A0=A0=A0=A0=A0=A0=A0 max_file_size =3D max_file_time *
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_format_size(hwpar=
ams.format,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hwparams.rate * hwparams.channels);
>=20
> We do this to convert max_file_time from the '--max-file-time' parameter =
(an int) into max_file_size, a file length in bytes (a long long). Since sn=
d_pcm_format_size() may return something 32-bit, this might overflow 32-bit=
s when we do the multiplication,  wasting the extra bytes of max_file_size.=
=20
>=20
> On my test case on an armv7l system, a 1800-second file at 192 KHz record=
ed in S24_3LE doesn't overflow, but recording in S32_LE does. I accidentall=
y found an edge case.=A0 In case anyone wants to know, the failure mode is =
that arecord will repeatedly create  44 byte .wav files very quickly, since=
 these are larger than the negative max file size. This continues until you=
 have a directory full of thousands of 44-byte files. Hilarious.
>=20
> A simple change to cast max_file_time to a long long fixes this in my tes=
t case. There might be some cleaner solution, but this at least worked for =
me.
>=20
>=A0=A0=A0=A0=A0=A0=A0=A0 max_file_size =3D (long long) max_file_time *
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_format_size(hwpar=
ams.format,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hwparams.rate * hwparams.channels);
>=20
> Hopefully someone can vet this and carry it over to git. I've attached a =
patch file as well.

The change looks good.=A0 Could you post as a proper patch, i.e. with a
commit log and your sign-off?


> Additionally, while working to report this, I noticed that the bug tracke=
r link on the sidebar of https://www.alsa-project.org/main/index.php/Main_P=
age is a dead link.

Yeah, it's a known problem for long time...


Takashi
    =

--_002_CY4PR07MB3544205668C0A73D14F0C3C88DD80CY4PR07MB3544namp_
Content-Type: text/x-patch; name="max-size-cast.patch"
Content-Description: max-size-cast.patch
Content-Disposition: attachment; filename="max-size-cast.patch"; size=735;
	creation-date="Fri, 23 Jun 2017 15:11:37 GMT";
	modification-date="Fri, 23 Jun 2017 15:11:37 GMT"
Content-Transfer-Encoding: base64

Y29tbWl0IDY5ODA5MmVlZmYwMWQ3NDA1NmVjMzNhYzFkYTc0ZTQwN2VkZjUzZTcKQXV0aG9yOiBT
Y290dCA8c2NvdHQuZ2lsbGlsYW5kQGdhdGVjaC5lZHU+CkRhdGU6ICAgRnJpIEp1biAyMyAxMTow
Mjo1OSAyMDE3IC0wNDAwCgogICAgRml4ZXMgYSBidWcgd2l0aCAtLW1heC1maWxlLXRpbWUgd2hl
cmUgdGhlIGZpbGUgc2l6ZSBjb3VsZCBvdmVyZmxvdyAzMiBiaXRzLCBjYXVzaW5nIHRob3VzYW5k
cyBvZiB0aW55IGZpbGVzLgoKZGlmZiAtLWdpdCBhL2FwbGF5L2FwbGF5LmMgYi9hcGxheS9hcGxh
eS5jCmluZGV4IGY3OTNjODIuLjAwYWY2NjIgMTAwNjQ0Ci0tLSBhL2FwbGF5L2FwbGF5LmMKKysr
IGIvYXBsYXkvYXBsYXkuYwpAQCAtMzAyNyw3ICszMDI3LDcgQEAgc3RhdGljIHZvaWQgY2FwdHVy
ZShjaGFyICpvcmlnX25hbWUpCiAJaWYgKGNvdW50ID09IDApCiAJCWNvdW50ID0gTExPTkdfTUFY
OwogCS8qIGNvbXB1dGUgdGhlIG51bWJlciBvZiBieXRlcyBwZXIgZmlsZSAqLwotCW1heF9maWxl
X3NpemUgPSBtYXhfZmlsZV90aW1lICoKKwltYXhfZmlsZV9zaXplID0gKGxvbmcgbG9uZykgbWF4
X2ZpbGVfdGltZSAqCiAJCXNuZF9wY21fZm9ybWF0X3NpemUoaHdwYXJhbXMuZm9ybWF0LAogCQkJ
CSAgICBod3BhcmFtcy5yYXRlICogaHdwYXJhbXMuY2hhbm5lbHMpOwogCS8qIFdBVkUtZmlsZSBz
aG91bGQgYmUgZXZlbiAoSSdtIG5vdCBzdXJlKSwgYnV0IHdhc3Rpbmcgb25lIGJ5dGUK

--_002_CY4PR07MB3544205668C0A73D14F0C3C88DD80CY4PR07MB3544namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_CY4PR07MB3544205668C0A73D14F0C3C88DD80CY4PR07MB3544namp_--
