From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: [PATCH 1/1] Alsa support for Maemo SDK (n770) - Remove
	compile warnings
Date: Mon, 6 Nov 2006 15:10:23 -0400
Message-ID: <a0580c510611061110l3ac6003fq4ff152deaeeb6808@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_22924_12657499.1162840223929"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.199])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 82A79260
	for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2006 20:10:25 +0100 (MET)
Received: by nz-out-0102.google.com with SMTP id i28so777046nzi
	for <alsa-devel@alsa-project.org>; Mon, 06 Nov 2006 11:10:24 -0800 (PST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mikko.a.leppanen@nokia.com
List-Id: alsa-devel@alsa-project.org

------=_Part_22924_12657499.1162840223929
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

    Here is a patch to remove compile warnings. It must be applied
after last patch set I sent.
    This patch simply changes signedness of some point from the code
to match the correct sign used by dsp-protocol structures. All must
use unsigned variables.
    It also changes the way the pthread_mutex is initialized. The
warning about pthreads is also removed.

    I tested the compilation with:
gcc (GCC) 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)
and
sbox-arm-linux-gcc (GCC) 3.4.4 (release) (CodeSourcery ARM 2005q3-2)

    Here is its diffstat:
 alsa-dsp.c     |    1 -
 dsp-ctl.c      |    4 ++--
 dsp-protocol.c |   27 ++++++++++++++-------------
 dsp-protocol.h |    2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)


Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>


BR,


---
Eduardo Bezerra Valentin

