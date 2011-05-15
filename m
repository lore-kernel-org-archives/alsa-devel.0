From: Daniel Mack <zonque@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Sun, 15 May 2011 23:30:33 +0200
Message-ID: <BANLkTimuaynDA+0wq9kqwizL5kp+b+AuLA@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
	<loom.20110514T184918-282@post.gmane.org>
	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>
	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>
	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>
	<BANLkTinFu=NLm+8dkM8h_KLMT=PtrutjYg@mail.gmail.com>
	<BANLkTik5LMFp-W2q9yhadPdJwswYXUbDgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd22d94b95a9c04a3573f19
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A89410387E
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 23:30:34 +0200 (CEST)
Received: by pxi19 with SMTP id 19so2868029pxi.29
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 14:30:33 -0700 (PDT)
In-Reply-To: <BANLkTik5LMFp-W2q9yhadPdJwswYXUbDgA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Jaume?= <frederic.jaume@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

--000e0cd22d94b95a9c04a3573f19
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, May 15, 2011 at 10:43 PM, Daniel Mack <zonque@gmail.com> wrote:
> On Sun, May 15, 2011 at 7:54 PM, Grant Diffey <gdiffey@gmail.com> wrote:
>> So I reverted=A0 7b6717e and... Nope. still no midi ports.
>>
>>
>> Kernel messages are:
>>
>> [=A0 131.484053] usb 3-1: new high speed USB device using ehci_hcd and a=
ddress
>> 3
>> [=A0 131.617753] usb 3-1: config 1 interface 3 altsetting 0 bulk endpoin=
t 0x7
>> has invalid maxpacket 8
>> [=A0 131.617760] usb 3-1: config 1 interface 3 altsetting 0 bulk endpoin=
t 0x87
>> has invalid maxpacket 8
>> [=A0 131.618750] usb 3-1: New USB device found, idVendor=3D0763, idProdu=
ct=3D2080
>> [=A0 131.618754] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2,
>> SerialNumber=3D0
>> [=A0 131.618756] usb 3-1: Product: Fast Track Ultra
>> [=A0 131.618758] usb 3-1: Manufacturer: M-Audio
>> [=A0 132.767312] usbcore: registered new interface driver snd-usb-audio
>>
>> And amidi -l reports
>>
>> nevyn@cetacea:~/linux$ amidi -l

Attached is a patch that adds some debug output. If you could apply
that and report what the kernel logs during the probe of the device,
that would be appreciated.


Thanks,
Daniel

