From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH] sound: usb-audio: full
 capture/playback/spdif support for Digidesign Mbox 2
Date: Sun, 23 Dec 2012 10:38:58 +1100
Message-ID: <CABXa2sF7rkoOriune=aWdw52g2qj3-DXjixs+pUvjF=2HgcurA@mail.gmail.com>
References: <AANLkTi=cSDq5SEh321Zy2n2RMHWFnW2-hd-=k9mz+eEz@mail.gmail.com>
 <4CEED787.9050504@gmail.com>
 <AANLkTimjaYMaqA3fFqWKi0+8nsaqENe8oWj=hph1Hv09@mail.gmail.com>
 <s5hfwukp4k4.wl%tiwai@suse.de>
 <AANLkTi=3JSsaa=P5s31+fq75Jp0WQUKD7mu0Ft8Tq+bP@mail.gmail.com>
 <4CF517BF.4020706@ladisch.de>
 <AANLkTi=Y6tA=1CW6Yu0rpAm7=JyLLjA1A-4cL-JFaBrP@mail.gmail.com>
 <AANLkTimH8OfncsS_WPtXGgFN316YeJQMtEEfkxXmEuQ8@mail.gmail.com>
 <CABXa2sE_WRgCv_Ym9gD2s0bggwBghSUsJhOamSYrNhq80_F8Bw@mail.gmail.com>
 <s5h6246saej.wl%tiwai@suse.de>
 <CABXa2sFRG7fuCnpvOhyhFre_McY7ts6caRUZeHO0didnTow3Sg@mail.gmail.com>
 <s5h4njqdraf.wl%tiwai@suse.de> <s5h38zadqvu.wl%tiwai@suse.de>
 <CABXa2sGwkOSmEXGhZ8123QFsr9T_c=+UzK5fdkZt-OE0CLF40w@mail.gmail.com>
 <s5hvcc6yp4w.wl%tiwai@suse.de>
 <CABXa2sE7wU5xJyR5QOutR9CcuR1dkqAL_LzuESCinNm89bGnaw@mail.gmail.com>
 <CABXa2sH6Kav20YBYjoii23C9C6vUb3BzW_-cT+xxji5dWaip9g@mail.gmail.com>
 <s5h8v8xx9f8.wl%tiwai@suse.de>
 <CABXa2sEKSe7AtvvYcaAP2EuvpEWUK8y1GK8Ck7-NBDiYYoJaug@mail.gmail.com>
 <s5hlicvv77n.wl%tiwai@suse.de> <s5hk3setjuj.wl%tiwai@suse.de>
 <CABXa2sHgaBr7grq=0nb=SofWMFsNP_cA-tAzLXq=A_H9a0Zgtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae93a19efd3f4bd04d17977b9
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 80BD3261744
 for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2012 00:38:59 +0100 (CET)
Received: by mail-ob0-f176.google.com with SMTP id un3so5738681obb.35
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2012 15:38:58 -0800 (PST)
In-Reply-To: <CABXa2sHgaBr7grq=0nb=SofWMFsNP_cA-tAzLXq=A_H9a0Zgtg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

--14dae93a19efd3f4bd04d17977b9
Content-Type: text/plain; charset=ISO-8859-1

On 19 December 2012 21:37, Damien Zammit <damien.zammit@gmail.com> wrote:
> I will be sure to compile this kernel when it comes out and double
> check it on the hardware!
Bad news, the kernel panics when I plug in the device on this kernel.
I compiled the kernel yesterday with default options except I changed
HZ=1000 and used generic X86_64 with kernel preemption:

$ uname -a
Linux zamserv 3.8.0-rc1 #1 SMP PREEMPT Sat Dec 22 21:56:06 EST 2012
x86_64 GNU/Linux

Attached is a panic dump.

Damien

--14dae93a19efd3f4bd04d17977b9
Content-Type: text/plain; charset=US-ASCII; name="mbox2.panic.txt"
Content-Disposition: attachment; filename="mbox2.panic.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hb1e1kly1

