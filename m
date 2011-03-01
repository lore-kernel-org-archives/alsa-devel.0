From: Chih-Wei Huang <cwhuang@linux.org.tw>
Subject: Fix for recording issue of ASUS N82JV
Date: Tue, 01 Mar 2011 15:35:07 +0800
Message-ID: <4D6CA1AB.30403@linux.org.tw>
References: <4D672B85.9020603@linux.org.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020804080107020309070207"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linux.org.tw (n201.enc.hlc.edu.tw [210.240.39.201])
	by alsa0.perex.cz (Postfix) with SMTP id A48B42471C
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 08:35:14 +0100 (CET)
In-Reply-To: <4D672B85.9020603@linux.org.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020804080107020309070207
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
This small patch fixes the unable to record issue
on ASUS N82JV. Thanks.

Tested OK on android-x86 2.2 & 2.3 with kernel 2.6.38-rc4.

Regards,


--------------020804080107020309070207
Content-Type: text/plain;
 name="0001-ALSA-hda-Fix-unable-to-record-issue-on-ASUS-N82JV.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Fix-unable-to-record-issue-on-ASUS-N82JV.patch"

RnJvbSAxYTYxYjgzMGI4OThiNGJkMjgxZjkyZWFiMjVkNmZjODY5YmU3MDFkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaGloLVdlaSBIdWFuZyA8Y3dodWFuZ0BsaW51eC5v
cmcudHc+CkRhdGU6IEZyaSwgMjUgRmViIDIwMTEgMTE6MTQ6MzEgKzA4MDAKU3ViamVjdDog
W1BBVENIXSBBTFNBOiBoZGEgLSBGaXggdW5hYmxlIHRvIHJlY29yZCBpc3N1ZSBvbiBBU1VT
IE44MkpWCgpUaGUgY29kZWMgb2YgTjgySlYgaXMgQUxDMjY5VkIuCgpTaWduZWQtb2ZmLWJ5
OiBDaGloLVdlaSBIdWFuZyA8Y3dodWFuZ0BsaW51eC5vcmcudHc+Ci0tLQogc291bmQvcGNp
L2hkYS9wYXRjaF9yZWFsdGVrLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4
IDMzMjhhMjUuLjBiMDgwMGYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC0xNTAxNSw3
ICsxNTAxNSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGMyNjlfY2ZnX3Ri
bFtdID0gewogCVNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDExZTMsICJBU1VTIFUzM0pjIiwg
QUxDMjY5VkJfQU1JQyksCiAJU05EX1BDSV9RVUlSSygweDEwNDMsIDB4MTI3MywgIkFTVVMg
VUw4MEp0IiwgQUxDMjY5VkJfQU1JQyksCiAJU05EX1BDSV9RVUlSSygweDEwNDMsIDB4MTI4
MywgIkFTVVMgVTUzSmMiLCBBTEMyNjlfQU1JQyksCi0JU05EX1BDSV9RVUlSSygweDEwNDMs
IDB4MTJiMywgIkFTVVMgTjgySnYiLCBBTEMyNjlfQU1JQyksCisJU05EX1BDSV9RVUlSSygw
eDEwNDMsIDB4MTJiMywgIkFTVVMgTjgySlYiLCBBTEMyNjlWQl9BTUlDKSwKIAlTTkRfUENJ
X1FVSVJLKDB4MTA0MywgMHgxMmQzLCAiQVNVUyBONjFKdiIsIEFMQzI2OV9BTUlDKSwKIAlT
TkRfUENJX1FVSVJLKDB4MTA0MywgMHgxM2EzLCAiQVNVUyBVTDMwVnQiLCBBTEMyNjlfQU1J
QyksCiAJU05EX1BDSV9RVUlSSygweDEwNDMsIDB4MTM3MywgIkFTVVMgRzczSlgiLCBBTEMy
NjlfQU1JQyksCi0tIAoxLjcuMy4yCgo=
--------------020804080107020309070207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020804080107020309070207--