--000e0cd22d94b95a9c04a3573f19
Content-Type: application/octet-stream; name="snd-usb-midi-debug.diff"
Content-Disposition: attachment; filename="snd-usb-midi-debug.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnqi0s1y0

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9jYXJkLmMgYi9zb3VuZC91c2IvY2FyZC5jCmluZGV4IGE5
MDY2MmEuLjFhNWI2MjAgMTAwNjQ0Ci0tLSBhL3NvdW5kL3VzYi9jYXJkLmMKKysrIGIvc291bmQv
dXNiL2NhcmQuYwpAQCAtMTQxLDYgKzE0MSw4IEBAIHN0YXRpYyBpbnQgc25kX3VzYl9jcmVhdGVf
c3RyZWFtKHN0cnVjdCBzbmRfdXNiX2F1ZGlvICpjaGlwLCBpbnQgY3RybGlmLCBpbnQgaW50CiAJ
c3RydWN0IHVzYl9pbnRlcmZhY2VfZGVzY3JpcHRvciAqYWx0c2Q7CiAJc3RydWN0IHVzYl9pbnRl
cmZhY2UgKmlmYWNlID0gdXNiX2lmbnVtX3RvX2lmKGRldiwgaW50ZXJmYWNlKTsKIAorcHJpbnRr
KEtFUk5fRVJSICIlcygpIGludGVyZmFjZSAlZFxuIiwgX19mdW5jX18sIGludGVyZmFjZSk7CisK
IAlpZiAoIWlmYWNlKSB7CiAJCXNuZF9wcmludGsoS0VSTl9FUlIgIiVkOiV1OiVkIDogZG9lcyBu
b3QgZXhpc3RcbiIsCiAJCQkgICBkZXYtPmRldm51bSwgY3RybGlmLCBpbnRlcmZhY2UpOwpAQCAt
MTQ4LDE2ICsxNTAsMTggQEAgc3RhdGljIGludCBzbmRfdXNiX2NyZWF0ZV9zdHJlYW0oc3RydWN0
IHNuZF91c2JfYXVkaW8gKmNoaXAsIGludCBjdHJsaWYsIGludCBpbnQKIAl9CiAKIAlpZiAodXNi
X2ludGVyZmFjZV9jbGFpbWVkKGlmYWNlKSkgewotCQlzbmRfcHJpbnRkZChLRVJOX0lORk8gIiVk
OiVkOiVkOiBza2lwcGluZywgYWxyZWFkeSBjbGFpbWVkXG4iLAorCQlzbmRfcHJpbnRrKEtFUk5f
RVJSICIlZDolZDolZDogc2tpcHBpbmcsIGFscmVhZHkgY2xhaW1lZFxuIiwKIAkJCQkJCWRldi0+
ZGV2bnVtLCBjdHJsaWYsIGludGVyZmFjZSk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KIAogCWFs
dHMgPSAmaWZhY2UtPmFsdHNldHRpbmdbMF07CiAJYWx0c2QgPSBnZXRfaWZhY2VfZGVzYyhhbHRz
KTsKK3ByaW50ayhLRVJOX0VSUiAiJXMoKSAuLiBiSW50ZXJmYWNlQ2xhc3MgJWQgYkludGVyZmFj
ZVN1YkNsYXNzICVkXG4iLCBfX2Z1bmNfXywgYWx0c2QtPmJJbnRlcmZhY2VDbGFzcywgYWx0c2Qt
PmJJbnRlcmZhY2VTdWJDbGFzcyk7CiAJaWYgKChhbHRzZC0+YkludGVyZmFjZUNsYXNzID09IFVT
Ql9DTEFTU19BVURJTyB8fAogCSAgICAgYWx0c2QtPmJJbnRlcmZhY2VDbGFzcyA9PSBVU0JfQ0xB
U1NfVkVORE9SX1NQRUMpICYmCiAJICAgIGFsdHNkLT5iSW50ZXJmYWNlU3ViQ2xhc3MgPT0gVVNC
X1NVQkNMQVNTX01JRElTVFJFQU1JTkcpIHsKK3ByaW50ayhLRVJOX0VSUiAiJXMoKTogY3JlYXRp
bmcgTUlESSBpbnRlcmZhY2VcbiIsIF9fZnVuY19fKTsKIAkJaW50IGVyciA9IHNuZF91c2JtaWRp
X2NyZWF0ZShjaGlwLT5jYXJkLCBpZmFjZSwKIAkJCQkJICAgICAmY2hpcC0+bWlkaV9saXN0LCBO
VUxMKTsKIAkJaWYgKGVyciA8IDApIHsKQEAgLTIzNiw2ICsyNDAsNyBAQCBzdGF0aWMgaW50IHNu
ZF91c2JfY3JlYXRlX3N0cmVhbXMoc3RydWN0IHNuZF91c2JfYXVkaW8gKmNoaXAsIGludCBjdHJs
aWYpCiAJCQlyZXR1cm4gLUVJTlZBTDsKIAkJfQogCitwcmludGsoS0VSTl9FUlIgIiVzKCkgLi4g
YkluQ29sbGVjdGlvbiAlZFxuIiwgX19mdW5jX18sIGgxLT5iSW5Db2xsZWN0aW9uKTsKIAkJZm9y
IChpID0gMDsgaSA8IGgxLT5iSW5Db2xsZWN0aW9uOyBpKyspCiAJCQlzbmRfdXNiX2NyZWF0ZV9z
dHJlYW0oY2hpcCwgY3RybGlmLCBoMS0+YmFJbnRlcmZhY2VOcltpXSk7CiAK
--000e0cd22d94b95a9c04a3573f19
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000e0cd22d94b95a9c04a3573f19--