ClsgIDE5NC40NDUxNzBdIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBzdGFjay1wcm90ZWN0
b3I6IEtlcm5lbCBzdGFjayBpcyBjb3JydXB0ZWQgaW46IGZmZmZmZmZmYTBmMWIxYWYKWyAgMTk0
LjQ0NTE3MF0gClsgIDE5NC40NDUxODZdIFBpZDogNTUzLCBjb21tOiBraHViZCBUYWludGVkOiBQ
ICAgICAgICAgICBPIDMuOC4wLXJjMSAjMQpbICAxOTQuNDQ1MTkyXSBDYWxsIFRyYWNlOgpbICAx
OTQuNDQ1MjAzXSAgWzxmZmZmZmZmZjgxMzc5MTdhPl0gPyBwYW5pYysweGM4LzB4MWQxClsgIDE5
NC40NDUyMTJdICBbPGZmZmZmZmZmYTBmMWIxYWY+XSA/IHNuZF91c2JfbWJveDJfYm9vdF9xdWly
aysweDFmMS8weDFmYSBbc25kX3VzYl9hdWRpb10KWyAgMTk0LjQ0NTIxOV0gIFs8ZmZmZmZmZmY4
MTAzZWI4ZD5dID8gX19zdGFja19jaGtfZmFpbCsweDE1LzB4MTUKWyAgMTk0LjQ0NTIyNl0gIFs8
ZmZmZmZmZmZhMGYxYjFhZj5dID8gc25kX3VzYl9tYm94Ml9ib290X3F1aXJrKzB4MWYxLzB4MWZh
IFtzbmRfdXNiX2F1ZGlvXQpbICAxOTQuNDQ1MjMyXSAgWzxmZmZmZmZmZmEwZjFiNTFlPl0gPyBz
bmRfdXNiX2FwcGx5X2Jvb3RfcXVpcmsrMHgyMDYvMHgzMDcgW3NuZF91c2JfYXVkaW9dClsgIDE5
NC40NDUyMzldICBbPGZmZmZmZmZmODExMDBjM2I+XSA/IGttZW1fY2FjaGVfYWxsb2MrMHg4Ni8w
eDEwMwpbICAxOTQuNDQ1MjQ1XSAgWzxmZmZmZmZmZjgxMTVmMmY4Pl0gPyBzeXNmc19saW5rX3Np
YmxpbmcrMHg4ZC8weDliClsgIDE5NC40NDUyNTBdICBbPGZmZmZmZmZmYTBmMTIzZDE+XSA/IHVz
Yl9hdWRpb19wcm9iZSsweDgyLzB4NzI5IFtzbmRfdXNiX2F1ZGlvXQpbICAxOTQuNDQ1MjU3XSAg
WzxmZmZmZmZmZjgxMzdlY2U0Pl0gPyBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4MjEvMHg0Ngpb
ICAxOTQuNDQ1MjYzXSAgWzxmZmZmZmZmZjgxMjgwNGVkPl0gPyBfX3BtX3J1bnRpbWVfc2V0X3N0
YXR1cysweDEyMS8weDE0ZApbICAxOTQuNDQ1MjgxXSAgWzxmZmZmZmZmZmEwMThlNzNhPl0gPyB1
c2JfcHJvYmVfaW50ZXJmYWNlKzB4MTMxLzB4MWMzIFt1c2Jjb3JlXQpbICAxOTQuNDQ1Mjg4XSAg
WzxmZmZmZmZmZjgxMjc3ZmM2Pl0gPyBfX2RyaXZlcl9hdHRhY2grMHg3My8weDczClsgIDE5NC40
NDUyOTVdICBbPGZmZmZmZmZmODEyNzdmYzY+XSA/IF9fZHJpdmVyX2F0dGFjaCsweDczLzB4NzMK
WyAgMTk0LjQ0NTMwMV0gIFs8ZmZmZmZmZmY4MTI3N2UzNT5dID8gZHJpdmVyX3Byb2JlX2Rldmlj
ZSsweDkyLzB4MWIwClsgIDE5NC40NDUzMDddICBbPGZmZmZmZmZmODEyNzY2YmI+XSA/IGJ1c19m
b3JfZWFjaF9kcnYrMHg0My8weDdkClsgIDE5NC40NDUzMTRdICBbPGZmZmZmZmZmODEyNzdkNzE+
XSA/IGRldmljZV9hdHRhY2grMHg2OC8weDgzClsgIDE5NC40NDUzMjBdICBbPGZmZmZmZmZmODEy
Nzc0Mzc+XSA/IGJ1c19wcm9iZV9kZXZpY2UrMHgyNS8weDhkClsgIDE5NC40NDUzMjVdICBbPGZm
ZmZmZmZmODEyNzVlMzc+XSA/IGRldmljZV9hZGQrMHgzZWEvMHg1YWIKWyAgMTk0LjQ0NTMzMF0g
IFs8ZmZmZmZmZmY4MTM3ZWNlND5dID8gX3Jhd19zcGluX2xvY2tfaXJxc2F2ZSsweDIxLzB4NDYK
WyAgMTk0LjQ0NTM0MV0gIFs8ZmZmZmZmZmZhMDE4ZDJjMT5dID8gdXNiX3NldF9jb25maWd1cmF0
aW9uKzB4NWUxLzB4NjNlIFt1c2Jjb3JlXQpbICAxOTQuNDQ1MzQ4XSAgWzxmZmZmZmZmZjgxMjc3
ZmM2Pl0gPyBfX2RyaXZlcl9hdHRhY2grMHg3My8weDczClsgIDE5NC40NDUzNThdICBbPGZmZmZm
ZmZmYTAxOTQ4Nzc+XSA/IGdlbmVyaWNfcHJvYmUrMHgzYi8weDY4IFt1c2Jjb3JlXQpbICAxOTQu
NDQ1MzY1XSAgWzxmZmZmZmZmZjgxMjc3ZTM1Pl0gPyBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4OTIv
MHgxYjAKWyAgMTk0LjQ0NTM3MF0gIFs8ZmZmZmZmZmY4MTI3NjZiYj5dID8gYnVzX2Zvcl9lYWNo
X2RydisweDQzLzB4N2QKWyAgMTk0LjQ0NTM3N10gIFs8ZmZmZmZmZmY4MTI3N2Q3MT5dID8gZGV2
aWNlX2F0dGFjaCsweDY4LzB4ODMKWyAgMTk0LjQ0NTM4Ml0gIFs8ZmZmZmZmZmY4MTI3NzQzNz5d
ID8gYnVzX3Byb2JlX2RldmljZSsweDI1LzB4OGQKWyAgMTk0LjQ0NTM4OF0gIFs8ZmZmZmZmZmY4
MTI3NWUzNz5dID8gZGV2aWNlX2FkZCsweDNlYS8weDVhYgpbICAxOTQuNDQ1Mzk4XSAgWzxmZmZm
ZmZmZmEwMTg2ZWJjPl0gPyB1c2JfbmV3X2RldmljZSsweDFlZC8weDI4NCBbdXNiY29yZV0KWyAg
MTk0LjQ0NTQwOF0gIFs8ZmZmZmZmZmZhMDE4ODA5MD5dID8gaHViX3RocmVhZCsweDlkMy8weGU4
OSBbdXNiY29yZV0KWyAgMTk0LjQ0NTQxNF0gIFs8ZmZmZmZmZmY4MTM3ZTA0Nz5dID8gX19zY2hl
ZHVsZSsweDRjZi8weDUwMgpbICAxOTQuNDQ1NDIxXSAgWzxmZmZmZmZmZjgxMDU5YWJmPl0gPyBh
Ym9ydF9leGNsdXNpdmVfd2FpdCsweDc5LzB4NzkKWyAgMTk0LjQ0NTQzMF0gIFs8ZmZmZmZmZmZh
MDE4NzZiZD5dID8gdXNiX3JlbW90ZV93YWtldXArMHgyZi8weDJmIFt1c2Jjb3JlXQpbICAxOTQu
NDQ1NDM5XSAgWzxmZmZmZmZmZmEwMTg3NmJkPl0gPyB1c2JfcmVtb3RlX3dha2V1cCsweDJmLzB4
MmYgW3VzYmNvcmVdClsgIDE5NC40NDU0NDRdICBbPGZmZmZmZmZmODEwNTkxMTY+XSA/IGt0aHJl
YWQrMHg4MS8weDg5ClsgIDE5NC40NDU0NDldICBbPGZmZmZmZmZmODEwNTkwOTU+XSA/IF9fa3Ro
cmVhZF9wYXJrbWUrMHg1Yy8weDVjClsgIDE5NC40NDU0NTVdICBbPGZmZmZmZmZmODEzODM0YmM+
XSA/IHJldF9mcm9tX2ZvcmsrMHg3Yy8weGIwClsgIDE5NC40NDU0NjBdICBbPGZmZmZmZmZmODEw
NTkwOTU+XSA/IF9fa3RocmVhZF9wYXJrbWUrMHg1Yy8weDVjCg==
--14dae93a19efd3f4bd04d17977b9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--14dae93a19efd3f4bd04d17977b9--
