From: Kailang <kailang@realtek.com>
Subject: Re: ALC275 COEF stuff?
Date: Wed, 8 Nov 2017 07:34:44 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A183F921F@RTITMBSV02.realtek.com.tw>
References: <s5h1slajlbx.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A183F920A@RTITMBSV02.realtek.com.tw>
 <s5hh8u5w8i9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A183F921FRTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 10E4F2673FD
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 08:34:49 +0100 (CET)
In-Reply-To: <s5hh8u5w8i9.wl-tiwai@suse.de>
Content-Language: zh-TW
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
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F921FRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Hi Takashi,

Attach patch for test.
Thanks.

BR,
Kailang

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]=20
> Sent: Wednesday, November 08, 2017 3:11 PM
> To: Kailang
> Subject: Re: ALC275 COEF stuff?
>=20
> On Wed, 08 Nov 2017 07:50:27 +0100,
> Kailang wrote:
> >=20
> >=20
> > Hi Takashi,
> >=20
> > ALC275 had no EAPD control COEF register.
> > So, BIOS verb table default will write COEF Index 0x0e bit 0 to 1.
> > This is enable class-D power up.=20
> > Windows restart will remove driver, it will write Index=20
> 0x0e bit 0 to=20
> > 0. (Power down class-D power) Maybe this will resolve the pop noise.
> >=20
> > So, I think add write COEF Index 0x0e bit 0 to 1 at EAPD=20
> site will sovle this issue.
> > I could make a patch for you.
>=20
> Great, thanks!
>=20
> BTW, there is another bug report about the missing right=20
> speaker output on Huawei MateBook X with ALC298:
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D197801
>=20
> Can it be some missing COEF, too?
>=20
>=20
> Takashi
>=20
>=20
> > Thanks.
> >=20
> > BR,
> > Kailang
> >=20
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Tuesday, November 07, 2017 9:00 PM
> > > To: Kailang
> > > Subject: ALC275 COEF stuff?
> > >=20
> > > Hi Kailang,
> > >=20
> > > we got a bug report about the possibly missing COEF setup for
> > > ALC275 on Sony VAIO.
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=3D197737
> > >=20
> > > Could you check whether the suggested verbs are correct?
> > >=20
> > > Thanks!
> > >=20
> > >=20
> > > Takashi
> > >=20
> > >=20
> > > ------Please consider the environment before printing this e-mail.
> > >=20
> =

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F921FRTITMBSV02realt_
Content-Type: application/octet-stream; name="0000-alc275-no-sound.patch"
Content-Description: 0000-alc275-no-sound.patch
Content-Disposition: attachment; filename="0000-alc275-no-sound.patch";
	size=888; creation-date="Wed, 08 Nov 2017 07:33:12 GMT";
	modification-date="Wed, 08 Nov 2017 07:32:45 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmODQxZDkyOGE1MjAyMDBmOGRmM2NmN2I5NTMyYWI5NjU5NDI0ODg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgOCBOb3YgMjAxNyAxNToyODozMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gRml4IEFMQzI3NSBubyBzb3VuZCBpc3N1ZQoKU291bmQgd29ya3MgYWZ0
ZXIgYSBjb2xkIGJvb3QgYnV0IG5vdCBhZnRlciBhIHJlYm9vdCBmcm9tIHdpbmRvd3MuClRoaXMg
cGF0Y2ggd2lsbCBzb2x2ZSB0aGlzIGlzc3VlLiBUaGlzIGlzIHJlbGF0aW9uIHdpdGggQ2xhc3Mt
RCBwb3dlciBjb250cm9sLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJl
YWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIv
c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggOWI3N2Q0My4uMDJiMTkyZiAxMDA2
NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMKQEAgLTM0MSw2ICszNDEsOSBAQCBzdGF0aWMgdm9pZCBhbGNfZmls
bF9lYXBkX2NvZWYoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJY2FzZSAweDEwZWMwMjk5Ogog
CQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDEwLCAxPDw5LCAwKTsKIAkJYnJlYWs7CisJ
Y2FzZSAweDEwZWMwMjc1OgorCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweGUsIDAsIDE8
PDApOworCQlicmVhazsKIAljYXNlIDB4MTBlYzAyOTM6CiAJCWFsY191cGRhdGVfY29lZl9pZHgo
Y29kZWMsIDB4YSwgMTw8MTMsIDApOwogCQlicmVhazsK

--_002_6FAB7C47BCF00940BB0999A99BE3547A183F921FRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A183F921FRTITMBSV02realt_--
