From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Re: [Alsa-user] Audigy multichannel and line-in	did not work in	Linux 2.6.7
Date: Thu, 16 Sep 2004 10:08:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409160808.i8G88V3b015606@www1.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: MULTIPART/mixed; charset=iso-8859-2; BOUNDARY="97782744-1804289383-1095322112=:15605"
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: rlrevell@joe-job.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--97782744-1804289383-1095322112=:15605
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: QUOTED-PRINTABLE

Is this what you wanted ???

Summary: Support for capture of 16,32,64 channels on emu10k1 device 2

This patch changes default constraint on "EFX voices mask" control and
allow capture of 1, 2, 4, 8, 16, 32, 64 channels instead of 1, 2, 4, 8.


Signed-off-by: Peter Zubaj <pzad@pobox.sk>
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0ASpolocnost SUN Microsystems uviedla na trh novy server Sun Fire V20z=0Az=
alozeny procesoroch AMD Opteron.=0AViac informacii najdete na : http://www.=
somi.sk/sun/v20z.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A
--97782744-1804289383-1095322112=:15605
Content-Type: APPLICATION/octet-stream; name="efx_channels.diff"
Content-Transfer-Encoding: BASE64

ZGlmZiAtdSAtciBhbHNhLWRyaXZlci0xLjAuNmEtb2xkL2Fsc2Eta2VybmVs
L3BjaS9lbXUxMGsxL2VtdXBjbS5jIGFsc2EtZHJpdmVyLTEuMC42YS9hbHNh
LWtlcm5lbC9wY2kvZW11MTBrMS9lbXVwY20uYwotLS0gYWxzYS1kcml2ZXIt
MS4wLjZhLW9sZC9hbHNhLWtlcm5lbC9wY2kvZW11MTBrMS9lbXVwY20uYwky
MDA0LTA3LTE0IDE2OjE0OjU0LjAwMDAwMDAwMCArMDAwMAorKysgYWxzYS1k
cml2ZXItMS4wLjZhL2Fsc2Eta2VybmVsL3BjaS9lbXUxMGsxL2VtdXBjbS5j
CTIwMDQtMDktMDYgMTk6NTU6MTkuMDAwMDAwMDAwICswMDAwCkBAIC0xMDky
LDYgKzEwOTIsNyBAQAogCWVtdTEwazFfdCAqZW11ID0gc25kX2tjb250cm9s
X2NoaXAoa2NvbnRyb2wpOwogCXVuc2lnbmVkIGludCBudmFsWzJdLCBiaXRz
OwogCWludCBuZWZ4ID0gZW11LT5hdWRpZ3kgPyA2NCA6IDMyOworCWludCBu
ZWZ4YiA9IGVtdS0+YXVkaWd5ID8gNyA6IDY7CiAJaW50IGNoYW5nZSwgaWR4
OwogCQogCW52YWxbMF0gPSBudmFsWzFdID0gMDsKQEAgLTExMDAsOCArMTEw
MSwxNCBAQAogCQkJbnZhbFtpZHggLyAzMl0gfD0gMSA8PCAoaWR4ICUgMzIp
OwogCQkJYml0cysrOwogCQl9Ci0JaWYgKGJpdHMgIT0gMSAmJiBiaXRzICE9
IDIgJiYgYml0cyAhPSA0ICYmIGJpdHMgIT0gOCkKKwkJCisJZm9yIChpZHgg
PSAwOyBpZHggPCBuZWZ4YjsgaWR4KyspCisJCWlmICgxIDw8IGlkeCA9PSBi
aXRzKQorCQkJYnJlYWs7CisJCisJaWYgKGlkeCA+PSBuZWZ4YikKIAkJcmV0
dXJuIC1FSU5WQUw7CisKIAlzcGluX2xvY2tfaXJxKCZlbXUtPnJlZ19sb2Nr
KTsKIAljaGFuZ2UgPSAobnZhbFswXSAhPSBlbXUtPmVmeF92b2ljZXNfbWFz
a1swXSkgfHwKIAkJKG52YWxbMV0gIT0gZW11LT5lZnhfdm9pY2VzX21hc2tb
MV0pOwo=

--97782744-1804289383-1095322112=:15605--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
