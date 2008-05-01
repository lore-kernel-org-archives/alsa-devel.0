From: Cliff Cai <xcahua@hotmail.com>
Subject: How to support several sound cards using same driver?
Date: Thu, 1 May 2008 13:20:58 +0000
Message-ID: <BAY110-W43E8C1AF6D2E3C64A32AD4C9DB0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_4819C3C3.BB63CA12"
Return-path: <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------------=_4819C3C3.BB63CA12
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
  each DAC/ADC pair can be seen as an independent sub-card.An 8-slot buff=
er
  struct is introduced to feed/get data to/from one of the 8 sub-cards.Fo=
r example,if
   an application wants to play muic using No.7 sub-card,the driver only =
need
   to copy the pcm data from PCM layer to No.7 slot and fill the other 7 =
slots
   with zero.The driver has been implemented. The problem is how to expos=
e the
   8 sub-cards to application developers,so they can see 8 independent de=
vice
   nodesunder /dev?They should be /dev/dsp0,/dev/dsp1,.../dev/dsp7 and ca=
rd0,card1,...card7.Also
   when a sub-card is opened(i.e. /dev/dsp7),the driver must know the sub=
-card's
   index ,here is 7,so it can choose a relevant slot to feed/get data. [.=
..]
  =20

Content analysis details:   (12.8 points, 5.0 required)

 pts rule name              description
---- ---------------------- ---------------------------------------------=
-----
 2.8 MIME_BASE64_TEXT       RAW: Message text disguised using base64 enco=
ding
  10 PRX_GB2312_CHARSET     GB2312 charset in Content-Type or Subject



------------=_4819C3C3.BB63CA12
Content-Type: message/rfc822; x-spam-type=original
Content-Description: original message before SpamAssassin
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from alsa0.perex.cz (localhost [127.0.0.1])
	by alsa0.perex.cz (Postfix) with ESMTP id E7B3F248B0;
	Thu,  1 May 2008 15:21:04 +0200 (CEST)
X-Original-To: alsa-devel@alsa-project.org
Delivered-To: alsa-devel@alsa-project.org
Received: by alsa0.perex.cz (Postfix, from userid 1000)
	id 708E0248BB; Thu,  1 May 2008 15:21:02 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	alsa0.alsa-project.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=5.0 tests=HTML_MESSAGE
	autolearn=disabled version=3.2.4
Received: from bay0-omc2-s22.bay0.hotmail.com (bay0-omc2-s22.bay0.hotmail.com
	[65.54.246.158]) by alsa0.perex.cz (Postfix) with ESMTP id 9A6A3248AF
	for <alsa-devel@alsa-project.org>;
	Thu,  1 May 2008 15:20:59 +0200 (CEST)
Received: from BAY110-W43 ([65.54.229.143]) by bay0-omc2-s22.bay0.hotmail.com
	with Microsoft SMTPSVC(6.0.3790.3959);
	Thu, 1 May 2008 06:20:58 -0700
Message-ID: <BAY110-W43E8C1AF6D2E3C64A32AD4C9DB0@phx.gbl>
X-Originating-IP: [124.78.73.43]
From: Cliff Cai <xcahua@hotmail.com>
To: <alsa-devel@alsa-project.org>
Date: Thu, 1 May 2008 13:20:58 +0000
Importance: Normal
MIME-Version: 1.0
X-OriginalArrivalTime: 01 May 2008 13:20:58.0146 (UTC)
	FILETIME=[3155A020:01C8AB8E]
X-Content-Filtered-By: Mailman/MimeDel 2.1.9
Subject: [alsa-devel] How to support several sound cards using same driver?
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

CkhpIGFsbCwKICBJIGhhdmUgYSBzb3VuZCBjYXJkIHdoaWNoIGhhcyA4IERBQy9BREMgcGFpcnMs
YW5kIGVhY2ggREFDL0FEQyBwYWlyIGNhbiBiZSBzZWVuIGFzIGFuIGluZGVwZW5kZW50IHN1Yi1j
YXJkLkFuIDgtc2xvdCBidWZmZXIgc3RydWN0IGlzIGludHJvZHVjZWQgdG8gZmVlZC9nZXQgZGF0
YSB0by9mcm9tIG9uZSBvZiB0aGUgOCBzdWItY2FyZHMuRm9yIGV4YW1wbGUsaWYgYW4gYXBwbGlj
YXRpb24gd2FudHMgdG8gcGxheSBtdWljIHVzaW5nIE5vLjcgc3ViLWNhcmQsdGhlIGRyaXZlciBv
bmx5IG5lZWQgdG8gY29weSB0aGUgcGNtIGRhdGEgZnJvbSBQQ00gbGF5ZXIgdG8gTm8uNyBzbG90
IGFuZCBmaWxsIHRoZSBvdGhlciA3IHNsb3RzIHdpdGggemVyby5UaGUgZHJpdmVyIGhhcyBiZWVu
IGltcGxlbWVudGVkLiAgVGhlIHByb2JsZW0gaXMgaG93IHRvIGV4cG9zZSB0aGUgOCBzdWItY2Fy
ZHMgdG8gYXBwbGljYXRpb24gZGV2ZWxvcGVycyxzbyB0aGV5IGNhbiBzZWUgOCBpbmRlcGVuZGVu
dCBkZXZpY2Ugbm9kZXN1bmRlciAvZGV2P1RoZXkgc2hvdWxkIGJlIC9kZXYvZHNwMCwvZGV2L2Rz
cDEsLi4uL2Rldi9kc3A3IGFuZCBjYXJkMCxjYXJkMSwuLi5jYXJkNy5BbHNvIHdoZW4gYSBzdWIt
Y2FyZCBpcyBvcGVuZWQoaS5lLiAvZGV2L2RzcDcpLHRoZSBkcml2ZXIgbXVzdCBrbm93IHRoZSBz
dWItY2FyZCdzIGluZGV4ICxoZXJlIGlzIDcsc28gaXQgY2FuIGNob29zZSBhIHJlbGV2YW50IHNs
b3QgdG8gZmVlZC9nZXQgZGF0YS4KIApBbnkgc3VnZ2VzdGlvbiBpcyBhcHByZWNpYXRlZCEKIApC
ZXN0IFJlZ2FyZHMKIApDbGlmZgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwrQwsTqu7vQwtHVo6y/7MC017Gw59fUvLq1xE1T
Trj40MTSx7XEVEHSu7j2vqrPsqOhCmh0dHA6Ly9pbS5saXZlLmNuL2Vtb3RpY29ucy8/SUQ9MTgK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==

------------=_4819C3C3.BB63CA12--
