From: Daniel Mack <zonque@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Mon, 16 May 2011 08:56:56 +0200
Message-ID: <BANLkTikjU3KiL9HJJSwjHQ8qO-eLG3HWzQ@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
	<loom.20110514T184918-282@post.gmane.org>
	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>
	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>
	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>
	<BANLkTikUS1qcLa_OdCkW68cwFLRB7qqFbg@mail.gmail.com>
	<BANLkTinUrXN6KiYLOT=F=jdPmn=2t5F5OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd181c44c904e04a35f2935
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8495F244C2
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 08:56:58 +0200 (CEST)
Received: by pzk26 with SMTP id 26so2379820pzk.38
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 23:56:57 -0700 (PDT)
In-Reply-To: <BANLkTinUrXN6KiYLOT=F=jdPmn=2t5F5OQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Jaume?= <frederic.jaume@gmail.com>
Cc: Grant Diffey <gdiffey@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--000e0cd181c44c904e04a35f2935
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/5/15 Daniel Mack <zonque@gmail.com>:
> 2011/5/14 Fr=E9d=E9ric Jaume <frederic.jaume@gmail.com>:
>> Hi!
>>
>> Here's the "lsusb -v" for the Korg Pandora PX5D, attached. Hope this hel=
ps.
>
> The MIDI part of the descriptors is clearly marked as vendor specific,
> so there is nothing the driver can do about this, except for adding a
> quirk.
>
> Assuming the MIDI interface is class compliant, the following patch
> should help. Can you give it a try?

For the Pandora PX5D, we also have to use the USB_DEVICE_VENDOR_SPEC
macro, so the class compliant audio interfaces are not ignored by
adding the quirk.

Daniel

--000e0cd181c44c904e04a35f2935
Content-Type: application/octet-stream;
	name="0001-ALSA-usb-audio-Add-quirk-for-KORG-PANDORA-PX5D-MIDI-.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-usb-audio-Add-quirk-for-KORG-PANDORA-PX5D-MIDI-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnr27uq11

RnJvbSA3ZThhZDJlNjhhMTA2MjFiYjBkYmNmYzA2ZTZhZmQ2NjFlMjkxYWQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgTWFjayA8em9ucXVlQGdtYWlsLmNvbT4KRGF0ZTog
U3VuLCAxNSBNYXkgMjAxMSAxNTowODoxNyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6IHVz
Yi1hdWRpbzogQWRkIHF1aXJrIGZvciBLT1JHIFBBTkRPUkEgUFg1RCBNSURJCiBpbnRlcmZhY2UK
ClNpZ25lZC1vZmYtYnk6IERhbmllbCBNYWNrIDx6b25xdWVAZ21haWwuY29tPgotLS0KIHNvdW5k
L3VzYi9xdWlya3MtdGFibGUuaCB8ICAgMTEgKysrKysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC91c2Iv
cXVpcmtzLXRhYmxlLmggYi9zb3VuZC91c2IvcXVpcmtzLXRhYmxlLmgKaW5kZXggNWMxYTE3Ni4u
NzhjM2U4ZCAxMDA2NDQKLS0tIGEvc291bmQvdXNiL3F1aXJrcy10YWJsZS5oCisrKyBiL3NvdW5k
L3VzYi9xdWlya3MtdGFibGUuaApAQCAtMjE3OSw2ICsyMTc5LDE3IEBAIFlBTUFIQV9ERVZJQ0Uo
MHg3MDEwLCAiVUI5OSIpLAogCX0KIH0sCiAKKy8qIEtPUkcgZGV2aWNlcyAqLworeworCVVTQl9E
RVZJQ0VfVkVORE9SX1NQRUMoMHgwOTQ0LCAweDAyMDApLAorCS5kcml2ZXJfaW5mbyA9ICh1bnNp
Z25lZCBsb25nKSAmIChjb25zdCBzdHJ1Y3Qgc25kX3VzYl9hdWRpb19xdWlyaykgeworCQkudmVu
ZG9yX25hbWUgPSAiS09SRywgSW5jLiIsCisJCS8qIC5wcm9kdWN0X25hbWUgPSAiUEFORE9SQSBQ
WDVEIiwgKi8KKwkJLmlmbnVtID0gMywKKwkJLnR5cGUgPSBRVUlSS19NSURJX1NUQU5EQVJEX0lO
VEVSRkFDRSwKKwl9Cit9LAorCiAvKiBBS0FJIGRldmljZXMgKi8KIHsKIAlVU0JfREVWSUNFKDB4
MDllOCwgMHgwMDYyKSwKLS0gCjEuNy41LjEKCg==
--000e0cd181c44c904e04a35f2935
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000e0cd181c44c904e04a35f2935--
