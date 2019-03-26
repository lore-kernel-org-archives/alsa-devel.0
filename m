From: Annaliese McDermond <nh6z@nh6z.net>
Subject: Common Mode Voltage Setting
Date: Tue, 26 Mar 2019 09:21:50 -0700
Message-ID: <A3590F3A-F641-4CEA-9737-0624710E180A@nh6z.net>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.100.42\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp121.ord1d.emailsrvr.com (smtp121.ord1d.emailsrvr.com
 [184.106.54.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF652F801D8
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 17:21:53 +0100 (CET)
Received: from smtp8.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
 by smtp8.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id B20D0C0164
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 12:21:51 -0400 (EDT)
Received: from smtp8.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
 by smtp8.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id AFCC6C0153
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 12:21:51 -0400 (EDT)
Received: by smtp8.relay.ord1d.emailsrvr.com (Authenticated sender:
 mcdermj-AT-xenotropic.com) with ESMTPSA id 777C2C0164
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 12:21:51 -0400 (EDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SSBoYXZlIGFuIGFyY2hpdGVjdHVyYWwgcXVlc3Rpb24gcmVnYXJkaW5nIHNvbWUgd29yayBJ4oCZ
bSBkb2luZy4gIApXZSBoYXZlIGEgcHJvZHVjdCB0aGF0IGhvb2tzIHRoZSBSYXNwYmVycnkgUGkg
dG8gdmFyaW91cyBhbWF0ZXVyIApyYWRpbyByaWdzIHZpYSBhIHNvdW5kIGNhcmQgaW50ZXJmYWNl
LiAgVGhlIGlucHV0IGNoYXJhY3RlcmlzdGljcyAKb2YgdGhvc2UgcmFkaW9zIHZhcnkgd2lkZWx5
IGluIHRoZSBhbW91bnQgb2Ygc2lnbmFsIHRoZXkgbmVlZCB0byAKZHJpdmUgdGhlIHByb3BlciBS
RiBvdXRwdXQgYW5kIHN1Y2guICBPbmUgb2YgdGhlIHNldHRpbmcgcyBJ4oCZdmUgCmltcGxlbWVu
dGVkIHRvIHRyeSB0byBoZWxwIG91ciBjdXN0b21lcnMgY29udHJvbCB0aGlzIGlzIGNoYW5naW5n
IAp0aGUgQ29tbW9uIE1vZGUgdm9sdGFnZSBvbiB0aGUgdGx2MzIwLiAgVGhlcmUgYXJlIGEgY291
cGxlIG9mIApvcHRpb25zLCBidXQgdGhlIGdpc3QgaXMgdGhhdCBvbmUgd2lsbCBhbGxvdyBoaWdo
ZXIgb3V0cHV0IGxldmVscyAKd2l0aG91dCBjbGlwcGluZy4gIFdlIG5lZWQgdG8ga2VlcCB0aGUg
ZmxleGliaWxpdHkgb2YgaGF2aW5nIHRoZSAKbG93ZXIgc2V0dGluZyBiZWNhdXNlIHRoZXJlIGFy
ZSBzb21lIHJhZGlvcyB0aGF0IHJlcXVpcmUgYXMgbGl0dGxlIApkcml2ZSBhcyBwb3NzaWJsZS4K
Ck15IHF1ZXN0aW9uIGlzIHJlYWxseSBzdXJyb3VuZGluZyB3aGVyZSB0aGUgYXBwcm9wcmlhdGUg
c2V0dGluZyAKZm9yIHRoaXMgd291bGQgYmUuICBJIGNvdWxkIHB1dCBpdCBpbiB0aGUgZGV2aWNl
IHRyZWUsIGJ1dCB0aGF0IApyZXF1aXJlcyBhZGRpbmcgZW50cmllcywgcHVzaGluZyB0aGlzIHBh
c3QgdGhlIERUIGZvbGtzIGFuZCBpdCAKYmVjb21lcyBzb21ldGhpbmcgdGhhdCBhIHVzZXIgaGFz
IHRvIHJlYm9vdCB0byBjaGFuZ2Ugc2V0dGluZ3MgCm9uLiAgSSB0aGluayBpdCBwcm9iYWJseSBt
b3JlIGFwcHJvcHJpYXRlbHkgZ29lcyBhcyBhIG1peGVyIApjb250cm9sIHNvIHRoYXQgaXQgY2Fu
IGJlIGNoYW5nZWQgb24gdGhlIGZseSB3aXRob3V0IHJlYm9vdAphbmQgaXMgYSBkeW5hbWljIHBh
cmFtZXRlci4KCkkganVzdCB3YW50IHRvIG1ha2Ugc3VyZSB0aGVyZeKAmXMgbm8gc3Ryb25nIHBy
ZWZlcmVuY2UgaGVyZSBvbiAKdGhlIOKAnHJpZ2h0IHdheeKAnSBpdCBzaG91bGQgYmUgZG9uZSBv
ciBpZiBJ4oCZbSBtaXNzaW5nIGEgd2F5IHRvIApzZXQgdGhpcyB0aGF04oCZcyBhIOKAnG5vbmUg
b2YgdGhlIGFib3ZlLuKAnQoKVGhhbmtzIQoKLS0KQW5uYWxpZXNlIE1jRGVybW9uZApuaDZ6QG5o
NnoubmV0Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
