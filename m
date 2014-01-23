From: Daniel Turing <mail@danielturing.com>
Subject: [PATCH] fix alsa-tools/hdspmixer for RME 9632 A
Date: Thu, 23 Jan 2014 12:38:29 +0100
Message-ID: <CADeOaFr6H_pct9bywOey2p1XVfrT3sKmSDiGO_DS0vuPpcwqUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d044789cf3062e904f0a1aef1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f52.google.com (mail-oa0-f52.google.com
 [209.85.219.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DBA42625D4
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 12:38:31 +0100 (CET)
Received: by mail-oa0-f52.google.com with SMTP id i4so1951802oah.39
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 03:38:29 -0800 (PST)
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>
List-Id: alsa-devel@alsa-project.org

--f46d044789cf3062e904f0a1aef1
Content-Type: text/plain; charset=ISO-8859-1

Dear alsa-devel, Jaroslav and Adi,

since i never turned up here, let me just quickly congratulate and
thank y'all for your outstanding work on linux audio. My world
wouldn't be as great without you!

I run a HDSP 9632 with the "AI4s-192 AIO" 4x Analog input extension
board. It works great so far, but hdspmixer segfaults because it tries
to show 16 channels with fltk, but doesnt care to initialize the
channel labels for the input extension board.

Since one can only add either the output (AO4S), or the input (AI4S)
extension board, and hdspmixer already prepares channel labels for the
output case, the fix is quite easy, and attached.

I'd be happy if this patch could find its way into mainline alsa-tools.

Thanks,
-daniel

-- 
from the desk of Daniel Turing
see also: http://danielturing.com

--f46d044789cf3062e904f0a1aef1
Content-Type: text/x-patch; charset=US-ASCII; name="hdspmixer_9632_aebi.patch"
Content-Disposition: attachment; filename="hdspmixer_9632_aebi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hqrx7l9o0

ZGlmZiAtLWdpdCBhL2hkc3BtaXhlci9zcmMvSERTUE1peGVyU2VsZWN0b3IuY3h4IGIvaGRzcG1p
eGVyL3NyYy9IRFNQTWl4ZXJTZWxlY3Rvci5jeHgKaW5kZXggM2RjYmFkMy4uMDkxMDdhYyAxMDA2
NDQKLS0tIGEvaGRzcG1peGVyL3NyYy9IRFNQTWl4ZXJTZWxlY3Rvci5jeHgKKysrIGIvaGRzcG1p
eGVyL3NyYy9IRFNQTWl4ZXJTZWxlY3Rvci5jeHgKQEAgLTI5MSwxNSArMjkxLDE1IEBAIHZvaWQg
SERTUE1peGVyU2VsZWN0b3I6OnNldExhYmVscygpCiAgICAgfSBlbHNlIGlmICh0eXBlID09IEg5
NjMyKSB7CiAJc3dpdGNoIChzbSkgewogCWNhc2UgMDoKLQkgICAgbWF4X2Rlc3QgPSA2ICsgKGFl
Yi0+YWVibyA/IDIgOiAwKTsKKwkgICAgbWF4X2Rlc3QgPSA2ICsgKGFlYi0+YWVib3xhZWItPmFl
YmkgPyAyIDogMCk7CiAJICAgIGRlc3RpbmF0aW9ucyA9IGRlc3RpbmF0aW9uc19oOTYzMl9zczsK
IAkgICAgYnJlYWs7CiAJY2FzZSAxOgotCSAgICBtYXhfZGVzdCA9IDQgKyAoYWViLT5hZWJvID8g
MiA6IDApOworCSAgICBtYXhfZGVzdCA9IDQgKyAoYWViLT5hZWJvfGFlYi0+YWViaSA/IDIgOiAw
KTsKIAkgICAgZGVzdGluYXRpb25zID0gZGVzdGluYXRpb25zX2g5NjMyX2RzOwogCSAgICBicmVh
azsKIAljYXNlIDI6Ci0JICAgIG1heF9kZXN0ID0gMiArIChhZWItPmFlYm8gPyAyIDogMCk7CisJ
ICAgIG1heF9kZXN0ID0gMiArIChhZWItPmFlYm98YWViLT5hZWJpID8gMiA6IDApOwogCSAgICBk
ZXN0aW5hdGlvbnMgPSBkZXN0aW5hdGlvbnNfaDk2MzJfcXM7CiAJICAgIGJyZWFrOwogCX0K
--f46d044789cf3062e904f0a1aef1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--f46d044789cf3062e904f0a1aef1--
