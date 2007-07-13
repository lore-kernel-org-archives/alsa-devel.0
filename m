From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: [PATCH] Add quirks for HP dx2200 and dx2250
Date: Fri, 13 Jul 2007 18:33:26 -0300
Message-ID: <5f52f6d70707131433q2d8cfe91r897977a05241a410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_32865_26264983.1184362406886"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id C00F5103854
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 23:33:27 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so37284nfd
	for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2007 14:33:27 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, lcapitulino@mandriva.com
List-Id: alsa-devel@alsa-project.org

------=_Part_32865_26264983.1184362406886
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds quirks for HP dx2200 and dx2250. They use the standard
configuration for 3-stack ALC862.

------=_Part_32865_26264983.1184362406886
Content-Type: text/x-diff;
	name=0013-ALSA-hda-codec-Add-quirks-for-HP-dx2200-dx2250.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f436rfx2
Content-Disposition: attachment; filename="0013-ALSA-hda-codec-Add-quirks-for-HP-dx2200-dx2250.patch"

RnJvbSA3ZjgxZTNlNzI2NWQ0MWVkOTU3MWE2N2RhM2NhNjBlZjMzYjQxNGExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDbGF1ZGlvIE1hdHN1b2thIDxjbWF0c3Vva2FAZ21haWwuY29t
PgpEYXRlOiBGcmksIDEzIEp1bCAyMDA3IDE4OjI3OjMzIC0wMzAwClN1YmplY3Q6IFtQQVRDSF0g
W0FMU0FdIGhkYS1jb2RlYyAtIEFkZCBxdWlya3MgZm9yIEhQIGR4MjIwMC9keDIyNTAKCkhQIGR4
MjIwMCBhbmQgZHgyMjUwIHVzZSBNaWNyby1TdGFyIEludGVybmF0aW9uYWwgKE1TSSkgbW90aGVy
Ym9hcmRzCihtb2RlbHMgTVMtNzI1NCBhbmQgTVMtNzI5NyByZXNwZWN0aXZlbHkpIHdpdGggYW4g
QUxDODYyIGNvZGVjIGluCnRocmVlc3RhY2sgY29uZmlndXJhdGlvbi4gQWRkaW5nIHRoaXMgcXVp
cmsgYWxsb3dzIGNvcnJlY3QgNS4xIHNvdW5kCm91dHB1dCBpbiB0aGVzZSBzeXN0ZW1zLgoKU2ln
bmVkLW9mZi1ieTogQ2xhdWRpbyBNYXRzdW9rYSA8Y21hdHN1b2thQGdtYWlsLmNvbT4KLS0tCiBz
b3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXgg
MzJlN2FjNi4uMTViN2Y5YiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVr
LmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTg5NDEsNiArODk0MSw4
IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGM4NjFfY2ZnX3RibFtdID0gewogCVNO
RF9QQ0lfUVVJUksoMHgxNTg0LCAweDJiMDEsICJVbml3aWxsIFg0MEFJeCIsIEFMQzg2MV9VTklX
SUxMX00zMSksCiAJU05EX1BDSV9RVUlSSygweDE4NDksIDB4MDY2MCwgIkFzcm9jayA5MzlTTEkz
MiIsIEFMQzY2MF8zU1QpLAogCVNORF9QQ0lfUVVJUksoMHg4MDg2LCAweGQ2MDAsICJJbnRlbCIs
IEFMQzg2MV8zU1QpLAorCVNORF9QQ0lfUVVJUksoMHgxNDYyLCAweDcyNTQsICJIUCBkeDIyMDAg
KE1TSSBNUy03MjU0KSIsIEFMQzg2MV8zU1QpLAorCVNORF9QQ0lfUVVJUksoMHgxNDYyLCAweDcy
OTcsICJIUCBkeDIyNTAgKE1TSSBNUy03Mjk3KSIsIEFMQzg2MV8zU1QpLAogCXt9CiB9OwogCi0t
IAoxLjUuMi4zCgo=
------=_Part_32865_26264983.1184362406886
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_32865_26264983.1184362406886--
