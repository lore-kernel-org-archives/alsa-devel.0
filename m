From: Harry Butterworth <heb1001@gmail.com>
Subject: Re: Creative X-Fi Titanium HD ctxfi bugs 5378 5218 4868
Date: Thu, 16 Jun 2011 08:32:15 +0800
Message-ID: <BANLkTing7dN-SO_usnWe=yez1rpsri2A7w@mail.gmail.com>
References: <BANLkTinvze9uO+ir_QXdCw4-g+E5QCoMXQ@mail.gmail.com>
	<s5haady3onz.wl%tiwai@suse.de>
	<BANLkTinovea9fE1Hxey83W+WAiYGBv600Q@mail.gmail.com>
	<s5hboy3f12c.wl%tiwai@suse.de> <s5hei2xdlc1.wl%tiwai@suse.de>
	<BANLkTinesvJZmL3DSe--NXpsRONtaBxTVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec548a921a0b7da04a5c96697
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EE1CC24B55
	for <Alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 02:32:17 +0200 (CEST)
Received: by vxi40 with SMTP id 40so889700vxi.38
	for <Alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 17:32:16 -0700 (PDT)
In-Reply-To: <BANLkTinesvJZmL3DSe--NXpsRONtaBxTVA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--bcaec548a921a0b7da04a5c96697
Content-Type: text/plain; charset=ISO-8859-1

On 14 June 2011 16:23, Harry Butterworth <heb1001@gmail.com> wrote:
> Great.  Creative got back to me today with a proposed solution for the
> PLL initialization.  I'll follow up with another patch in the next
> week probably.

Here's the change from Creative for the PLL initialization.  It works
for me and hasn't failed yet but it didn't fail that often before and
I don't have the chip spec so I can't vouch for the new magic numbers.

Harry

--bcaec548a921a0b7da04a5c96697
Content-Type: text/x-patch; charset=US-ASCII;
	name="0003-ALSA-ctxfi-Change-PLL-initialization-code.patch"
Content-Disposition: attachment;
	filename="0003-ALSA-ctxfi-Change-PLL-initialization-code.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gox05cxc0

RnJvbSAyN2IyZGRmNzM0M2Q1Njk3NjRkYTc1MGQzOWRkNDAzZDE2NDhjZjA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJyeSBCdXR0ZXJ3b3J0aCA8aGViMTAwMUBnbWFpbC5jb20+
CkRhdGU6IFR1ZSwgMTQgSnVuIDIwMTEgMjM6MDk6MTIgKzA4MDAKU3ViamVjdDogW1BBVENIIC0g
QUxTQTpjdHhmaSAzLzNdIEFMU0E6IGN0eGZpOiBDaGFuZ2UgUExMIGluaXRpYWxpemF0aW9uIGNv
ZGUKClRoaXMgaXMgYSByZXdvcmtlZCBwYXRjaCBmcm9tIENyZWF0aXZlIHRvIGNoYW5nZSB0aGUg
UExMIGNvZGUgdG8gYWRkcmVzcwp1bnJlbGlhYmxlIDQ0MTAwSHogaW5pdGlhbGl6YXRpb24uCgpT
aWduZWQtb2ZmLWJ5OiBIYXJyeSBCdXR0ZXJ3b3J0aCA8aGViMTAwMUBnbWFpbC5jb20+CgpkaWZm
IC0tZ2l0IGEvcGNpL2N0eGZpL2N0aHcyMGsyLmMgYi9wY2kvY3R4ZmkvY3RodzIwazIuYwppbmRl
eCBlYTU1OWE5Li40MTAxYThlIDEwMDY0NAotLS0gYS9wY2kvY3R4ZmkvY3RodzIwazIuYworKysg
Yi9wY2kvY3R4ZmkvY3RodzIwazIuYwpAQCAtMTMxNiwyMSArMTMxNiwxOCBAQCBzdGF0aWMgaW50
IGh3X3BsbF9pbml0KHN0cnVjdCBodyAqaHcsIHVuc2lnbmVkIGludCByc3IpCiAKIAlwbGxlbmIg
PSAweEI7CiAJaHdfd3JpdGVfMjBreChodywgUExMX0VOQiwgcGxsZW5iKTsKLQlwbGxjdGwgPSAw
eDIwRDAwMDAwOwotCXNldF9maWVsZCgmcGxsY3RsLCBQTExDVExfRkQsIDE2IC0gNCk7CisJcGxs
Y3RsID0gMHgyMEMwMDAwMDsKKwlzZXRfZmllbGQoJnBsbGN0bCwgUExMQ1RMX0IsIDApOworCXNl
dF9maWVsZCgmcGxsY3RsLCBQTExDVExfRkQsIDQ4MDAwID09IHJzciA/IDE2IC0gNCA6IDE0NyAt
IDQpOworCXNldF9maWVsZCgmcGxsY3RsLCBQTExDVExfUkQsIDQ4MDAwID09IHJzciA/IDEgLSAx
IDogMTAgLSAxKTsKIAlod193cml0ZV8yMGt4KGh3LCBQTExfQ1RMLCBwbGxjdGwpOwogCW1kZWxh
eSg0MCk7CisKIAlwbGxjdGwgPSBod19yZWFkXzIwa3goaHcsIFBMTF9DVEwpOwotCXNldF9maWVs
ZCgmcGxsY3RsLCBQTExDVExfQiwgMCk7Ci0JaWYgKDQ4MDAwID09IHJzcikgewotCQlzZXRfZmll
bGQoJnBsbGN0bCwgUExMQ1RMX0ZELCAxNiAtIDIpOwotCQlzZXRfZmllbGQoJnBsbGN0bCwgUExM
Q1RMX1JELCAxIC0gMSk7IC8qIDMwMDAqMTYvMSA9IDQ4MDAwICovCi0JfSBlbHNlIHsgLyogNDQx
MDAgKi8KLQkJc2V0X2ZpZWxkKCZwbGxjdGwsIFBMTENUTF9GRCwgMTQ3IC0gMik7Ci0JCXNldF9m
aWVsZCgmcGxsY3RsLCBQTExDVExfUkQsIDEwIC0gMSk7IC8qIDMwMDAqMTQ3LzEwID0gNDQxMDAg
Ki8KLQl9CisJc2V0X2ZpZWxkKCZwbGxjdGwsIFBMTENUTF9GRCwgNDgwMDAgPT0gcnNyID8gMTYg
LSAyIDogMTQ3IC0gMik7CiAJaHdfd3JpdGVfMjBreChodywgUExMX0NUTCwgcGxsY3RsKTsKIAlt
ZGVsYXkoNDApOworCiAJZm9yIChpID0gMDsgaSA8IDEwMDA7IGkrKykgewogCQlwbGxzdGF0ID0g
aHdfcmVhZF8yMGt4KGh3LCBQTExfU1RBVCk7CiAJCWlmIChnZXRfZmllbGQocGxsc3RhdCwgUExM
U1RBVF9QRCkpCi0tIAoxLjcuMC40Cgo=
--bcaec548a921a0b7da04a5c96697
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--bcaec548a921a0b7da04a5c96697--
