From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: [PATCH] hda-codec - Add VIA HDA to si3054
Date: Tue, 10 Jul 2007 13:19:43 -0300
Message-ID: <5f52f6d70707100919q48e49a08sed2076ea33bcee29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_157005_31508233.1184084383705"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CEEC24336
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 18:19:44 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1167335mue
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 09:19:44 -0700 (PDT)
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

------=_Part_157005_31508233.1184084383705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to proper recognition of the si3054 modem
in the Clevo m540 laptop.

Thanks,
Claudio

------=_Part_157005_31508233.1184084383705
Content-Type: text/x-patch; name=0008-hda-codec-Add-VIA-HDA-to-si3054.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f3yl1nou
Content-Disposition: attachment; filename="0008-hda-codec-Add-VIA-HDA-to-si3054.patch"

RnJvbSA1M2JiOGIyOWE0YjE3OGJkOTE1ZjFiN2Y4ZDQyY2MwMGRhYjNkMGE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDbGF1ZGlvIE1hdHN1b2thIDxjbWF0c3Vva2FAZ21haWwuY29t
PgpEYXRlOiBUdWUsIDEwIEp1bCAyMDA3IDExOjU2OjE0IC0wMzAwClN1YmplY3Q6IFtQQVRDSF0g
aGRhLWNvZGVjIC0gQWRkIFZJQSBIREEgdG8gc2kzMDU0CgpBZGQgVklBIEhEQSBpZGVudGlmaWNh
dGlvbiB0byB1c2UgdGhlIEhEQS1iYXNlZCBNb3Rvcm9sYSBtb2RlbSBvZgp0aGUgQ2xldm8gbTU0
MCBsYXB0b3AuCgpTaWduZWQtb2ZmLWJ5OiBDbGF1ZGlvIE1hdHN1b2thIDxjbWF0c3Vva2FAZ21h
aWwuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfc2kzMDU0LmMgfCAgICAyICsrCiAxIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpMzA1NC5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9zaTMw
NTQuYwppbmRleCA0M2Y1MzdlLi41ZGQ5ZjYxIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3Bh
dGNoX3NpMzA1NC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2kzMDU0LmMKQEAgLTMwNCw2
ICszMDQsOCBAQCBzdHJ1Y3QgaGRhX2NvZGVjX3ByZXNldCBzbmRfaGRhX3ByZXNldF9zaTMwNTRb
XSA9IHsKICAJeyAuaWQgPSAweDEwNTczMDU1LCAubmFtZSA9ICJTaTMwNTQiLCAucGF0Y2ggPSBw
YXRjaF9zaTMwNTQgfSwKICAJeyAuaWQgPSAweDEwNTczMDU3LCAubmFtZSA9ICJTaTMwNTQiLCAu
cGF0Y2ggPSBwYXRjaF9zaTMwNTQgfSwKICAJeyAuaWQgPSAweDEwNTczMTU1LCAubmFtZSA9ICJT
aTMwNTQiLCAucGF0Y2ggPSBwYXRjaF9zaTMwNTQgfSwKKwkvKiBWSUEgSERBIG9uIENsZXZvIG01
NDAgKi8KKwl7IC5pZCA9IDB4MTEwNjMyODgsIC5uYW1lID0gIlNpMzA1NCIsIC5wYXRjaCA9IHBh
dGNoX3NpMzA1NCB9LAogCS8qIEFzdXMgQThKIE1vZGVtIChTTTU2KSAqLwogCXsgLmlkID0gMHgx
NTQzMzE1NSwgLm5hbWUgPSAiU2kzMDU0IiwgLnBhdGNoID0gcGF0Y2hfc2kzMDU0IH0sCiAJe30K
LS0gCjEuNS4yLjMKCg==
------=_Part_157005_31508233.1184084383705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_157005_31508233.1184084383705--
