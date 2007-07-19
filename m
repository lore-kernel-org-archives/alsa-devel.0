From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: [PATCH] Add quirk for Asus P5LD2
Date: Thu, 19 Jul 2007 16:48:40 -0300
Message-ID: <5f52f6d70707191248q7ca0c19ewb0c9938187b3f8a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_85796_2751044.1184874520110"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A62F24366
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 21:48:42 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so774904mue
	for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2007 12:48:40 -0700 (PDT)
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

------=_Part_85796_2751044.1184874520110
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Another simple patch that adds a system to the ALC882 quirk table.
Tested with a week-old HG version, buildsystem of the current
alsa-driver seems to be broken.

------=_Part_85796_2751044.1184874520110
Content-Type: text/x-diff;
	name=0014-ALSA-hda-codec-Add-quirk-for-Asus-P5LD2.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4bnlnmb
Content-Disposition: attachment; filename="0014-ALSA-hda-codec-Add-quirk-for-Asus-P5LD2.patch"

RnJvbSA3NTYzODlkYjY4NDM2ZmI4OTc5MDdiY2Q3MzYyMTU2ZmI5Yjg5OWUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDbGF1ZGlvIE1hdHN1b2thIDxjbWF0c3Vva2FAZ21haWwuY29t
PgpEYXRlOiBUaHUsIDE5IEp1bCAyMDA3IDE2OjM0OjM0IC0wMzAwClN1YmplY3Q6IFtQQVRDSF0g
W0FMU0FdIGhkYS1jb2RlYyAtIEFkZCBxdWlyayBmb3IgQXN1cyBQNUxEMgoKV2l0aG91dCB0aGUg
cHJvcGVyIG1vZGVsIHNldHRpbmcsIHRoZSBBc3VzIFA1TEQyIHJlYXIgb3V0cHV0cyByZW1haW4K
Y29tcGxldGVseSBzaWxlbnQgdW5saWtlIG90aGVyIHN5c3RlbXMgd2hlcmUgdGhlIGZyb250IHNw
ZWFrZXJzIHVzdWFsbHkKd29yay4gVGhpcyBwYXRjaCBhZGRzIHRoZSBQNUxEMiB0byB0aGUgcXVp
cmsgdGFibGUuCgpTaWduZWQtb2ZmLWJ5OiBDbGF1ZGlvIE1hdHN1b2thIDxjbWF0c3Vva2FAZ21h
aWwuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIHwgICAgMSArCiAxIGZp
bGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jCmluZGV4IDE1YjdmOWIuLmRlNzE1ODYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC01
MzA3LDYgKzUzMDcsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjODgyX2NmZ190
YmxbXSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTQ2MiwgMHgyOGZiLCAiVGFyZ2EgVDgiLCBBTEM4
ODJfVEFSR0EpLCAvKiBNU0ktMTA0OSBUOCAgKi8KIAlTTkRfUENJX1FVSVJLKDB4MTYxZiwgMHgy
MDU0LCAiQXJpbWEgVzgyMCIsIEFMQzg4Ml9BUklNQSksCiAJU05EX1BDSV9RVUlSSygweDEwNDMs
IDB4MDYwZCwgIkFzdXMgQTdKIiwgQUxDODgyX0FTVVNfQTdKKSwKKwlTTkRfUENJX1FVSVJLKDB4
MTA0MywgMHg4MTdmLCAiQXN1cyBQNUxEMiIsIEFMQzg4Ml82U1RfRElHKSwKIAlTTkRfUENJX1FV
SVJLKDB4MTA0MywgMHg4MWQ4LCAiQXN1cyBQNVdEIiwgQUxDODgyXzZTVF9ESUcpLAogCVNORF9Q
Q0lfUVVJUksoMHgxMDQzLCAweDE5NzEsICJBc3VzIFcySkMiLCBBTEM4ODJfVzJKQyksCiAJe30K
LS0gCjEuNS4yLjMKCg==
------=_Part_85796_2751044.1184874520110
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_85796_2751044.1184874520110--
