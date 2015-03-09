From: Xuebing Wang <xbing6@gmail.com>
Subject: About iMX6SL sign extension of SSI Receive
 Configuration Register (SSIx_SRCR)
Date: Mon, 09 Mar 2015 17:09:34 +0800
Message-ID: <54FD634E.8040007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f169.google.com (mail-qc0-f169.google.com
 [209.85.216.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B1172605CC
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 10:09:41 +0100 (CET)
Received: by qcvs11 with SMTP id s11so30936845qcv.6
 for <alsa-devel@alsa-project.org>; Mon, 09 Mar 2015 02:09:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, nicoleotsuka@gmail.com
Cc: niranjan Patil <Niranjan.Patil@infocus.com>, markus.lindroth@limesaudio.com, richard Jiang <Richard.Jiang@infocus.com>
List-Id: alsa-devel@alsa-project.org

SGkgTmljb2xpbiBhbmQgY29tbXVuaXR5LAoKaU1YNlNMIHJlZmVyZW5jZSBtYW51YWwgc2VjdGlv
biAiNDguOS44IFNTSSBSZWNlaXZlIENvbmZpZ3VyYXRpb24gClJlZ2lzdGVyIChTU0l4X1NSQ1Ip
IiBzYXlzIGFib3V0IHNpZ24gZXh0ZW5zaW9uLgoKQmVsb3cgaXMgYSBxdW90ZSBmcm9tIGlNWDZT
TCByZWZlcmVuY2UgbWFudWFsOgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClJlY2VpdmUgRGF0YSBFeHRlbnNpb24uIFRoaXMgY29u
dHJvbCBiaXQgYWxsb3dzIFNTSSB0byBzdG9yZSB0aGUgCnJlY2VpdmVkIGRhdGEgd29yZCBpbiBz
aWduIGV4dGVuZGVkIGZvcm0uClRoaXMgYml0IGFmZmVjdHMgZGF0YSBzdG9yYWdlIG9ubHkgaW4g
Y2FzZSByZWNlaXZlZCBkYXRhIGlzIExTQiBhbGlnbmVkIAooU1JDUls5XT0xKQoKMCBPRkYg4oCU
IFNpZ24gZXh0ZW5zaW9uIHR1cm5lZCBvZmYuCjEgT04g4oCUIFNpZ24gZXh0ZW5zaW9uIHR1cm5l
ZCBvbi4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQoKQWZ0ZXIgSSByZWNlaXZlIGRhdGEgKGluIHRoZSBmb3JtYXQgb2YgUzE2X0xF
KSBmcm9tIFNTSS9JMlMsIEkgZ290IGRhdGEgCmxpa2UgMHg3RkZGIG9yIDB4NzdkMi4gQXJlIHRo
ZXkgc3VwcG9zZWQgdG8gYmUgMHhGRkZGIG9yIDB4RjdkMj8KCkFmdGVyIHNldHRpbmcgYml0IDEw
IChSWEVYVCkgb2YgU1NJeF9TUkNSLCBJIHN0aWxsIGdldCAweDdGRkYgb3IgMHg3N2QyLgotLSBO
b3RlOiBTUkNSWzldIGlzIDEuCgpBbnkgc3VnZ2VzdGlvbnM/IFRoYW5rcy4KCi0tIApYdWViaW5n
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
