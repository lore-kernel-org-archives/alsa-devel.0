From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: multiple definitions of 'to_psc_dma_stream' in
	kernel-2.6.34
Date: Mon, 14 Jun 2010 00:08:35 -0600
Message-ID: <AANLkTiml3FaTkoCG2e7RFkHNotXKV2YwwHIKiSMGVN3R@mail.gmail.com>
References: <fbb4cc272573e.4c140aa0@rwth-aachen.de>
	<AANLkTikk-G6xFvZ71ybmHJS3u4jUSid78mSUCzEn45ua@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151743f90edaca210488f75200
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
	[209.85.211.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BDC82464B
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 08:08:58 +0200 (CEST)
Received: by ywh32 with SMTP id 32so2413588ywh.5
	for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2010 23:08:55 -0700 (PDT)
In-Reply-To: <AANLkTikk-G6xFvZ71ybmHJS3u4jUSid78mSUCzEn45ua@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, John Linkhorst <John.Linkhorst@rwth-aachen.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

--00151743f90edaca210488f75200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 12, 2010 at 2:56 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Grant, is this something you did?

Please try the attached fix.

g.

>
> commit 1d8222e8df07ce4f86fb7fa80b02bdee03b57985
> Author: Grant Likely <grant.likely@secretlab.ca>
> Date: =A0 Sat Nov 7 01:34:31 2009 -0700
>
> =A0 =A0ASoC/mpc5200: add to_psc_dma_stream() helper
>
> =A0 =A0Move the resolving of the psc_dma_stream pointer to a helper funct=
ion
> =A0 =A0to reduce duplicate code
>
> =A0 =A0Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> =A0 =A0Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
> =A0 =A0Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
>
> On Sat, Jun 12, 2010 at 4:30 PM, John Hilmar Linkhorst
> <John.Linkhorst@rwth-aachen.de> wrote:
>> Dear Jon,
>>
>> while compiling the kernel for my efika machine I ran into the following=
 error:
>>
>> LD =A0 =A0 =A0sound/soc/fsl/built-in.o
>> sound/soc/fsl/mpc5200_psc_ac97.o: In function `to_psc_dma_stream':
>> mpc5200_psc_ac97.c:(.text+0x0): multiple definition of `to_psc_dma_strea=
m'
>> sound/soc/fsl/mpc5200_dma.o:mpc5200_dma.c:(.text+0x0): first defined her=
e
>> sound/soc/fsl/efika-audio-fabric.o: In function `to_psc_dma_stream':
>> efika-audio-fabric.c:(.text+0x0): multiple definition of `to_psc_dma_str=
eam'
>> sound/soc/fsl/mpc5200_dma.o:mpc5200_dma.c:(.text+0x0): first defined her=
e
>> make[3]: *** [sound/soc/fsl/built-in.o] Error 1
>> make[2]: *** [sound/soc/fsl] Error 2
>> make[1]: *** [sound/soc] Error 2
>> make: *** [sound] Error 2
>>
>> could you help me solving this problem?
>>
>> best regards
>> John Linkhorst
>>
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

--00151743f90edaca210488f75200
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-powerpc-5200-Fix-build-error-in-sound-code.patch"
Content-Disposition: attachment;
	filename="0001-powerpc-5200-Fix-build-error-in-sound-code.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gaewky9j0

RnJvbSAxNTYzM2FkNzAzNmRiYzU2ZTA4MTQyMDM4MmMwMDE2ZTU1YmUzMzE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBzZWNyZXRsYWIu
Y2E+CkRhdGU6IE1vbiwgMTQgSnVuIDIwMTAgMDA6MDM6MzQgLTA2MDAKU3ViamVjdDogW1BBVENI
XSBwb3dlcnBjLzUyMDA6IEZpeCBidWlsZCBlcnJvciBpbiBzb3VuZCBjb2RlLgoKQ29tcGlsaW5n
IGluIHRoZSBNUEM1MjAwIHNvdW5kIGRyaXZlcnMgcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nIGJ1
aWxkIGVycm9yOgoKc291bmQvc29jL2ZzbC9tcGM1MjAwX3BzY19hYzk3Lm86IEluIGZ1bmN0aW9u
IGB0b19wc2NfZG1hX3N0cmVhbSc6Cm1wYzUyMDBfcHNjX2FjOTcuYzooLnRleHQrMHgwKTogbXVs
dGlwbGUgZGVmaW5pdGlvbiBvZiBgdG9fcHNjX2RtYV9zdHJlYW0nCnNvdW5kL3NvYy9mc2wvbXBj
NTIwMF9kbWEubzptcGM1MjAwX2RtYS5jOigudGV4dCsweDApOiBmaXJzdCBkZWZpbmVkIGhlcmUK
c291bmQvc29jL2ZzbC9lZmlrYS1hdWRpby1mYWJyaWMubzogSW4gZnVuY3Rpb24gYHRvX3BzY19k
bWFfc3RyZWFtJzoKZWZpa2EtYXVkaW8tZmFicmljLmM6KC50ZXh0KzB4MCk6IG11bHRpcGxlIGRl
ZmluaXRpb24gb2YgYHRvX3BzY19kbWFfc3RyZWFtJwpzb3VuZC9zb2MvZnNsL21wYzUyMDBfZG1h
Lm86bXBjNTIwMF9kbWEuYzooLnRleHQrMHgwKTogZmlyc3QgZGVmaW5lZCBoZXJlCm1ha2VbM106
ICoqKiBbc291bmQvc29jL2ZzbC9idWlsdC1pbi5vXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbc291
bmQvc29jL2ZzbF0gRXJyb3IgMgptYWtlWzFdOiAqKiogW3NvdW5kL3NvY10gRXJyb3IgMgptYWtl
OiAqKiogW3NvdW5kXSBFcnJvciAyCgpUaGlzIHBhdGNoIGZpeGVzIGl0IGJ5IGRlY2xhcmluZyB0
aGUgaW5saW5lIGZ1bmN0aW9uIGluIHRoZSBoZWFkZXIgZmlsZSB0bwphbHNvIGJlIGEgc3RhdGlj
LgoKU2lnbmVkLW9mZi1ieTogR3JhbnQgTGlrZWx5IDxncmFudC5saWtlbHlAc2VjcmV0bGFiLmNh
PgpDYzogTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+CkNj
OiBqb25zbWlybEBnbWFpbC5jb20KLS0tCiBzb3VuZC9zb2MvZnNsL21wYzUyMDBfZG1hLmggfCAg
ICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL21wYzUyMDBfZG1hLmggYi9zb3VuZC9zb2MvZnNs
L21wYzUyMDBfZG1hLmgKaW5kZXggMjIyMDhiMy4uZTFlYzZkOSAxMDA2NDQKLS0tIGEvc291bmQv
c29jL2ZzbC9tcGM1MjAwX2RtYS5oCisrKyBiL3NvdW5kL3NvYy9mc2wvbXBjNTIwMF9kbWEuaApA
QCAtNzMsNyArNzMsNyBAQCBzdHJ1Y3QgcHNjX2RtYSB7CiB9OwogCiAvKiBVdGlsaXR5IGZvciBy
ZXRyaWV2aW5nIHBzY19kbWFfc3RyZWFtIHN0cnVjdHVyZSBmcm9tIGEgc3Vic3RyZWFtICovCi1p
bmxpbmUgc3RydWN0IHBzY19kbWFfc3RyZWFtICoKK3N0YXRpYyBpbmxpbmUgc3RydWN0IHBzY19k
bWFfc3RyZWFtICoKIHRvX3BzY19kbWFfc3RyZWFtKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAq
c3Vic3RyZWFtLCBzdHJ1Y3QgcHNjX2RtYSAqcHNjX2RtYSkKIHsKIAlpZiAoc3Vic3RyZWFtLT5w
c3RyLT5zdHJlYW0gPT0gU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFKQotLSAKMS43LjAuNAoK
--00151743f90edaca210488f75200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00151743f90edaca210488f75200--
