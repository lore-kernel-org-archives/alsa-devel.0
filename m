From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: ASoC: Fixed reg cache bugs in wm8974 codec.
Date: Wed, 8 Apr 2009 14:23:45 +0200
Message-ID: <eedb5540904080523p2e60bd1dje2e940e2e5b89399@mail.gmail.com>
References: <eedb5540904080325h2209521duefc0ed627c60550c@mail.gmail.com>
	<20090408112533.GJ20122@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174bdea0f01de004670a331a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 15625103849
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 14:23:46 +0200 (CEST)
Received: by ewy10 with SMTP id 10so118482ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2009 05:23:45 -0700 (PDT)
In-Reply-To: <20090408112533.GJ20122@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0015174bdea0f01de004670a331a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Here is an attachment with the patch to avoid problems with my MUA.
Sorry.

2009/4/8 Mark Brown <broonie@sirena.org.uk>

> On Wed, Apr 08, 2009 at 12:25:49PM +0200, javier Martin wrote:
> > ASoC: Fixed reg cache bugs in wm8974 codec.
>
> Applied, thanks.
>

--0015174bdea0f01de004670a331a
Content-Type: application/octet-stream; name="wm8974.patch"
Content-Disposition: attachment; filename="wm8974.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ft9zrcyo0

ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3Mvd204OTc0LmMgYi9zb3VuZC9zb2MvY29kZWNz
L3dtODk3NC5jCmluZGV4IDdiYWY2ZmYuLjE1ODFhMDAgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9j
b2RlY3Mvd204OTc0LmMKKysrIGIvc291bmQvc29jL2NvZGVjcy93bTg5NzQuYwpAQCAtMzczLDgg
KzM3Myw4IEBAIHN0YXRpYyBpbnQgd204OTc0X3NldF9kYWlfcGxsKHN0cnVjdCBzbmRfc29jX2Rh
aSAqY29kZWNfZGFpLAogCQlpZiAoZnJlcV9pbiA9PSBwbGxbaV0uaW5faHogJiYgZnJlcV9vdXQg
PT0gcGxsW2ldLm91dF9oeikgewogCQkJd204OTc0X3dyaXRlKGNvZGVjLCBXTTg5NzRfUExMTiwg
KHBsbFtpXS5wcmUgPDwgNCkgfCBwbGxbaV0ubik7CiAJCQl3bTg5NzRfd3JpdGUoY29kZWMsIFdN
ODk3NF9QTExLMSwgcGxsW2ldLmsgPj4gMTgpOwotCQkJd204OTc0X3dyaXRlKGNvZGVjLCBXTTg5
NzRfUExMSzEsIChwbGxbaV0uayA+PiA5KSAmJiAweDFmZik7Ci0JCQl3bTg5NzRfd3JpdGUoY29k
ZWMsIFdNODk3NF9QTExLMSwgcGxsW2ldLmsgJiYgMHgxZmYpOworCQkJd204OTc0X3dyaXRlKGNv
ZGVjLCBXTTg5NzRfUExMSzIsIChwbGxbaV0uayA+PiA5KSAmIDB4MWZmKTsKKwkJCXdtODk3NF93
cml0ZShjb2RlYywgV004OTc0X1BMTEszLCBwbGxbaV0uayAmIDB4MWZmKTsKIAkJCXJlZyA9IHdt
ODk3NF9yZWFkX3JlZ19jYWNoZShjb2RlYywgV004OTc0X1BPV0VSMSk7CiAJCQl3bTg5NzRfd3Jp
dGUoY29kZWMsIFdNODk3NF9QT1dFUjEsIHJlZyB8IDB4MDIwKTsKIAkJCXJldHVybiAwOwpAQCAt
Mzk0LDIzICszOTQsMjMgQEAgc3RhdGljIGludCB3bTg5NzRfc2V0X2RhaV9jbGtkaXYoc3RydWN0
IHNuZF9zb2NfZGFpICpjb2RlY19kYWksCiAKIAlzd2l0Y2ggKGRpdl9pZCkgewogCWNhc2UgV004
OTc0X09QQ0xLRElWOgotCQlyZWcgPSB3bTg5NzRfcmVhZF9yZWdfY2FjaGUoY29kZWMsIFdNODk3
NF9HUElPICYgMHgxY2YpOworCQlyZWcgPSB3bTg5NzRfcmVhZF9yZWdfY2FjaGUoY29kZWMsIFdN
ODk3NF9HUElPKSAmIDB4MWNmOyAKIAkJd204OTc0X3dyaXRlKGNvZGVjLCBXTTg5NzRfR1BJTywg
cmVnIHwgZGl2KTsKIAkJYnJlYWs7CiAJY2FzZSBXTTg5NzRfTUNMS0RJVjoKLQkJcmVnID0gd204
OTc0X3JlYWRfcmVnX2NhY2hlKGNvZGVjLCBXTTg5NzRfQ0xPQ0sgJiAweDFmKTsKKwkJcmVnID0g
d204OTc0X3JlYWRfcmVnX2NhY2hlKGNvZGVjLCBXTTg5NzRfQ0xPQ0spICYgMHgxMWY7CiAJCXdt
ODk3NF93cml0ZShjb2RlYywgV004OTc0X0NMT0NLLCByZWcgfCBkaXYpOwogCQlicmVhazsKIAlj
YXNlIFdNODk3NF9BRENDTEs6Ci0JCXJlZyA9IHdtODk3NF9yZWFkX3JlZ19jYWNoZShjb2RlYywg
V004OTc0X0FEQyAmIDB4MWY3KTsKKwkJcmVnID0gd204OTc0X3JlYWRfcmVnX2NhY2hlKGNvZGVj
LCBXTTg5NzRfQURDKSAmIDB4MWY3OwogCQl3bTg5NzRfd3JpdGUoY29kZWMsIFdNODk3NF9BREMs
IHJlZyB8IGRpdik7CiAJCWJyZWFrOwogCWNhc2UgV004OTc0X0RBQ0NMSzoKLQkJcmVnID0gd204
OTc0X3JlYWRfcmVnX2NhY2hlKGNvZGVjLCBXTTg5NzRfREFDICYgMHgxZjcpOworCQlyZWcgPSB3
bTg5NzRfcmVhZF9yZWdfY2FjaGUoY29kZWMsIFdNODk3NF9EQUMpICYgMHgxZjc7CiAJCXdtODk3
NF93cml0ZShjb2RlYywgV004OTc0X0RBQywgcmVnIHwgZGl2KTsKIAkJYnJlYWs7CiAJY2FzZSBX
TTg5NzRfQkNMS0RJVjoKLQkJcmVnID0gd204OTc0X3JlYWRfcmVnX2NhY2hlKGNvZGVjLCBXTTg5
NzRfQ0xPQ0sgJiAweDFlMyk7CisJCXJlZyA9IHdtODk3NF9yZWFkX3JlZ19jYWNoZShjb2RlYywg
V004OTc0X0NMT0NLKSAmIDB4MWUzOwogCQl3bTg5NzRfd3JpdGUoY29kZWMsIFdNODk3NF9DTE9D
SywgcmVnIHwgZGl2KTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoK
--0015174bdea0f01de004670a331a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015174bdea0f01de004670a331a--
