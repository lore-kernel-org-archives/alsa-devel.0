From: =?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?= <gcembed@gmail.com>
Subject: Soc MC13783: Improve driver to handle LineIn
Date: Thu, 24 Jan 2013 10:42:22 +0100
Message-ID: <510101FE.4060307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 604912615D0
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 10:43:25 +0100 (CET)
Received: by mail-wi0-f182.google.com with SMTP id hn14so251231wib.3
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 01:43:25 -0800 (PST)
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
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

SGVsbG8sCkkgd291bGQgbGlrZSB0byBpbXByb3ZlIE1DMTM3ODMgZHJpdmVyIHRvIGJlIGFibGUg
dG8gY29udHJvbCBieXBhc3Mgb2YgCkxpbmVJbiAoUlhJTlIvTCkgYW5kIGZlZWQgQW5hbG9nIExp
bmVJbiBzdHJlYW0gaW50byBvdXB1dCBNaXhlciB2aWEgCkFERFJYSU4gZmxhZy4KVGhpcyBmaXJz
dCBzdGVwIG9uZSBpcyBmb3IgdGVzdCBwdXJwb3NlIGJ1dCBJIGFsc28gbmVlZCB0byBzZWxlY3Qg
ClJYSU5SL0wgYXMgY2FwdHVyZSBzb3VyY2UgKEkgc2F3IGluIFJNIHRoYXQgQ09ERUMgbXVzdCBi
ZSBlbmFibGVkIGFuZCAKb25seSBSWElOUiBmbGFnIG11c3QgYmUgc2VsZWN0ZWQgYXMgaW5wdXQp
IGJ1dCBub3RoaW5nIHNlZW1zIHRvIGJlIApjYXB0dXJlZCB0aGlzIGlzIHdoeSBJIG5lZWQgYnlw
YXNzIHdvcmtpbmcgdG8gdGVzdCBpbnB1dCBsZXZlbCwgYW5kIHNvIG9uLgoKSSB0cnkgdG8gY3Jl
YXRlIGEgTWl4ZXIgYmFzZWQgb24gb3RoZXIgZHJpdmVyIGJ1dCBpdCBkb2Vzbid0IHdvcmsuCkkg
dHJ5IHRvIGZpbmMgaW5mb3JtYXRpb24gYWJvdXQgd2lkZ2V0IG1hY3JvIFNORF9TT0NfREFQTV8q
IGJ1dCBpdCBpcyAKaGFyZCB0byBmaW5kIHNvbWV0aGluZyByZWxldmFudC4KKiBXaGljaCB3aWRn
ZXRzIGNhbiBiZSBsaW5rIHRvZ2V0aGVyID8KKiBJcyB0aGVyZSBmdW5jdGlvbmFsIGRpZmZlcmVu
Y2UgYmV0d2VlbiBWSVJUIGFuZCBub24tVklSVCB3aWRnZXQgPwoKSSB3aWxsIHBvc3QgbXkgY29k
ZSBpbiBzb21lIG1pbnV0ZXMgYWZ0ZXIgY2xlYW4tdXAuCgpUaGFua3MgYSBsb3QuCkdhw6t0YW4g
Q2FybGllci4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