On 11/6/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 1 Nov 2006 13:06:00 -0400,
> Eduardo Valentin wrote:
> >
> > Hello all,
> >
> >    This patch series will add alsa support for Maemo SDK (nokia 770).
> > This is an alsa plugin and the patch series is against
> > alsa-plugins-1.0.13rc2 source code.
> >
> >    The plugin adds alsa support by communicating with n770's audio system.
> >
> >    To add ALSA support, an EXT PCM I/O plugin and EXT CTL plugin were
> > written. The code is based on SDK documentation from the alsa-project
> > site.
>
> Thanks for patches.  I committed them to ALSA HG repo now.
>
> I noticed many compile warnings with maemo plugin like below.  Most of
> them are harmless.  But a warning about pthread_mutexattr_settype
> should be fixed.
>
>
> Takashi
>
>
> if /bin/sh ../libtool --tag=CC --mode=compile gcc -DHAVE_CONFIG_H -I. -I. -I..    -Wall -fPIC -DPIC -O2 -I/usr/include/alsa    -O2 -Wall -W -pipe -g -MT dsp-protocol.lo -MD -MP -MF ".deps/dsp-protocol.Tpo" -c -o dsp-protocol.lo dsp-protocol.c; \
>         then mv -f ".deps/dsp-protocol.Tpo" ".deps/dsp-protocol.Plo"; else rm -f ".deps/dsp-protocol.Tpo"; exit 1; fi
> mkdir .libs
>  gcc -DHAVE_CONFIG_H -I. -I. -I.. -Wall -fPIC -DPIC -O2 -I/usr/include/alsa -O2 -Wall -W -pipe -g -MT dsp-protocol.lo -MD -MP -MF .deps/dsp-protocol.Tpo -c dsp-protocol.c  -fPIC -DPIC -o .libs/dsp-protocol.o
> dsp-protocol.c: In function 'dsp_protocol_create':
> dsp-protocol.c:111: warning: implicit declaration of function 'pthread_mutexattr_settype'
> dsp-protocol.c: In function 'dsp_protocol_set_volume':
> dsp-protocol.c:654: warning: pointer targets in passing argument 2 of 'dsp_protocol_linear2Q15' differ in signedness
> dsp-protocol.c:654: warning: pointer targets in passing argument 3 of 'dsp_protocol_linear2Q15' differ in signedness
> dsp-protocol.c: In function 'dsp_protocol_set_mic_enabled':
> dsp-protocol.c:871: warning: unused parameter 'dsp_protocol'
> if /bin/sh ../libtool --tag=CC --mode=compile gcc -DHAVE_CONFIG_H -I. -I. -I..    -Wall -fPIC -DPIC -O2 -I/usr/include/alsa    -O2 -Wall -W -pipe -g -MT dsp-ctl.lo -MD -MP -MF ".deps/dsp-ctl.Tpo" -c -o dsp-ctl.lo dsp-ctl.c; \
>         then mv -f ".deps/dsp-ctl.Tpo" ".deps/dsp-ctl.Plo"; else rm -f ".deps/dsp-ctl.Tpo"; exit 1; fi
>  gcc -DHAVE_CONFIG_H -I. -I. -I.. -Wall -fPIC -DPIC -O2 -I/usr/include/alsa -O2 -Wall -W -pipe -g -MT dsp-ctl.lo -MD -MP -MF .deps/dsp-ctl.Tpo -c dsp-ctl.c  -fPIC -DPIC -o .libs/dsp-ctl.o
> dsp-ctl.c: In function 'dsp_ctl_elem_list':
> dsp-ctl.c:139: warning: comparison between signed and unsigned
> dsp-ctl.c: In function 'dsp_ctl_get_attribute':
> dsp-ctl.c:224: warning: comparison between signed and unsigned
> dsp-ctl.c: In function 'dsp_ctl_get_integer_info':
> dsp-ctl.c:253: warning: comparison between signed and unsigned
> dsp-ctl.c: In function 'dsp_ctl_read_integer':
> dsp-ctl.c:281: warning: comparison between signed and unsigned
> dsp-ctl.c:288: warning: pointer targets in passing argument 2 of 'dsp_protocol_get_volume' differ in signedness
> dsp-ctl.c:288: warning: pointer targets in passing argument 3 of 'dsp_protocol_get_volume' differ in signedness
> dsp-ctl.c: In function 'dsp_ctl_write_integer':
> dsp-ctl.c:325: warning: comparison between signed and unsigned
> dsp-ctl.c:332: warning: pointer targets in passing argument 2 of 'dsp_protocol_get_volume' differ in signedness
> dsp-ctl.c:332: warning: pointer targets in passing argument 3 of 'dsp_protocol_get_volume' differ in signedness
> dsp-ctl.c:350: warning: comparison between signed and unsigned
> dsp-ctl.c: In function 'dsp_ctl_read_event':
> dsp-ctl.c:378: warning: unused parameter 'ext'
> dsp-ctl.c:378: warning: unused parameter 'id'
> dsp-ctl.c:379: warning: unused parameter 'event_mask'
> dsp-ctl.c: In function '_snd_ctl_dsp_ctl_open':
> dsp-ctl.c:528: warning: unused parameter 'root'
> /bin/sh ../libtool --tag=CC --mode=link gcc -Wall -fPIC -DPIC -O2 -I/usr/include/alsa    -O2 -Wall -W -pipe -g -shared -lm -ldl -lpthread -module -avoid-version -export-dynamic   -o libasound_module_ctl_dsp_ctl.la -rpath /usr/lib/alsa-lib  dsp-protocol.lo dsp-ctl.lo -lasound -lm -ldl -lpthread   -lasound
> gcc -shared  .libs/dsp-protocol.o .libs/dsp-ctl.o  -lm -ldl -lpthread /usr/lib/libasound.so  -Wl,-soname -Wl,libasound_module_ctl_dsp_ctl.so -o .libs/libasound_module_ctl_dsp_ctl.so
> creating libasound_module_ctl_dsp_ctl.la
> (cd .libs && rm -f libasound_module_ctl_dsp_ctl.la && ln -s ../libasound_module_ctl_dsp_ctl.la libasound_module_ctl_dsp_ctl.la)
> if /bin/sh ../libtool --tag=CC --mode=compile gcc -DHAVE_CONFIG_H -I. -I. -I..    -Wall -fPIC -DPIC -O2 -I/usr/include/alsa    -O2 -Wall -W -pipe -g -MT alsa-dsp.lo -MD -MP -MF ".deps/alsa-dsp.Tpo" -c -o alsa-dsp.lo alsa-dsp.c; \
>         then mv -f ".deps/alsa-dsp.Tpo" ".deps/alsa-dsp.Plo"; else rm -f ".deps/alsa-dsp.Tpo"; exit 1; fi
>  gcc -DHAVE_CONFIG_H -I. -I. -I.. -Wall -fPIC -DPIC -O2 -I/usr/include/alsa -O2 -Wall -W -pipe -g -MT alsa-dsp.lo -MD -MP -MF .deps/alsa-dsp.Tpo -c alsa-dsp.c  -fPIC -DPIC -o .libs/alsa-dsp.o
> alsa-dsp.c: In function 'alsa_dsp_transfer':
> alsa-dsp.c:146: warning: comparison between signed and unsigned
> alsa-dsp.c:167: warning: label 'out' defined but not used
> alsa-dsp.c: In function 'alsa_dsp_hw_params':
> alsa-dsp.c:241: warning: unused parameter 'params'
> alsa-dsp.c: In function 'alsa_dsp_pause':
> alsa-dsp.c:365: warning: unused parameter 'enable'
> alsa-dsp.c: In function '_snd_pcm_alsa_dsp_open':
> alsa-dsp.c:647: warning: unused parameter 'root'
>


