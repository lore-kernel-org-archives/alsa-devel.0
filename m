From: =?ISO-8859-1?Q?Juan_Jes=FAs_Garc=EDa_de_Soria_Lucena?=
	<skandalfo@gmail.com>
Subject: [PATCH] Quirk for Acer Aspire 6530G
Date: Fri, 20 Feb 2009 20:45:35 +0100
Message-ID: <b0bb99640902201145q758f0a9bvea5e8327894e2dfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd47b26818c9604635ee5c1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 795F0103931
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 20:45:36 +0100 (CET)
Received: by gxk2 with SMTP id 2so3007209gxk.8
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 11:45:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--000e0cd47b26818c9604635ee5c1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi everyone.

The Acer Aspire 6530G needs the 4930G "model" for the front mic to
work properly. Please apply the attached patch in order to properly
support it out of the box.

Best regards,

   Juan Jesus Garcia de Soria

-- 
Dream small if success is enough for you; dream big if you need to
change the world.

--000e0cd47b26818c9604635ee5c1
Content-Type: text/plain; charset=US-ASCII; name="alsa-add-acer6530g-quirk.diff"
Content-Disposition: attachment; filename="alsa-add-acer6530g-quirk.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frf9t84t0

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggZWQ4ZmNiZC4uZGYwZmQwMiAxMDA2NDQKLS0tIGEvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKQEAgLTg0NjksNiArODQ2OSw4IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBh
bGM4ODNfY2ZnX3RibFtdID0gewogCQlBTEM4ODhfQUNFUl9BU1BJUkVfNDkzMEcpLAogCVNORF9Q
Q0lfUVVJUksoMHgxMDI1LCAweDAxNWUsICJBY2VyIEFzcGlyZSA2OTMwRyIsCiAJCUFMQzg4OF9B
Q0VSX0FTUElSRV80OTMwRyksCisJU05EX1BDSV9RVUlSSygweDEwMjUsIDB4MDE2NiwgIkFjZXIg
QXNwaXJlIDY1MzBHIiwKKwkJQUxDODg4X0FDRVJfQVNQSVJFXzQ5MzBHKSwKIAlTTkRfUENJX1FV
SVJLKDB4MTAyNSwgMCwgIkFjZXIgbGFwdG9wIiwgQUxDODgzX0FDRVIpLCAvKiBkZWZhdWx0IEFj
ZXIgKi8KIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwMjBkLCAiRGVsbCBJbnNwaXJvbiA1MzAi
LCBBTEM4ODhfNlNUX0RFTEwpLAogCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDJhM2QsICJIUCBQ
YXZpbGxpb24iLCBBTEM4ODNfNlNUX0RJRyksCg==
--000e0cd47b26818c9604635ee5c1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--000e0cd47b26818c9604635ee5c1--
