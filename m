From: dustin@seznam.cz
Subject: Re: Functioning support for Prodigy 192
Date: Tue, 24 Apr 2007 00:27:04 +0200 (CEST)
Message-ID: <9327.23908-2194-151884471-1177367224@seznam.cz>
References: <s5htzv7tfsu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="MessagePart:1372858358.0-2194-895867518-1177367224"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxh.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by alsa0.perex.cz (Postfix) with SMTP id 88DAF248B3
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 00:27:06 +0200 (CEST)
In-Reply-To: <s5htzv7tfsu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?us-ascii?Q?Takashi=20Iwai?= <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--MessagePart:1372858358.0-2194-895867518-1177367224
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="us-ascii"


>  Looks fine, too.
>  Could you post a patch with a short patch summary and sign-off to
>  apply to the upstream tree?

ice1724.c:
-------------
* always set 256fs in SPDIF master clock mode


prodigy192.c:
-----------------
* disable deemphasis filter in AK4114


Signed-off-by: Pavel Hofman <dustin@seznam.cz>
  

--MessagePart:1372858358.0-2194-895867518-1177367224
Content-Transfer-Encoding: base64
Content-Type: text/x-c;
	name=patch;
	charset="us-ascii"
Content-Disposition: attachment;
	filename=patch

ZGlmZiAtciAwNWQ0NzM4Y2MwNjUgcGNpL2ljZTE3MTIvaWNlMTcyNC5jCi0tLSBhL3BjaS9pY2Ux
NzEyL2ljZTE3MjQuYwlNb24gQXByIDIzIDE3OjE3OjQ4IDIwMDcgKzAyMDAKKysrIGIvcGNpL2lj
ZTE3MTIvaWNlMTcyNC5jCU1vbiBBcHIgMjMgMjM6NDU6MDAgMjAwNyArMDIwMApAQCAtMTY2Niw3
ICsxNjY2LDExIEBAIHN0YXRpYyBpbnQgc25kX3Z0MTcyNF9wcm9faW50ZXJuYWxfY2xvY2sKIAlz
cGluX2xvY2tfaXJxKCZpY2UtPnJlZ19sb2NrKTsKIAlvdmFsID0gaW5iKElDRU1UMTcyNChpY2Us
IFJBVEUpKTsKIAlpZiAodWNvbnRyb2wtPnZhbHVlLmVudW1lcmF0ZWQuaXRlbVswXSA9PSBzcGRp
ZikgeworCQl1bnNpZ25lZCBjaGFyIGkyc19vdmFsOwogCQlvdXRiKG92YWwgfCBWVDE3MjRfU1BE
SUZfTUFTVEVSLCBJQ0VNVDE3MjQoaWNlLCBSQVRFKSk7CisJCS8qIHNldHRpbmcgMjU2ZnMgKi8K
KwkJaTJzX292YWwgPSBpbmIoSUNFTVQxNzI0KGljZSwgSTJTX0ZPUk1BVCkpOworCQlvdXRiKCBp
MnNfb3ZhbCAmIH5WVDE3MjRfTVRfSTJTX01DTEtfMTI4WCwgSUNFTVQxNzI0KGljZSwgSTJTX0ZP
Uk1BVCkpOwogCX0gZWxzZSB7CiAJCXJhdGUgPSByYXRlc1t1Y29udHJvbC0+dmFsdWUuaW50ZWdl
ci52YWx1ZVswXSAlIDE1XTsKIAkJaWYgKHJhdGUgPD0gZ2V0X21heF9yYXRlKGljZSkpIHsKZGlm
ZiAtciAwNWQ0NzM4Y2MwNjUgcGNpL2ljZTE3MTIvcHJvZGlneTE5Mi5jCi0tLSBhL3BjaS9pY2Ux
NzEyL3Byb2RpZ3kxOTIuYwlNb24gQXByIDIzIDE3OjE3OjQ4IDIwMDcgKzAyMDAKKysrIGIvcGNp
L2ljZTE3MTIvcHJvZGlneTE5Mi5jCVR1ZSBBcHIgMjQgMDA6MjA6MzggMjAwNyArMDIwMApAQCAt
MjYsNiArMjYsMTEgQEAKICAqIAkJCUNDTEsgKHBpbiAzNCkgLS0gR1BJTzkgcGluIDc2CiAgKiAJ
CQlDU04gIChwaW4gMzUpIC0tIEdQSU84IHBpbiA3NQogICogICAJCS0gb3V0cHV0IGRhdGEgTW9k
ZSA3ICgyNGJpdCwgSTJTLCBzbGF2ZSkKKyAqICAgCQktIGJvdGggTUNLTzEgYW5kIE1DS08yIG9m
IGFrNDExNCBhcmUgZmVkIHRvIEZQR0EsIHdoaWNoIAorICogICAJCW91dHB1dHMgbWFzdGVyIGNs
b2NrIHRvIFNQTUNMS0lOIG9mIGljZTE3MjQuIEV4cGVyaW1lbnRhbGx5IEkgZm91bmQgb3V0Cisg
KiAgIAkJdGhhdCBvbmx5IGEgY29tYmluYXRpb24gb2YgT0NLUzA9MSwgT0NLUzE9MSAoMTI4ZnMs
IDY0ZnMgb3V0cHV0KSBhbmQgCisgKiAgIAkJaWNlMTcyNCAtIFZUMTcyNF9NVF9JMlNfTUNMS18x
MjhYPTAgKDI1NmZzIGlucHV0KSB5aWVsZHMgY29ycmVjdCAKKyAqICAgCQlzYW1wbGluZyByYXRl
LiBUaGF0IG1lYW5zIHRoZSB0aGUgRlBHQSBkb3VibGVzIHRoZSBNQ0swMSByYXRlLiAKICAqCiAg
KglDb3B5cmlnaHQgKGMpIDIwMDMgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgogICogICAg
ICBDb3B5cmlnaHQgKGMpIDIwMDMgRGltaXRyb21hbm9sYWtpcyBBcG9zdG9sb3MgPGFwb3N0b2xA
Y3MudXRvcm9udG8uY2E+CkBAIC03MTQsNyArNzE5LDggQEAgc3RhdGljIGludCBwcm9kaWd5MTky
X2FrNDExNF9pbml0KHN0cnVjdAogewogCXN0YXRpYyBjb25zdCB1bnNpZ25lZCBjaGFyIGFrNDEx
NF9pbml0X3ZhbHNbXSA9IHsKIAkJQUs0MTE0X1JTVCB8IEFLNDExNF9QV04gfCBBSzQxMTRfT0NL
UzAgfCBBSzQxMTRfT0NLUzEsCi0JCUFLNDExNF9ESUZfSTI0STJTLCAvKiBpY2UxNzI0IGV4cGVj
dHMgSTJTIGFuZCBwcm92aWRlcyBjbG9jayAqLworCQlBSzQxMTRfRElGX0kyNEkyUyB8IEFLNDEx
NF9ERU0wICwgLyogaWNlMTcyNCBleHBlY3RzIEkyUyBhbmQgcHJvdmlkZXMgY2xvY2ssIAorCQkJ
CQkJICAgICBERU0wIGRpc2FibGVzIHRoZSBkZWVtcGhhc2lzIGZpbHRlciAqLwogCQlBSzQxMTRf
VFgxRSwKIAkJQUs0MTE0X0VGSF8xMDI0IHwgQUs0MTE0X0RJVCwgLyogZGVmYXVsdCBpbnB1dCBS
WDAgKi8KIAkJMCwK

--MessagePart:1372858358.0-2194-895867518-1177367224
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MessagePart:1372858358.0-2194-895867518-1177367224--