-- 
Eduardo Bezerra Valentin

------=_Part_22924_12657499.1162840223929
Content-Type: text/x-patch; name="maemo-remove-warnings-20061106.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="maemo-remove-warnings-20061106.patch"
X-Attachment-Id: f_eu78ukh7

ZGlmZiAtcHJ1TiBhL21hZW1vL2Fsc2EtZHNwLmMgYi9tYWVtby9hbHNhLWRzcC5jCi0tLSBhL21h
ZW1vL2Fsc2EtZHNwLmMJMjAwNi0xMS0wNiAxNDo1MjozNC4wMDAwMDAwMDAgLTA0MDAKKysrIGIv
bWFlbW8vYWxzYS1kc3AuYwkyMDA2LTExLTA2IDE0OjQxOjU1LjAwMDAwMDAwMCAtMDQwMApAQCAt
MTY0LDcgKzE2NCw2IEBAIHN0YXRpYyBzbmRfcGNtX3NmcmFtZXNfdCBhbHNhX2RzcF90cmFuc2YK
IAkJCQkJCSAgICB3b3Jkcyk7CiAJcmVzdWx0ICo9IDI7CiAJcmVzdWx0IC89IGFsc2FfZHNwLT5i
eXRlc19wZXJfZnJhbWU7Ci0gICAgICBvdXQ6CiAJYWxzYV9kc3AtPmh3X3BvaW50ZXIgKz0gcmVz
dWx0OwogCURMRUFWRShyZXN1bHQpOwogCXJldHVybiByZXN1bHQ7CmRpZmYgLXBydU4gYS9tYWVt
by9kc3AtY3RsLmMgYi9tYWVtby9kc3AtY3RsLmMKLS0tIGEvbWFlbW8vZHNwLWN0bC5jCTIwMDYt
MTEtMDYgMTQ6NTI6MzQuMDAwMDAwMDAwIC0wNDAwCisrKyBiL21hZW1vL2RzcC1jdGwuYwkyMDA2
LTExLTA2IDE0OjQ3OjU3LjAwMDAwMDAwMCAtMDQwMApAQCAtMjczLDcgKzI3Myw3IEBAIHN0YXRp
YyBpbnQgZHNwX2N0bF9yZWFkX2ludGVnZXIoc25kX2N0bF8KIAkJCQlsb25nICp2YWx1ZSkKIHsK
IAlpbnQgcmV0ID0gMDsKLQljaGFyIGxlZnQsIHJpZ2h0OworCXVuc2lnbmVkIGNoYXIgbGVmdCwg
cmlnaHQ7CiAJc25kX2N0bF9kc3BfdCAqZHNwX2N0bCA9IGV4dC0+cHJpdmF0ZV9kYXRhOwogCWNv
bnRyb2xfbGlzdF90ICp0bXAgPSBkc3BfY3RsLT5jb250cm9sc1trZXldOwogCkBAIC0zMTcsNyAr
MzE3LDcgQEAgc3RhdGljIGludCBkc3BfY3RsX3dyaXRlX2ludGVnZXIoc25kX2N0bAogCQkJCSBs
b25nICp2YWx1ZSkKIHsKIAlpbnQgcmV0OwotCWNoYXIgbGVmdCwgcmlnaHQ7CisJdW5zaWduZWQg
Y2hhciBsZWZ0LCByaWdodDsKIAlzbmRfY3RsX2RzcF90ICpkc3BfY3RsID0gZXh0LT5wcml2YXRl
X2RhdGE7CiAJY29udHJvbF9saXN0X3QgKnRtcCA9IGRzcF9jdGwtPmNvbnRyb2xzW2tleV07CiAK
ZGlmZiAtcHJ1TiBhL21hZW1vL2RzcC1wcm90b2NvbC5jIGIvbWFlbW8vZHNwLXByb3RvY29sLmMK
LS0tIGEvbWFlbW8vZHNwLXByb3RvY29sLmMJMjAwNi0xMS0wNiAxNDo1MjozNC4wMDAwMDAwMDAg
LTA0MDAKKysrIGIvbWFlbW8vZHNwLXByb3RvY29sLmMJMjAwNi0xMS0wNiAxNDo0ODo1Mi4wMDAw
MDAwMDAgLTA0MDAKQEAgLTY5LDEwICs2OSwxMiBAQCB1bmlvbiBzZW11biB7CiBzdGF0aWMgaW50
IGRzcF9wcm90b2NvbF9mbHVzaChkc3BfcHJvdG9jb2xfdCAqIGRzcF9wcm90b2NvbCk7CiBzdGF0
aWMgaW50IGRzcF9wcm90b2NvbF9zZW5kX2NvbW1hbmQoZHNwX3Byb3RvY29sX3QgKiBkc3BfcHJv
dG9jb2wsCiAJCQkJICAgICBjb25zdCBzaG9ydCBpbnQgY29tbWFuZCk7Ci1zdGF0aWMgdm9pZCBk
c3BfcHJvdG9jb2xfbGluZWFyMlExNShjb25zdCBzaG9ydCBpbnQgaW5wdXQsCi0JCQkJICAgIHNo
b3J0IGludCAqc2NhbGUsIHNob3J0IGludCAqcG93ZXIyKTsKLXN0YXRpYyB2b2lkIGRzcF9wcm90
b2NvbF9RMTUybGluZWFyKGNvbnN0IHNob3J0IGludCBzY2FsZSwKLQkJCQkgICAgY29uc3Qgc2hv
cnQgaW50IHBvd2VyMiwgc2hvcnQgaW50ICpvdXRwdXQpOworc3RhdGljIHZvaWQgZHNwX3Byb3Rv
Y29sX2xpbmVhcjJRMTUoY29uc3QgdW5zaWduZWQgc2hvcnQgaW50IGlucHV0LAorCQkJCSAgICB1
bnNpZ25lZCBzaG9ydCBpbnQgKnNjYWxlLCAKKwkJCQkgICAgdW5zaWduZWQgc2hvcnQgaW50ICpw
b3dlcjIpOworc3RhdGljIHZvaWQgZHNwX3Byb3RvY29sX1ExNTJsaW5lYXIoY29uc3QgdW5zaWdu
ZWQgc2hvcnQgaW50IHNjYWxlLAorCQkJCSAgICBjb25zdCB1bnNpZ25lZCBzaG9ydCBpbnQgcG93
ZXIyLCAKKwkJCQkgICAgdW5zaWduZWQgc2hvcnQgaW50ICpvdXRwdXQpOwogc3RhdGljIGludCBk
c3BfcHJvdG9jb2xfdXBkYXRlX3N0YXRlKGRzcF9wcm90b2NvbF90ICogZHNwX3Byb3RvY29sKTsK
IHN0YXRpYyBpbmxpbmUgaW50IGRzcF9wcm90b2NvbF9nZXRfc2VtKGRzcF9wcm90b2NvbF90ICog
ZHNwX3Byb3RvY29sKTsKIHN0YXRpYyBpbmxpbmUgaW50IGRzcF9wcm90b2NvbF9sb2NrX2Rldihk
c3BfcHJvdG9jb2xfdCAqIGRzcF9wcm90b2NvbCk7CkBAIC05MCw4ICs5Miw4IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGRzcF9wcm90b2NvbF91bmxvY2tfZGUKICAqLwogaW50IGRzcF9wcm90b2NvbF9j
cmVhdGUoZHNwX3Byb3RvY29sX3QgKiogZHNwX3Byb3RvY29sKQogeworCXB0aHJlYWRfbXV0ZXhf
dCBtdXRleCA9IFBUSFJFQURfRVJST1JDSEVDS19NVVRFWF9JTklUSUFMSVpFUl9OUDsKIAlpbnQg
cmV0ID0gMDsKLQlwdGhyZWFkX211dGV4YXR0cl90IG1hdHRyOwogCURFTlRFUigpOwogCSpkc3Bf
cHJvdG9jb2wgPSAoZHNwX3Byb3RvY29sX3QgKikgY2FsbG9jKDEsIHNpemVvZihkc3BfcHJvdG9j
b2xfdCkpOwogCWlmICgoKmRzcF9wcm90b2NvbCkgPT0gTlVMTCkgewpAQCAtMTA3LDkgKzEwOSw3
IEBAIGludCBkc3BfcHJvdG9jb2xfY3JlYXRlKGRzcF9wcm90b2NvbF90ICoKIAkoKmRzcF9wcm90
b2NvbCktPmJyaWRnZV9idWZmZXJfc2l6ZSA9IDA7CiAJKCpkc3BfcHJvdG9jb2wpLT5tbWFwX2J1
ZmZlcl9zaXplID0gMDsKIAkoKmRzcF9wcm90b2NvbCktPm1tYXBfYnVmZmVyID0gTlVMTDsKLQlw
dGhyZWFkX211dGV4YXR0cl9pbml0KCZtYXR0cik7Ci0JcHRocmVhZF9tdXRleGF0dHJfc2V0dHlw
ZShQVEhSRUFEX01VVEVYX0VSUk9SQ0hFQ0tfTlApOwotCXB0aHJlYWRfbXV0ZXhfaW5pdCgmKCgq
ZHNwX3Byb3RvY29sKS0+bXV0ZXgpLCAmbWF0dHIpOworCSgqZHNwX3Byb3RvY29sKS0+bXV0ZXgg
PSBtdXRleDsKIAkoKmRzcF9wcm90b2NvbCktPnNlbV9zZXRfaWQgPSAtMTsKICNpZmRlZiBVU0Vf
UkVTT1VSQ0VfTUFOQUdFUgogICAgICAgICAoKmRzcF9wcm90b2NvbCktPmRidXNfY29ubmVjdGlv
biA9IGRidXNfYnVzX2dldChEQlVTX0JVU19TWVNURU0sIE5VTEwpOwpAQCAtNzE5LDcgKzcxOSw3
IEBAIGludCBkc3BfcHJvdG9jb2xfc2V0X3ZvbHVtZShkc3BfcHJvdG9jb2wKIGludCBkc3BfcHJv
dG9jb2xfZ2V0X3ZvbHVtZShkc3BfcHJvdG9jb2xfdCAqIGRzcF9wcm90b2NvbCwKIAkJCSAgICB1
bnNpZ25lZCBjaGFyICpsZWZ0LCB1bnNpZ25lZCBjaGFyICpyaWdodCkKIHsKLQlzaG9ydCBpbnQg
dG1wOworCXVuc2lnbmVkIHNob3J0IGludCB0bXA7CiAJaW50IHJldDsKIAlhdWRpb19zdGF0dXNf
aW5mb190IGF1ZGlvX3N0YXR1c19pbmZvOwogCURFTlRFUigpOwpAQCAtMTA1MCw4ICsxMDUwLDkg
QEAgc3RhdGljIGludCBkc3BfcHJvdG9jb2xfc2VuZF9jb21tYW5kKGRzcAogICogQ29udmVydHMg
YSAwIC0gMTAwIHZhbHVlIHRvIGEgUTE1IGZvcm1hdCB2YWx1ZS4KICAqIAogICovCi1zdGF0aWMg
dm9pZCBkc3BfcHJvdG9jb2xfbGluZWFyMlExNShjb25zdCBzaG9ydCBpbnQgaW5wdXQsCi0JCQkJ
ICAgIHNob3J0IGludCAqc2NhbGUsIHNob3J0IGludCAqcG93ZXIyKQorc3RhdGljIHZvaWQgZHNw
X3Byb3RvY29sX2xpbmVhcjJRMTUoY29uc3QgdW5zaWduZWQgc2hvcnQgaW50IGlucHV0LAorCQkJ
CSAgICB1bnNpZ25lZCBzaG9ydCBpbnQgKnNjYWxlLCAKKwkJCQkgICAgdW5zaWduZWQgc2hvcnQg
aW50ICpwb3dlcjIpCiB7CiAJdW5zaWduZWQgbG9uZyBpbnQgdmFsID0gTUFHSUNfTlVNQkVSICog
aW5wdXQ7CiAJREVOVEVSKCk7CkBAIC0xMDc5LDggKzEwODAsOCBAQCBzdGF0aWMgdm9pZCBkc3Bf
cHJvdG9jb2xfbGluZWFyMlExNShjb25zCiAgKiBDb252ZXJ0cyBhIFExNSBmb3JtYXQgdmFsdWUg
dG8gYSAwIC0gMTAwIHZhbHVlLgogICogCiAgKi8KLXN0YXRpYyB2b2lkIGRzcF9wcm90b2NvbF9R
MTUybGluZWFyKGNvbnN0IHNob3J0IGludCBzY2FsZSwKLQkJCQkgICAgY29uc3Qgc2hvcnQgaW50
IHBvd2VyMiwgc2hvcnQgaW50ICpvdXRwdXQpCitzdGF0aWMgdm9pZCBkc3BfcHJvdG9jb2xfUTE1
MmxpbmVhcihjb25zdCB1bnNpZ25lZCBzaG9ydCBpbnQgc2NhbGUsCisJCQkJICAgIGNvbnN0IHVu
c2lnbmVkIHNob3J0IGludCBwb3dlcjIsIHVuc2lnbmVkIHNob3J0IGludCAqb3V0cHV0KQogewog
CWZsb2F0IHJlc3VsdCA9IHNjYWxlICogMS4wIC8gMHg4MDAwICogcG93KDIuMCwgMS4wICogcG93
ZXIyKSAqIDEwMC4wOwogCURFTlRFUigpOwpkaWZmIC1wcnVOIGEvbWFlbW8vZHNwLXByb3RvY29s
LmggYi9tYWVtby9kc3AtcHJvdG9jb2wuaAotLS0gYS9tYWVtby9kc3AtcHJvdG9jb2wuaAkyMDA2
LTExLTA2IDE0OjUyOjM0LjAwMDAwMDAwMCAtMDQwMAorKysgYi9tYWVtby9kc3AtcHJvdG9jb2wu
aAkyMDA2LTExLTA2IDE0OjQxOjU1LjAwMDAwMDAwMCAtMDQwMApAQCAtMjQsNyArMjQsNyBAQAog
I2lmbmRlZiBfRFNQX1BST1RPQ09MX0gKICNkZWZpbmUgX0RTUF9QUk9UT0NPTF9ICiAKLSNkZWZp
bmUgX0dOVV9TT1VSQ0UKKyNkZWZpbmUgX19VU0VfR05VCiAjaW5jbHVkZSA8ZmVhdHVyZXMuaD4K
ICNpbmNsdWRlIDxwdGhyZWFkLmg+CiAjaW5jbHVkZSA8c2VtYXBob3JlLmg+Cg==
------=_Part_22924_12657499.1162840223929
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_22924_12657499.1162840223929
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_22924_12657499.1162840223929--
