From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: [Alsa-user] Audigy multichannel and line-in did not work in	Linux 2.6.7
Date: Tue, 7 Sep 2004 09:18:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409070718.i877IHol013713@www3.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: MULTIPART/mixed; charset=iso-8859-2; BOUNDARY="97783256-1804289383-1094541498=:13712"
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
To: rlrevell@joe-job.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--97783256-1804289383-1094541498=:13712
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

There is check for channel count (1,2,4,8).
Attached patch will add suppor for 16,32,64.

Could you test this ??? I tryed 32 and 64 channels an looks like it
works. I can not test (no time to do this) if recorded data are good.
Maybe if you remove this check completly hardware will work with 10
channels too, who know.

Peter Zubaj
=0A____________________________________=0Ahttp://www.logofun.pobox.sk - uro=
bte radost svojmu telefonu=0A
--97783256-1804289383-1094541498=:13712
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

--97783256-1804289383-1094541498=:13712--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
