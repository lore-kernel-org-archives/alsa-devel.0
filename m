From: Richard Liu <richliu@ite.techarea.org>
Subject: Re: [Announce] ITE ac97 codec patch ( IT2226E)
Date: Tue, 13 Aug 2002 16:24:07 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020813145624.0EB8.RICHLIU@ite.techarea.org>
References: <20020809151755.C11E.RICHLIU@ite.techarea.org> <s5hn0rw5sj6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------_3D58AD980EA303F65908_MULTIPART_MIXED_"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0rw5sj6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA-ML <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--------_3D58AD980EA303F65908_MULTIPART_MIXED_
Content-Type: text/plain; charset="BIG5"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by pine.yuntech.edu.tw id QAA14482

Hi.=20
   We don't announce this driver to end user. So you cannot download it=20
from our website.

   Here is patch file, thank for your help.

On Fri, 09 Aug 2002 10:46:05 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Hi,
>=20
> At Fri, 09 Aug 2002 15:23:48 +0800,
> Richard Liu wrote:
> >=20
> > Hi.=20
> >   Here have a ITE ac97 codec patch for alsa-driver-0.9.0rc2
> > ITE is a IC design house which have many IC productions.
> >=20
> > ITE develope a AC97 codec for INTEL ICH4, but we found some problem
> > in probe AC97 codec on ICH4, so I mark the key code,
> > let snd_intel8x0 can run our chip .=20
> >=20
> > this code we test in Mandrake 8.2 , I use newest stable release kerne=
l=20
> > 2.4.19 and alsa-driver-0.9.0rc2 test it, and ok.
>=20
> could you give us the exact url for the patch (or attach to the mail)?
> i couldn't find the place storing the patch from www.ite.com.tw.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--
ICQ: 4724847
=BCB=BBF=B8=EA=20

--------_3D58AD980EA303F65908_MULTIPART_MIXED_
Content-Type: application/octet-stream; name="ite-ac97.patch.bz2"
Content-Disposition: attachment;
 filename="ite-ac97.patch.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWbXVlO8AAmLfgBwwW3//+/v33j6//9/qUAOZ7da7XOcU1XXhJKJptRqbJNpGAjQy
aPRAMJoAAaAAJREap+TKaDU0wjIaAAAAAAAABKaSaJMymajQaZBiNAAAAAAANBw00wQyGmmRkwgG
mgDCaNMmABA0EihE2lPKjynp6T0o9Ewh6QYgaMmIGjEaeUHqROsEgrkoggkJJDdJAgmScgzpQThh
r6OGTKu3ntVIDzTkGtVJJwSS/iJJNcIlcjiyxFL3u1kqGQYA02sRCRAkBgLb+mGzSb+KHXp8a33T
O5HaRBMVxFMD5fwz5orbNSNauc8hWqQXMRMxu6CVYbl6zS+rBho3umxifRKzeYzFgVYv9K8ZlGRF
VlqDW4bdyFz5bCzZjKB50jtEcEMb70lCZ2BB0o2GxsPlj4jvz5JNWW4Bjth/Pnndi51ApZv5865S
DgR3eKkY0WFwMZBDMhxohGVkB5ZBmGFWatZ+1DRrcjZ+B1B56dPmCQvofS1xgRb2L60qzE7H1fcQ
kkYA4WyN1ikLNhJCSgG8gwnB64L3t2gVV5EZwoDLVRmwBXMGFK4Y5Ee1ABKoqi8luSEIPI29cmqh
n2mKZg87DtVeWmeh4pici5CLLpU1sictj03WGCiLhpGK6Upx+OFymlHPSUyuCLnKrAIIojqZpoDi
hGJjV7EH3gjaJF1CVY1BdbMwqJDp8NOqzQRPt64jHhPMly9kaJG6BDIxIuoeTlxngK96E+rkWucR
iM60lbTMsyeT5AXX8ojQI5VGYDWEoUMegsXWsZG0atK3XQhzOSj8iKZ0aOCK7F1eVFvs8PwOIia0
ecQfxx4w6Boh5hUGqKCSDTImSL/mSJ6aDLuCsYw+zRD6IkhRJPAeJQrQPOVVDWoFVZs1BHikMbRO
hLuBBGKdUX7ZsSxWvxzqBZQzNL0FMSqLQXiplsYdBqQdKDqLajQBEGMYDGBnAgQNghcdxQDLrrYx
ZIhVtY1aSQSMgqKhh/DsT0vtrBKl9+6TSzwfBJsZXrMgLzVRtw2UG3FNJXkr9qcWawgwdsKjBEYU
02E5Grh5MlZAUWiCA9ooOtRGicdW2uBELztN9U6drjLJ9VwxJLMZkF9lmK8dyDoRChFDqP8S3jGg
mTQVpjsd4UjBJgrDTl2hyFSWdJUvbaQgCIyzJ5JyOraMQ1bhuq1BWrvqDA1MC6xm2roG48Uxdgxa
7EfxdyRThQkLXVlO8A==

--------_3D58AD980EA303F65908_MULTIPART_MIXED_--



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=3D31
