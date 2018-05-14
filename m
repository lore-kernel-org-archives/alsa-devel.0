From: Muni Sekhar <munisekharrms@gmail.com>
Subject: sound: aplay\arecord audio frame flow
Date: Mon, 14 May 2018 18:11:41 +0530
Message-ID: <CAHhAz+itiVWKN7aiCJX17_6iHbyzdr2_4hr8=PB-=gCyzxMthg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 22434266C1C
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 14:41:43 +0200 (CEST)
Received: by mail-ot0-f193.google.com with SMTP id l12-v6so14059329oth.6
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 05:41:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

WyBQbGVhc2Uga2VlcCBtZSBpbiBDQyBhcyBJJ20gbm90IHN1YnNjcmliZWQgdG8gdGhlIGxpc3Rd
CgpIaSBBbGwsCgpJcyB0aGVyZSBhbnl3YXkgaW4gdGhlIGtlcm5lbCBzb3VuZCBzdWJzeXN0ZW0g
dG8ga25vdyB3aGVuIHRoZQphcHBsaWNhdGlvbiBjYWxscyDigJhhcGxheeKAmSBhbmQgYW55dGhp
bmcgc3RhcnRzIHBsYXlpbmc/CgpBbHNvIGZvciBhcmVjb3JkXGFwbGF5LCBJcyB0aGVyZSBhbnkg
d2F5IGZyb20ga2VybmVsJ3MgcG9pbnQgb2Ygdmlldwp0byBrbm93IHdoZW4gaXQgcmVjZWl2ZXMg
Zm9yIGV4YW1wbGUgdGhlIGZpcnN0IGFuZCBsYXN0IGF1ZGlvIGZyYW1lcz8KCgotLSAKVGhhbmtz
LApTZWtoYXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
