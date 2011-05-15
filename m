From: Daniel Mack <zonque@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Sun, 15 May 2011 15:12:51 +0200
Message-ID: <BANLkTinUrXN6KiYLOT=F=jdPmn=2t5F5OQ@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
	<loom.20110514T184918-282@post.gmane.org>
	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>
	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>
	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>
	<BANLkTikUS1qcLa_OdCkW68cwFLRB7qqFbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd181c4d5514204a3504bd6
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D23D10380A
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 15:12:55 +0200 (CEST)
Received: by pwi9 with SMTP id 9so2115882pwi.38
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 06:12:51 -0700 (PDT)
In-Reply-To: <BANLkTikUS1qcLa_OdCkW68cwFLRB7qqFbg@mail.gmail.com>
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

--000e0cd181c4d5514204a3504bd6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/5/14 Fr=E9d=E9ric Jaume <frederic.jaume@gmail.com>:
> Hi!
>
> Here's the "lsusb -v" for the Korg Pandora PX5D, attached. Hope this help=
s.

The MIDI part of the descriptors is clearly marked as vendor specific,
so there is nothing the driver can do about this, except for adding a
quirk.

Assuming the MIDI interface is class compliant, the following patch
should help. Can you give it a try?

Thanks,
Daniel

--000e0cd181c4d5514204a3504bd6
Content-Type: application/octet-stream;
	name="0001-ALSA-usb-audio-Add-quirk-for-KORG-PANDORA-PX5D-MIDI-.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-usb-audio-Add-quirk-for-KORG-PANDORA-PX5D-MIDI-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnq08xmb1

RnJvbSAwNDg4MzNkMDI5MjVjNDM3OGY5MTM4ZTY3NjU2NTNhNGJmZDA3MjY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgTWFjayA8em9ucXVlQGdtYWlsLmNvbT4KRGF0ZTog
U3VuLCAxNSBNYXkgMjAxMSAxNTowODoxNyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6IHVz
Yi1hdWRpbzogQWRkIHF1aXJrIGZvciBLT1JHIFBBTkRPUkEgUFg1RCBNSURJIGludGVyZmFjZQoK
U2lnbmVkLW9mZi1ieTogRGFuaWVsIE1hY2sgPHpvbnF1ZUBnbWFpbC5jb20+Ci0tLQogc291bmQv
dXNiL3F1aXJrcy10YWJsZS5oIHwgICAxMSArKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9x
dWlya3MtdGFibGUuaCBiL3NvdW5kL3VzYi9xdWlya3MtdGFibGUuaAppbmRleCA1YzFhMTc2Li43
NzllOGFkIDEwMDY0NAotLS0gYS9zb3VuZC91c2IvcXVpcmtzLXRhYmxlLmgKKysrIGIvc291bmQv
dXNiL3F1aXJrcy10YWJsZS5oCkBAIC0yMTc5LDYgKzIxNzksMTcgQEAgWUFNQUhBX0RFVklDRSgw
eDcwMTAsICJVQjk5IiksCiAJfQogfSwKIAorLyogS09SRyBkZXZpY2VzICovCit7CisJVVNCX0RF
VklDRSgweDA5NDQsIDB4MDIwMCksCisJLmRyaXZlcl9pbmZvID0gKHVuc2lnbmVkIGxvbmcpICYg
KGNvbnN0IHN0cnVjdCBzbmRfdXNiX2F1ZGlvX3F1aXJrKSB7CisJCS52ZW5kb3JfbmFtZSA9ICJL
T1JHLCBJbmMuIiwKKwkJLyogLnByb2R1Y3RfbmFtZSA9ICJQQU5ET1JBIFBYNUQiLCAqLworCQku
aWZudW0gPSAzLAorCQkudHlwZSA9IFFVSVJLX01JRElfU1RBTkRBUkRfSU5URVJGQUNFLAorCX0K
K30sCisKIC8qIEFLQUkgZGV2aWNlcyAqLwogewogCVVTQl9ERVZJQ0UoMHgwOWU4LCAweDAwNjIp
LAotLSAKMS43LjEKCg==
--000e0cd181c4d5514204a3504bd6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000e0cd181c4d5514204a3504bd6--
