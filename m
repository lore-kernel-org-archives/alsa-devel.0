From: Cliff Cai <xcahua@hotmail.com>
Subject: How to support several cards using the same driver?
Date: Thu, 1 May 2008 07:52:25 +0000
Message-ID: <BAY110-W187EE91BBEB88E7E215629C9DB0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_481976C0.6B48F682"
Return-path: <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------------=_481976C0.6B48F682
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Spam detection software, running on the system "alsa0.alsa-project.org", =
has
identified this incoming email as possible spam.  The original message
has been attached to this so you can view it (if it isn't spam) or label
similar future email.  If you have any questions, see
postmaster@alsa-project.org for details.

Content preview:  Hi all, I have a sound card which has 8 DAC/ADC pairs,a=
nd
  each DAC/ADC pair can be seen as an independent sub-card. An 8-slot buf=
fer
   struct is introduced to feed/get data to/from the 8 sub-cards.For exam=
ple,
   if an application wants to play music using No.x(x,from 0 to 7) sub-ca=
rd,the
   driver only need to copy the data from pcm layer to NO.x slot in the b=
uffer
   struct and fill the other 7 slots with zero. The driver has been imple=
mented
   now. The problem is how to expose the 8 sub-cards to application,So th=
e application
   developer can see 8 independant device nodes under /dev.Those are /dev=
/dsp0,/dev/dsp1,...dev/dsp7(for
   oss emulation) or card0,card1...card7(for alsa).When one sub-card is o=
pened
   the driver need to get the index of the sub-card,so it can feed/get da=
ta
  to/from the relevant slot.For example ,if an application opens /dev/dsp=
7,
  then the index "7" can be seen by the driver,and the driver know that N=
o.7
   slot will be used. Have I made myself clear?Any suggestion is apprecia=
ted!
   [...]=20

Content analysis details:   (12.8 points, 5.0 required)

 pts rule name              description
---- ---------------------- ---------------------------------------------=
-----
 2.8 MIME_BASE64_TEXT       RAW: Message text disguised using base64 enco=
ding
  10 PRX_GB2312_CHARSET     GB2312 charset in Content-Type or Subject



------------=_481976C0.6B48F682
Content-Type: message/rfc822; x-spam-type=original
Content-Description: original message before SpamAssassin
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from alsa0.perex.cz (localhost [127.0.0.1])
	by alsa0.perex.cz (Postfix) with ESMTP id DA8DF24855;
	Thu,  1 May 2008 09:52:31 +0200 (CEST)
X-Original-To: alsa-devel@alsa-project.org
Delivered-To: alsa-devel@alsa-project.org
Received: by alsa0.perex.cz (Postfix, from userid 1000)
	id 84D3A24857; Thu,  1 May 2008 09:52:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	alsa0.alsa-project.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=5.0 tests=HTML_MESSAGE
	autolearn=disabled version=3.2.4
Received: from bay0-omc2-s35.bay0.hotmail.com (bay0-omc2-s35.bay0.hotmail.com
	[65.54.246.171]) by alsa0.perex.cz (Postfix) with ESMTP id 7756924854
	for <alsa-devel@alsa-project.org>;
	Thu,  1 May 2008 09:52:27 +0200 (CEST)
Received: from BAY110-W18 ([65.54.229.118]) by bay0-omc2-s35.bay0.hotmail.com
	with Microsoft SMTPSVC(6.0.3790.3959);
	Thu, 1 May 2008 00:52:26 -0700
Message-ID: <BAY110-W187EE91BBEB88E7E215629C9DB0@phx.gbl>
X-Originating-IP: [137.71.230.54]
From: Cliff Cai <xcahua@hotmail.com>
To: <alsa-devel@alsa-project.org>
Date: Thu, 1 May 2008 07:52:25 +0000
Importance: Normal
MIME-Version: 1.0
X-OriginalArrivalTime: 01 May 2008 07:52:26.0088 (UTC)
	FILETIME=[4C084680:01C8AB60]
X-Content-Filtered-By: Mailman/MimeDel 2.1.9
Subject: [alsa-devel] How to support several cards using the same driver?
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
	http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org

CkhpIGFsbCwKICAgSSBoYXZlIGEgc291bmQgY2FyZCB3aGljaCBoYXMgOCBEQUMvQURDIHBhaXJz
LGFuZCBlYWNoIERBQy9BREMgcGFpciBjYW4gYmUgc2VlbiBhcyBhbiBpbmRlcGVuZGVudCBzdWIt
Y2FyZC4KQW4gOC1zbG90IGJ1ZmZlciBzdHJ1Y3QgaXMgaW50cm9kdWNlZCB0byBmZWVkL2dldCBk
YXRhIHRvL2Zyb20gdGhlIDggc3ViLWNhcmRzLkZvciBleGFtcGxlLCBpZiBhbiBhcHBsaWNhdGlv
biB3YW50cyB0byBwbGF5IG11c2ljIHVzaW5nCk5vLngoeCxmcm9tIDAgdG8gNykgc3ViLWNhcmQs
dGhlIGRyaXZlciBvbmx5IG5lZWQgdG8gY29weSB0aGUgZGF0YSBmcm9tIHBjbSBsYXllciB0byBO
Ty54IHNsb3QgaW4gdGhlIGJ1ZmZlciBzdHJ1Y3QgYW5kIGZpbGwgdGhlIG90aGVyIDcgc2xvdHMg
d2l0aCB6ZXJvLgpUaGUgZHJpdmVyIGhhcyBiZWVuIGltcGxlbWVudGVkIG5vdy4KICAgVGhlIHBy
b2JsZW0gaXMgaG93IHRvIGV4cG9zZSB0aGUgOCBzdWItY2FyZHMgdG8gYXBwbGljYXRpb24sU28g
dGhlIGFwcGxpY2F0aW9uIGRldmVsb3BlciBjYW4gc2VlIDggaW5kZXBlbmRhbnQgZGV2aWNlIG5v
ZGVzCnVuZGVyIC9kZXYuVGhvc2UgYXJlIC9kZXYvZHNwMCwvZGV2L2RzcDEsLi4uZGV2L2RzcDco
Zm9yIG9zcyBlbXVsYXRpb24pIG9yIGNhcmQwLGNhcmQxLi4uY2FyZDcoZm9yIGFsc2EpLldoZW4g
b25lIHN1Yi1jYXJkIGlzIG9wZW5lZCAKdGhlIGRyaXZlciBuZWVkIHRvIGdldCB0aGUgaW5kZXgg
b2YgdGhlIHN1Yi1jYXJkLHNvIGl0IGNhbiBmZWVkL2dldCBkYXRhIHRvL2Zyb20gdGhlIHJlbGV2
YW50IHNsb3QuRm9yIGV4YW1wbGUgLGlmIGFuIGFwcGxpY2F0aW9uIG9wZW5zIC9kZXYvZHNwNywK
dGhlbiB0aGUgaW5kZXggIjciIGNhbiBiZSBzZWVuIGJ5IHRoZSBkcml2ZXIsYW5kIHRoZSBkcml2
ZXIga25vdyB0aGF0IE5vLjcgc2xvdCB3aWxsIGJlIHVzZWQuCiAgIEhhdmUgSSBtYWRlIG15c2Vs
ZiBjbGVhcj9Bbnkgc3VnZ2VzdGlvbiBpcyBhcHByZWNpYXRlZCEKIApCZXN0IFJlZ2FyZHMKIApD
bGlmZgogCi4KIAogCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCrbguPbTys/kzayyvbncwO2jrGxpdmUgbWFpbL/Nu6e2y83y
yMvHwNPD1tAKaHR0cDovL2dldC5saXZlLmNuL3Byb2R1Y3QvbWFpbC5odG1sCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=

------------=_481976C0.6B48F682--
