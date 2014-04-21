From: =?UTF-8?B?6IOh5rSq5YW1?= <huhb04@gmail.com>
Subject: [dapm question] About "playback_widget" power on or not
Date: Mon, 21 Apr 2014 15:10:20 +0800
Message-ID: <CAEN5SX9iHKOEt7FDPq9iooHu0o-6Uq6R0-mmLRb0iYsbBPfRNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id C752626109E
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 09:10:21 +0200 (CEST)
Received: by mail-pd0-f174.google.com with SMTP id y13so3362600pdi.5
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 00:10:20 -0700 (PDT)
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

aGkgIGRhcG0gZGV2ZWxvcGVycywKCkkgaGF2ZSBhIHF1ZXN0aW9uIGFib3V0ICJwbGF5YmFja193
aWRnZXQiLgoKTm9ib2R5IGdpdmVzIG1lIHJpZ2h0IGFuc3dlciwgc28gZW1haWwgdGhlIHF1ZXN0
aW9uIHRvIGRldmVsIG1haWxsaXN0LgoKSSBhbSBzb3JyeSB0byBkaXN0dXJiIHlvdSBhbmQgdGhh
bmtzIGZvciB5b3VyIGV4cGxhaW4KClF1ZXN0aW9uOgoKbXkgbWFjaGluZSBkcml2ZXIgZXhwb3J0
IHR3byBwY20gZGV2aWNlcywgIGVnLiAicGNtMCIsICJwY20xIi4KCk9wZW4gdGhlICJwY20wIiBm
b3IgUGxheWJhY2ssIGp1c3QgYWN0aXZlIEFJRjMgcGxheWJhY2tfd2lkZ2V0ICJBSUYzClBsYXli
Y2siLgoKYXQgc2FtZSB0aW1l77yMb25lIHBhdGggb2YgcGNtMSBpcyBhbHNvIHBvd2VyIG9u44CC
Cgp0aGUgcGF0aCBpcyDigJxIZWFkc2V0IE1pYyAtPiBJTjNSIC0+IEFJRjFUWCBJbnB1dCAxIC0+
IEFJRjFUWCBNaXhlciAtPgpBSUYxVFggLT4gQUlGMSBQbGF5YmNrIC0+IEFJRjFSWDEgLT4gSGVh
ZHBob25lIElucHV0IDEgLT4gSGVhZHBob25lIE1peGVyCi0+IEhlYWRwaG9uZeKAnQoKbXkgcXVl
c3Rpb24gaXMgInRoZSB3aWRnZXRzIG9mIHRoZSBwYXRoIHNob3VsZCBiZSBwb3dlcmVkIG9yIG5v
dCA/IgoKSSBndWVzcyB0aGF0IHRoZSBwYXRoIHNob3VsZCBub3QgYmUgcG93ZXJlZCwgYmVjYXVz
ZSAgInBjbTEiIGlzIG5vdCBvcGVuLAphbGwgcGF0aHMgb2YgaXQgc2hvdWxkIG5vdCBiZSBhY3R2
aWUuCgpNYXliZSBJIGFtIHdyb25n77yMIGJ1dCBsZXQgbWUga25vd24uCgpUaGFuayB5b3UgdmVy
eSBtdWNoIQoKKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqY2FzZQpzbmRfc29jX2RhcG1fZGFpX2luOgoJdy0+cG93ZXJfY2hlY2sg
PSBkYXBtX2RhY19jaGVja19wb3dlcjsKCgovKiBDaGVjayB0byBzZWUgaWYgYSBEQUMgaGFzIHBv
d2VyICovc3RhdGljIGludApkYXBtX2RhY19jaGVja19wb3dlcihzdHJ1Y3Qgc25kX3NvY19kYXBt
X3dpZGdldCAqdyl7CglpbnQgb3V0OwoKCURBUE1fVVBEQVRFX1NUQVQodywgcG93ZXJfY2hlY2tz
KTsKCglpZiAody0+YWN0aXZlKSB7CgkJb3V0ID0gaXNfY29ubmVjdGVkX291dHB1dF9lcCh3LCBO
VUxMKTsKCQlkYXBtX2NsZWFyX3dhbGtfb3V0cHV0KHctPmRhcG0sICZ3LT5zaW5rcyk7CgkJcmV0
dXJuIG91dCAhPSAwOwoJfSBlbHNlIHsKCQlyZXR1cm4gZGFwbV9nZW5lcmljX2NoZWNrX3Bvd2Vy
KHcpOwoJfX0KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
