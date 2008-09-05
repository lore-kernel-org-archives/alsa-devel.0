From: "Nie Jun" <niej0001@gmail.com>
Subject: Re: noise and consume pcm faster
Date: Fri, 5 Sep 2008 12:02:33 +0800
Message-ID: <7c34ac520809042102o45feca83lf6eb3b4aadbc95d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_48C0AF5D.A02EF454"
Return-path: <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------------=_48C0AF5D.A02EF454
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Spam detection software, running on the system "mail1.perex.cz", has
identified this incoming email as possible spam.  The original message
has been attached to this so you can view it (if it isn't spam) or label
similar future email.  If you have any questions, see
internet@perex.cz for details.

Content preview:  Thank Takashi for your advice. I check /proc/asound/car=
d0/pcm0p/sub0/*
   files, buffer_sizes of both ALSA and OSS have integer period_size. May=
be
  other setting causes this issue, but I can not find it. Would you guys =
please
   help have a look at these file? [...]=20

Content analysis details:   (10.0 points, 5.0 required)

 pts rule name              description
---- ---------------------- ---------------------------------------------=
-----
  10 PRX_GB2312_CHARSET     GB2312 charset in Content-Type or Subject



------------=_48C0AF5D.A02EF454
Content-Type: message/rfc822; x-spam-type=original
Content-Description: original message before SpamAssassin
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from alsa0.perex.cz (localhost [127.0.0.1])
	by alsa0.perex.cz (Postfix) with ESMTP id CA5B02458F;
	Fri,  5 Sep 2008 06:02:36 +0200 (CEST)
X-Original-To: alsa-devel@alsa-project.org
Delivered-To: alsa-devel@alsa-project.org
Received: by alsa0.perex.cz (Postfix, from userid 1000)
	id 0C95A2458F; Fri,  5 Sep 2008 06:02:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on mail1.perex.cz
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=5.0 tests=HTML_MESSAGE,SPF_PASS
	autolearn=disabled version=3.2.4
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 66C2924589
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 06:02:34 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so109004eyc.56
	for <alsa-devel@alsa-project.org>; Thu, 04 Sep 2008 21:02:33 -0700 (PDT)
Received: by 10.210.54.19 with SMTP id c19mr13004531eba.157.1220587353591;
	Thu, 04 Sep 2008 21:02:33 -0700 (PDT)
Received: by 10.210.121.13 with HTTP; Thu, 4 Sep 2008 21:02:33 -0700 (PDT)
Message-ID: <7c34ac520809042102o45feca83lf6eb3b4aadbc95d3@mail.gmail.com>
Date: Fri, 5 Sep 2008 12:02:33 +0800
From: "Nie Jun" <niej0001@gmail.com>
To: "Takashi Iwai" <tiwai@suse.de>, alsa-devel@alsa-project.org
In-Reply-To: <7c34ac520809042100p2171a726y763d6c3d385b9544@mail.gmail.com>
MIME-Version: 1.0
References: <7c34ac520809020200l290f78d3l5e7146bfb567e739@mail.gmail.com>
	<7c34ac520809020240i1234a011v9e0ae3a5f2c8a860@mail.gmail.com>
	<s5h4p4xnz6f.wl%tiwai@suse.de>
	<7c34ac520809042100p2171a726y763d6c3d385b9544@mail.gmail.com>
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.9
Subject: Re: [alsa-devel] noise and consume pcm faster
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

VGhhbmsgVGFrYXNoaSBmb3IgeW91ciBhZHZpY2UuCgpJIGNoZWNrIC9wcm9jL2Fzb3VuZC9jYXJk
MC9wY20wcC9zdWIwLyogZmlsZXMsIGJ1ZmZlcl9zaXplcyBvZiBib3RoIEFMU0EgYW5kCk9TUyBo
YXZlIGludGVnZXIgcGVyaW9kX3NpemUuIE1heWJlIG90aGVyIHNldHRpbmcgY2F1c2VzIHRoaXMg
aXNzdWUsIGJ1dCBJCmNhbiBub3QgZmluZCBpdC4gV291bGQgeW91IGd1eXMgcGxlYXNlIGhlbHAg
aGF2ZSBhIGxvb2sgYXQgdGhlc2UgZmlsZT8KClRoYW5rIHlvdSB2ZXJ5IG11Y2ghCgo9PT09PT09
PT09PSBBTFNBIGh3X3BhcmFtcyA9PT09PT09PT09PQphY2Nlc3M6IFJXX0lOVEVSTEVBVkVECmZv
cm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDQ4MDAwICg0ODAw
MC8xKQpwZXJpb2Rfc2l6ZTogNDgwCmJ1ZmZlcl9zaXplOiA5NjAwCgotLS0tLS0tLS0tLS0tLS0t
LSBPU1MgaHdfcGFyYW1zIC0tLS0tLS0tLS0tLS0tLS0tLS0tLQphY2Nlc3M6IFJXX0lOVEVSTEVB
VkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDQ4MDAw
ICg0ODAwMC8xKQpwZXJpb2Rfc2l6ZTogMjU2CmJ1ZmZlcl9zaXplOiA1MTIwCk9TUyBmb3JtYXQ6
IFMxNl9MRQpPU1MgY2hhbm5lbHM6IDIKT1NTIHJhdGU6IDQ4MDAwCk9TUyBwZXJpb2QgYnl0ZXM6
IDEwMjQKT1NTIHBlcmlvZHM6IDIwCk9TUyBwZXJpb2QgZnJhbWVzOiAyNTYKCj09PT09PT09PT09
IEFMU0Egc3dfcGFyYW1zID09PT09PT09PT09CnRzdGFtcF9tb2RlOiBOT05FCnBlcmlvZF9zdGVw
OiAxCmF2YWlsX21pbjogNDgwCnN0YXJ0X3RocmVzaG9sZDogOTYwMApzdG9wX3RocmVzaG9sZDog
OTYwMApzaWxlbmNlX3RocmVzaG9sZDogMApzaWxlbmNlX3NpemU6IDAKYm91bmRhcnk6IDEyNTgy
OTEyMDAKCi0tLS0tLS0tLS0tLS0tLS0tIE9TUyBzd19wYXJhbXMgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCnRzdGFtcF9tb2RlOiBOT05FCnBlcmlvZF9zdGVwOiAxCmF2YWlsX21pbjogMQpzdGFydF90
aHJlc2hvbGQ6IDEKc3RvcF90aHJlc2hvbGQ6IDUxMjAKc2lsZW5jZV90aHJlc2hvbGQ6IDI3Mgpz
aWxlbmNlX3NpemU6IDI3Mgpib3VuZGFyeTogMTM0MjE3NzI4MAoKPT09PT09PT09PT0gQUxTQSBz
dGF0dXMgPT09PT09PT09PQpzdGF0ZTogUlVOTklORwp0cmlnZ2VyX3RpbWU6IDk0Njc0NDIxOC45
MTQ5NDc1MTAKdHN0YW1wICAgICAgOiA5NDY3NDQzMDQuNDQwNzA0MzQ2CmRlbGF5ICAgICAgIDog
ODkyNAphdmFpbCAgICAgICA6IDY3NgphdmFpbF9tYXggICA6IDE5NDAKLS0tLS0KaHdfcHRyICAg
ICAgOiA0MTA1MTgwCmFwcGxfcHRyICAgIDogNDExNDEwNAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSBPU1Mgc3RhdHVzIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnN0YXRlOiBSVU5OSU5HCnRy
aWdnZXJfdGltZTogOTQ2NzQ0MzgyLjY2MTM3Njk1Mwp0c3RhbXAgICAgICA6IDk0Njc0NDQxMC44
Njg5ODgwMzcKZGVsYXkgICAgICAgOiA0OTA4CmF2YWlsICAgICAgIDogMjEyCmF2YWlsX21heCAg
IDogNDg3NgotLS0tLQpod19wdHIgICAgICA6IDEzNTM5NTIKYXBwbF9wdHIgICAgOiAxMzU4ODYw
Cgo9PT09PT09PT09PT09IEFMU0EgT1NTIGhhcyBzYW1lIGluZm8gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KY2FyZDogMApkZXZpY2U6IDAKc3ViZGV2aWNlOiAwCnN0cmVhbTogUExBWUJB
Q0sKaWQ6IEkyUyBIaUZpIEkyUyBIaUZpLVBDTS0wCm5hbWU6CnN1Ym5hbWU6IHN1YmRldmljZSAj
MApjbGFzczogMApzdWJjbGFzczogMApzdWJkZXZpY2VzX2NvdW50OiAxCnN1YmRldmljZXNfYXZh
aWw6IDAKCgoKMjAwOC85LzMgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPjotIM/Uyr7S/dPD
zsTX1iAtCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=

------------=_48C0AF5D.A02EF454--
