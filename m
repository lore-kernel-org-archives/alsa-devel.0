From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: SEGFault when
	optininal	snd_ctl_ext_callback::read_event() not set
Date: Thu, 5 Oct 2017 14:28:33 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684A3E29@HI2EXCH01.adit-jv.com>
References: <B0FB33DC1499054591F62C0EF1E013D7684A3E0F@HI2EXCH01.adit-jv.com>,
 <s5hk209ybsv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_B0FB33DC1499054591F62C0EF1E013D7684A3E29HI2EXCH01aditjv_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D1E95266A73
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 16:28:44 +0200 (CEST)
In-Reply-To: <s5hk209ybsv.wl-tiwai@suse.de>
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

--_002_B0FB33DC1499054591F62C0EF1E013D7684A3E29HI2EXCH01aditjv_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,=0A=
=0A=
see attached the patch.=0A=
>From my opinion failing with an error is the best solution (see explanation=
 in the commit message)=0A=
=0A=
=0A=
Best regards=0A=
=0A=
Timo Wischer=0A=
=0A=
Advanced Driver Information Technology GmbH=0A=
Engineering Software Base (ADITG/ESB)=0A=
Robert-Bosch-Str. 200=0A=
31139 Hildesheim=0A=
Germany=0A=
=0A=
Tel. +49 5121 49 6938=0A=
Fax +49 5121 49 6999=0A=
twischer@de.adit-jv.com=0A=
=0A=
ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multi=
media GmbH and DENSO Corporation=0A=
Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438=0A=
Gesch=E4ftsf=FChrung: Wilhelm Grabow, Ken Yaguchi=0A=
=0A=
________________________________________=0A=
From: Takashi Iwai [tiwai@suse.de]=0A=
Sent: Thursday, October 05, 2017 3:17 PM=0A=
To: Wischer, Timo (ADITG/ESB)=0A=
Cc: alsa-devel@alsa-project.org=0A=
Subject: Re: [alsa-devel] SEGFault when optininal       snd_ctl_ext_callbac=
k::read_event() not set=0A=
=0A=
On Thu, 05 Oct 2017 14:03:14 +0200,=0A=
Wischer, Timo (ADITG/ESB) wrote:=0A=
>=0A=
> Hi all,=0A=
>=0A=
> snd_ctl_ext_callback::read_event() callback is mentioned as optional=0A=
> (see http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob;f=3Dinclude/c=
ontrol_external.h;h=3D12958e70a5230de9c74029c641a395a2073c8646;hb=3Drefs/he=
ads/master#l239)=0A=
>=0A=
> but there is no NULL check and the NULL pointer will be called if the rea=
d_event function callback pointer is not set.=0A=
> (see http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob;f=3Dsrc/contr=
ol/control_ext.c;h=3D56552fa1aa0ef0e6383abf4029b63944a841c2c4;hb=3Drefs/hea=
ds/master#l419)=0A=
>=0A=
> I think a default function has to be provided which will be called when t=
he callback is not set or the read_event() callback should not be marked as=
 optional.=0A=
>=0A=
> What is your opinion?=0A=
=0A=
It should have a NULL check there, as documentation clearly states=0A=
that it's optional.=0A=
=0A=
Care to submit a fix patch?=0A=
=0A=
=0A=
thanks,=0A=
=0A=
Takashi=0A=

--_002_B0FB33DC1499054591F62C0EF1E013D7684A3E29HI2EXCH01aditjv_
Content-Type: text/x-patch; name="alsa-lib-ctl-ext-read-event.patch"
Content-Description: alsa-lib-ctl-ext-read-event.patch
Content-Disposition: attachment;
	filename="alsa-lib-ctl-ext-read-event.patch"; size=1519;
	creation-date="Thu, 05 Oct 2017 14:28:14 GMT";
	modification-date="Thu, 05 Oct 2017 14:28:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4Y2MzZGJjNmZhZDBhNGRlODJhYjRiNWM5NWE4NjQ5OWM5OWQ1NmQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW1vIFdpc2NoZXIgPHR3aXNjaGVyQGRlLmFkaXQtanYuY29t
PgpEYXRlOiBUaHUsIDUgT2N0IDIwMTcgMTY6MjU6MjMgKzAyMDAKU3ViamVjdDogY3RsOiBleHQ6
IEZhaWwgd2l0aCBlcnJvciBjb2RlIGlmIHNuZF9jdGxfZXh0X2NhbGxiYWNrOjpyZWFkX2V2ZW50
KCkKIGNhbGxiYWNrIGlzIG5vdCBkZWZpbmVkCgpUaGUgc25kX2N0bF9leHRfY2FsbGJhY2s6OnJl
YWRfZXZlbnQoKSBjYWxsYmFjayBpcyBvbmx5IG9wdGlvbmFsCmlmIG5vIHBvbGwgZGVzY3JpcHRv
ciB3YXMgZ2l2ZW4gdmlhCnNuZF9jdGxfZXh0X3Q6OnBvbGxfZmQKb3IKc25kX2N0bF9leHRfY2Fs
bGJhY2s6OnNuZF9jdGxfZXh0X3BvbGxfZGVzY3JpcHRvcnMoKS4KCklmIGEgcG9sbCBkZXNjcmlw
dG9yIGlzIGdpdmVuIHRoZQpzbmRfY3RsX2V4dF9jYWxsYmFjazo6cmVhZF9ldmVudCgpCmNhbGxi
YWNrIGhhcyBhbHNvIHRvIGJlIGRlZmluZWQKYmVjYXVzZSB0aGVyZSBpcyBubyBtaW5pZ2Z1bCBk
ZWZhdWx0IGJlaGF2aW9yLgoKVGhpcyBjYWxsYmFjayB3aWxsIGJlIGNhbGxlZCB3aGVuIGV2ZXIg
dGhlIHBvbGwoKSBvbgp0aGUgZmlsZSBkZXNjcmlwdG9yIGluZGljYXRlcyB0aGF0IHRoZXJlIGlz
IGFuIGV2ZW50IHBlbmRpbmcuClRoZXJlZm9yZSByZXR1cm5pbmcgYSAwIHdoaWNoIGluZGljYXRl
cyB0aGF0IHRoZXJlIGlzIG5vIGV2ZW50IG1ha2VzIG5vCnNlbnNlLgoKU2lnbmVkLW9mZi1ieTog
VGltbyBXaXNjaGVyIDx0d2lzY2hlckBkZS5hZGl0LWp2LmNvbT4KCmRpZmYgLS1naXQgYS9zcmMv
Y29udHJvbC9jb250cm9sX2V4dC5jIGIvc3JjL2NvbnRyb2wvY29udHJvbF9leHQuYwppbmRleCA1
NjU1MmZhLi5kN2RlOGU4IDEwMDY0NAotLS0gYS9zcmMvY29udHJvbC9jb250cm9sX2V4dC5jCisr
KyBiL3NyYy9jb250cm9sL2NvbnRyb2xfZXh0LmMKQEAgLTQxNSw4ICs0MTUsMTIgQEAgc3RhdGlj
IGludCBzbmRfY3RsX2V4dF9yZWFkKHNuZF9jdGxfdCAqaGFuZGxlLCBzbmRfY3RsX2V2ZW50X3Qg
KmV2ZW50KQogewogCXNuZF9jdGxfZXh0X3QgKmV4dCA9IGhhbmRsZS0+cHJpdmF0ZV9kYXRhOwog
Ci0JbWVtc2V0KGV2ZW50LCAwLCBzaXplb2YoKmV2ZW50KSk7Ci0JcmV0dXJuIGV4dC0+Y2FsbGJh
Y2stPnJlYWRfZXZlbnQoZXh0LCAmZXZlbnQtPmRhdGEuZWxlbS5pZCwgJmV2ZW50LT5kYXRhLmVs
ZW0ubWFzayk7CisJaWYgKGV4dC0+Y2FsbGJhY2stPnJlYWRfZXZlbnQpIHsKKwkJbWVtc2V0KGV2
ZW50LCAwLCBzaXplb2YoKmV2ZW50KSk7CisJCXJldHVybiBleHQtPmNhbGxiYWNrLT5yZWFkX2V2
ZW50KGV4dCwgJmV2ZW50LT5kYXRhLmVsZW0uaWQsICZldmVudC0+ZGF0YS5lbGVtLm1hc2spOwor
CX0KKworCXJldHVybiAtRUlOVkFMOwogfQogCiBzdGF0aWMgaW50IHNuZF9jdGxfZXh0X3BvbGxf
ZGVzY3JpcHRvcnNfY291bnQoc25kX2N0bF90ICpoYW5kbGUpCg==

--_002_B0FB33DC1499054591F62C0EF1E013D7684A3E29HI2EXCH01aditjv_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_B0FB33DC1499054591F62C0EF1E013D7684A3E29HI2EXCH01aditjv_--
