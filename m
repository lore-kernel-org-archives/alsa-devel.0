From: Jeremy McDermond <mcdermj@xenotropic.com>
Subject: ASoC:  Machine Driver Interaction with Codec Drivers
Date: Tue, 7 Jun 2016 20:13:32 -0700
Message-ID: <0BE0E679-A120-4330-8291-315750457145@xenotropic.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A3C63260701
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2016 05:13:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.xenotropic.com (Postfix) with ESMTP id 4A82F20099
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 20:04:04 -0700 (PDT)
Received: from mail.xenotropic.com ([127.0.0.1])
 by localhost (mail.xenotropic.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NLqyGJPRgRfC for <alsa-devel@alsa-project.org>;
 Tue,  7 Jun 2016 20:04:02 -0700 (PDT)
Received: from [192.168.1.180] (c-76-115-126-109.hsd1.or.comcast.net
 [76.115.126.109])
 by mail.xenotropic.com (Postfix) with ESMTPSA id 9071720096
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 20:04:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SSBhcG9sb2dpemUgaW4gYWR2YW5jZSBmb3IgdGhlIHByb2JhYmx5IGlkaW90aWMgcXVlc3Rpb24u
CgpJ4oCZbSB3b3JraW5nIHdpdGggd3JpdGluZyBhIG1hY2hpbmUgZHJpdmVyIGZvciBvdXIgcHJv
ZHVjdCBhbmQgZGVhbGluZyB3aXRoIHNvbWUgcG90ZW50aWFsIHVzZXIgaW50ZXJmYWNlIGlzc3Vl
cyBzdXJyb3VuZGluZyB0aGUgbnVtYmVyIG9mIGNvbnRyb2xzIGJlaW5nIHByZXNlbnRlZCBieSB0
aGUgY29kZWMgZHJpdmVyIGluIHRoZSBtaXhlci4KCklzIHRoZXJlIGEgd2F5IHRvIOKAnGhhcmQt
d2lyZeKAnSBrY29udHJvbHMgaW4gdGhlIGNvZGVjIGZyb20gdGhlIG1hY2hpbmUgZHJpdmVyIGFu
ZCBoaWRlIHRoZW0gaW4gdGhlIG1peGVyPyAgRm9yIGV4YW1wbGUsIG91ciBoYXJkd2FyZSBkb2Vz
buKAmXQgd2lyZSB0aGUgSU4yX0wgYW5kIElOMl9SIHBpbnMgdG8gYW55d2hlcmUsIHNvIHRoZSBj
b2RlYyBjb250cm9scyB0aGF0IGRldGVybWluZSB0aGVpciBjb25uZWN0aW9ucyBpbnRvIHRoZSBp
bnB1dCBtaXhlciBkbyBub3RoaW5nIG9uIG91ciBoYXJkd2FyZSBhbmQgSeKAmWQgbGlrZSB0byBo
aWRlIHRoZW0gZnJvbSB0aGUgdXNlciBpbiB0aGUgbWl4ZXIuCgpBbSBJIG1pc3Npbmcgc29tZXRo
aW5nIG9yIGlzIHRoZXJlIGp1c3Qgbm8gd2F5IHRvIGdldCB0aGVyZSBmcm9tIGhlcmU/CgotLQpK
ZXJlbXkgTWNEZXJtb25kIChOSDZaKQpYZW5vdHJvcGljIFN5c3RlbXMKbWNkZXJtakB4ZW5vdHJv
cGljLmNvbQoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
