From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: RME Hammerfall HDSP 9652
Date: Wed, 27 Aug 2003 13:39:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34419.80.13.13.11.1061984366.squirrel@www.undata.org>
References: <20030827160852.D21247@nautronix.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20030827133926_54689"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030827160852.D21247@nautronix.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: nick.arnold@nautronix.com.au
List-Id: alsa-devel@alsa-project.org

------=_20030827133926_54689
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

> Hello,
>
> We here are attempting to get the RME Hammerfall HDSP 9652 card working
> with ALSA 0.9.6 on a SMP redhat 9 box.  We're trying to use 12 input
> channels and three output channels, running at 96KHz 24bit samples.  The
> output of  "uname -a" on the box says:
>
>     Linux wombat 2.4.20-19.9smp #1 SMP Tue Jul 15 16:45:28 EDT 2003 i686
> athlon i386 GNU/Linux
>
> We had been successfully using the "old" RME Hammerfall 9652 with ALSA
> 0.9.0 beta12 on an older machine with the same channels/sample
> rate/sample size.
>
> With a signal connected to one input channel and nothing written to the
> card we're seeing output on several channels.  I think this could be
> related to settings of the hardware mixer?  I'm looking into the
> "amixer" utility but have so-far been unable to find any options that
> help.
>
> We have a known signal (IRIG-B) connected to one input channel and our
> software is now having trouble decoding the signal when it didn't
> before. We're not sure why this could be occuring.
>
> 1) first of all, we're assuming it is possible to get the card working
> on
>    this setup?
>

With this driver version the matrix mixer code is still broken and the
metering code is not implemented. Please apply the attach patch to correct
this. Mark Knecht is currently using this code with success, but the card
behaved strangely with rev. 104 (0x68) firmware. He had to downgrade it to
rev. 101 (0x65) for the card to work properly. Please let me know if
you're having the same problems.
I also have a development version of hdspmixer working for the card, email
me if you need it. I'll release it soon, as well as a huge driver patch,
when hdsp 9632 support will be completed (btw the 9632 driver code is
already functionnal, people can mail me if they need it right now).

> 2) I'm trying to determine if this card actually supports 96KHz (ie as a
>    parameter to snd_pcm_hw_params_set_rate_near() for example) -- the
> "old" card was always set to 48KHz and we "simulated" 96KHz with two
> 48KHz channels per 96KHz channel.  Is this still the way to do it?
>

The card needs to be set to 96 kHz, then the ADAT channel coupling will
work as you described.

> 3) It seems we need to find the right "amixer" incantations to get the
> driver
>    into a workable state.  The one thing that seems to have helped so
> far is to set the "Sample Clock Source" interface of the mixer to
> "Internal 96.0 kHz" with the command:
>
>         amixer -c 0 cset -numid=11 6
>

It looks good to me, except the '-' before numid. Note that you can also
use the hdspconf GUI to control this.

>    But we're not sure this is really what we want.  Are there other
> commands we need?  I don't believe we have a problem with output
> channel levels since we've played with these.
>

I think it's what you want. Please let me know if you have success with this.

Thomas



------=_20030827133926_54689
Content-Type: application/octet-stream; name="hdsp9652.patch"
Content-Disposition: attachment; filename="hdsp9652.patch"
Content-Transfer-Encoding: base64

LS0tIGhkc3AuYy4wLjkuNgkyMDAzLTA3LTE4IDEyOjA0OjU5LjAwMDAwMDAwMCArMDIwMAorKysg
aGRzcC5jCTIwMDMtMDgtMTYgMTY6MTQ6MTguMDAwMDAwMDAwICswMjAwCkBAIC0xMjEsNyArMTIx
LDEwIEBACiAjZGVmaW5lIEhEU1BfcGxheWJhY2tSbXNMZXZlbCAgIDQ2MTIgIC8qIDI2ICogNjQg
Yml0IHZhbHVlcyAqLwogI2RlZmluZSBIRFNQX2lucHV0Um1zTGV2ZWwgICAgICA0ODY4ICAvKiAy
NiAqIDY0IGJpdCB2YWx1ZXMgKi8KIAotI2RlZmluZSBIRFNQX0lPX0VYVEVOVCAgICAgNTE5Mgor
I2RlZmluZSBIRFNQXzk2NTJfcGVha0Jhc2UJNzE2NAkKKyNkZWZpbmUgSERTUF85NjUyX3Jtc0Jh
c2UJNDA5NgorCisjZGVmaW5lIEhEU1BfSU9fRVhURU5UICAgICA3MTY4CiAKIC8qIGNvbnRyb2wy
IHJlZ2lzdGVyIGJpdHMgKi8KIApAQCAtNDk1LDYgKzQ5OCw3IEBACiBzdGF0aWMgaW50IGhkc3Bf
dXBkYXRlX3NpbXBsZV9taXhlcl9jb250cm9scyhoZHNwX3QgKmhkc3ApOwogc3RhdGljIGludCBo
ZHNwX2F1dG9zeW5jX3JlZihoZHNwX3QgKmhkc3ApOwogc3RhdGljIGludCBzbmRfaGRzcF9zZXRf
ZGVmYXVsdHMoaGRzcF90ICpoZHNwKTsKK3N0YXRpYyBpbmxpbmUgdm9pZCBzbmRfaGRzcF85NjUy
X2VuYWJsZV9taXhlciAoaGRzcF90ICpoZHNwKTsKIAogc3RhdGljIGlubGluZSBpbnQgaGRzcF9w
bGF5YmFja190b19vdXRwdXRfa2V5IChoZHNwX3QgKmhkc3AsIGludCBpbiwgaW50IG91dCkKIHsK
QEAgLTcxNiw4ICs3MjAsOSBAQAogCQkgICBjb3JyZXNwb25kaW5nIG1lbW9yeSBsb2NhdGlvbiwg
d2UgbmVlZAogCQkgICB0byBhY2Nlc3MgMCB0byAyNzAzIC4uLgogCQkqLwotCi0JCWhkc3Bfd3Jp
dGUgKGhkc3AsIDQwOTYgKyAoYWRkcioyKSwgCisJCWFkID0gYWRkci8yOworCQorCQloZHNwX3dy
aXRlIChoZHNwLCA0MDk2ICsgKGFkKjQpLCAKIAkJCSAgICAoaGRzcC0+bWl4ZXJfbWF0cml4Wyhh
ZGRyJjB4N2ZlKSsxXSA8PCAxNikgKyAKIAkJCSAgICBoZHNwLT5taXhlcl9tYXRyaXhbYWRkciYw
eDdmZV0pOwogCQkKQEAgLTMwNzgsOCArMzA4MywyMSBAQAogCQkgICAgICAgICAgICAgICAgIEhE
U1BfU1BESUZJbnB1dENvYXhpYWwgfCAKIAkJICAgICAgICAgICAgICAgICBoZHNwX2VuY29kZV9s
YXRlbmN5KDcpIHwgCiAJCSAgICAgICAgICAgICAgICAgSERTUF9MaW5lT3V0OworCQogCiAJaGRz
cF93cml0ZShoZHNwLCBIRFNQX2NvbnRyb2xSZWdpc3RlciwgaGRzcC0+Y29udHJvbF9yZWdpc3Rl
cik7CisKKyNpZmRlZiBTTkRSVl9CSUdfRU5ESUFOCisJaGRzcC0+Y29udHJvbDJfcmVnaXN0ZXIg
PSBIRFNQX0JJR0VORElBTl9NT0RFOworI2Vsc2UKKwloZHNwLT5jb250cm9sMl9yZWdpc3RlciA9
IDA7CisjZW5kaWYKKwlpZiAoaGRzcC0+aW9fdHlwZSA9PSBIOTY1MikgeworCSAgICAgICAgc25k
X2hkc3BfOTY1Ml9lbmFibGVfbWl4ZXIgKGhkc3ApOworCX0gZWxzZSB7CisJICAgIGhkc3Bfd3Jp
dGUgKGhkc3AsIEhEU1BfY29udHJvbDJSZWcsIGhkc3AtPmNvbnRyb2wyX3JlZ2lzdGVyKTsKKwl9
IAorCiAJaGRzcF9yZXNldF9od19wb2ludGVyKGhkc3ApOwogCWhkc3BfY29tcHV0ZV9wZXJpb2Rf
c2l6ZShoZHNwKTsKIApAQCAtMzgwMCw4ICszODE4LDQ3IEBACiAJc3dpdGNoIChjbWQpIHsKIAlj
YXNlIFNORFJWX0hEU1BfSU9DVExfR0VUX1BFQUtfUk1TOgogCQlpZiAoaGRzcC0+aW9fdHlwZSA9
PSBIOTY1MikgewotCQkgICAgc25kX3ByaW50aygiaGFyZHdhcmUgbWV0ZXJpbmcgaXNuJ3Qgc3Vw
cG9ydGVkIHlldCBmb3IgaGRzcDk2NTIgY2FyZHNcbiIpOwotCQkgICAgcmV0dXJuIC1FSU5WQUw7
CisJCQl1bnNpZ25lZCBsb25nIHJtc19sb3csIHJtc19oaWdoOworCQkJaW50IGk7CisJCQlpbnQg
ZG91Ymxlc3BlZWQgPSAwOworCQkJaWYgKGhkc3BfcmVhZCAoaGRzcCwgSERTUF9zdGF0dXNSZWdp
c3RlcikgJiBIRFNQX0RvdWJsZVNwZWVkU3RhdHVzKQorCQkJCWRvdWJsZXNwZWVkID0gMTsKKwkJ
CXBlYWtfcm1zID0gKGhkc3BfcGVha19ybXNfdCAqKWFyZzsKKwkJCWZvciAoaSA9IDA7IGkgPCAy
NjsgKytpKSB7CisJCQkJaWYgKCEoZG91Ymxlc3BlZWQgJiYgKGkgJiA0KSkpIHsKKwkJCQkJaWYg
KGNvcHlfdG9fdXNlcl9mcm9taW8oKHZvaWQgKilwZWFrX3Jtcy0+aW5wdXRfcGVha3MraSo0LCBo
ZHNwLT5pb2Jhc2UrSERTUF85NjUyX3BlYWtCYXNlLWkqNCwgNCkgIT0gMCkKKwkJCQkJCXJldHVy
biAtRUZBVUxUOworCQkJCQlpZiAoY29weV90b191c2VyX2Zyb21pbygodm9pZCAqKXBlYWtfcm1z
LT5wbGF5YmFja19wZWFrcytpKjQsIGhkc3AtPmlvYmFzZStIRFNQXzk2NTJfcGVha0Jhc2UtKGRv
dWJsZXNwZWVkID8gMTQgOiAyNikqNC1pKjQsIDQpICE9IDApCisJCQkJCQlyZXR1cm4gLUVGQVVM
VDsKKwkJCQkJaWYgKGNvcHlfdG9fdXNlcl9mcm9taW8oKHZvaWQgKilwZWFrX3Jtcy0+b3V0cHV0
X3BlYWtzK2kqNCwgaGRzcC0+aW9iYXNlK0hEU1BfOTY1Ml9wZWFrQmFzZS0yKihkb3VibGVzcGVl
ZCA/IDE0IDogMjYpKjQtaSo0LCA0KSAhPSAwKQorCQkJCQkJcmV0dXJuIC1FRkFVTFQ7CisJCQkJ
CXJtc19sb3cgPSAqKHVuc2lnbmVkIGxvbmcgKikoaGRzcC0+aW9iYXNlK0hEU1BfOTY1Ml9ybXNC
YXNlK2kqOCkgJiAweEZGRkZGRjAwOworCQkJCQlybXNfaGlnaCA9ICoodW5zaWduZWQgbG9uZyAq
KShoZHNwLT5pb2Jhc2UrSERTUF85NjUyX3Jtc0Jhc2UraSo4KzQpICYgMHhGRkZGRkYwMDsKKwkJ
CQkJcm1zX2hpZ2ggKz0gKHJtc19sb3cgPj4gMjQpOworCQkJCQlybXNfbG93IDw8PSA4OworCQkJ
CQlpZiAoY29weV90b191c2VyKCh2b2lkICopcGVha19ybXMtPmlucHV0X3JtcytpKjgsICZybXNf
bG93LCA0KSAhPSAwKQorCQkJCQkJcmV0dXJuIC1FRkFVTFQ7CisJCQkJCWlmIChjb3B5X3RvX3Vz
ZXIoKHZvaWQgKilwZWFrX3Jtcy0+aW5wdXRfcm1zK2kqOCs0LCAmcm1zX2hpZ2gsIDQpICE9IDAp
CisJCQkJCQlyZXR1cm4gLUVGQVVMVDsJCQkJCQorCQkJCQlybXNfbG93ID0gKih1bnNpZ25lZCBs
b25nICopKGhkc3AtPmlvYmFzZStIRFNQXzk2NTJfcm1zQmFzZSsoZG91Ymxlc3BlZWQgPyAxNCA6
IDI2KSo4K2kqOCkgJiAweEZGRkZGRjAwOworCQkJCQlybXNfaGlnaCA9ICoodW5zaWduZWQgbG9u
ZyAqKShoZHNwLT5pb2Jhc2UrSERTUF85NjUyX3Jtc0Jhc2UrKGRvdWJsZXNwZWVkID8gMTQgOiAy
NikqOCtpKjgrNCkgJiAweEZGRkZGRjAwOworCQkJCQlybXNfaGlnaCArPSAocm1zX2xvdyA+PiAy
NCk7CisJCQkJCXJtc19sb3cgPDw9IDg7CisJCQkJCWlmIChjb3B5X3RvX3VzZXIoKHZvaWQgKilw
ZWFrX3Jtcy0+cGxheWJhY2tfcm1zK2kqOCwgJnJtc19sb3csIDQpICE9IDApCisJCQkJCQlyZXR1
cm4gLUVGQVVMVDsKKwkJCQkJaWYgKGNvcHlfdG9fdXNlcigodm9pZCAqKXBlYWtfcm1zLT5wbGF5
YmFja19ybXMraSo4KzQsICZybXNfaGlnaCwgNCkgIT0gMCkKKwkJCQkJCXJldHVybiAtRUZBVUxU
OwkJCQkJCisJCQkJCXJtc19sb3cgPSAqKHVuc2lnbmVkIGxvbmcgKikoaGRzcC0+aW9iYXNlK0hE
U1BfOTY1Ml9ybXNCYXNlKzIqKGRvdWJsZXNwZWVkID8gMTQgOiAyNikqOCtpKjgpICYgMHhGRkZG
RkYwMDsKKwkJCQkJcm1zX2hpZ2ggPSAqKHVuc2lnbmVkIGxvbmcgKikoaGRzcC0+aW9iYXNlK0hE
U1BfOTY1Ml9ybXNCYXNlKzIqKGRvdWJsZXNwZWVkID8gMTQgOiAyNikqOCtpKjgrNCkgJiAweEZG
RkZGRjAwOworCQkJCQlybXNfaGlnaCArPSAocm1zX2xvdyA+PiAyNCk7CisJCQkJCXJtc19sb3cg
PDw9IDg7CisJCQkJCWlmIChjb3B5X3RvX3VzZXIoKHZvaWQgKilwZWFrX3Jtcy0+b3V0cHV0X3Jt
cytpKjgsICZybXNfbG93LCA0KSAhPSAwKQorCQkJCQkJcmV0dXJuIC1FRkFVTFQ7CisJCQkJCWlm
IChjb3B5X3RvX3VzZXIoKHZvaWQgKilwZWFrX3Jtcy0+b3V0cHV0X3JtcytpKjgrNCwgJnJtc19o
aWdoLCA0KSAhPSAwKQorCQkJCQkJcmV0dXJuIC1FRkFVTFQ7CQkJCQkKKwkJCQl9CisJCQl9CisJ
CQlyZXR1cm4gMDsKIAkJfQogCQlpZiAoIShoZHNwLT5zdGF0ZSAmIEhEU1BfRmlybXdhcmVMb2Fk
ZWQpKSB7CiAJCQlzbmRfcHJpbnRrKCJmaXJtd2FyZSBuZWVkcyB0byBiZSB1cGxvYWRlZCB0byB0
aGUgY2FyZC5cbiIpOwkKQEAgLTQxMDgsNiArNDE2NSw4IEBACiAJc3Bpbl9sb2NrX2luaXQoJmhk
c3AtPm1pZGlbMV0ubG9jayk7CiAJaGRzcC0+aW9iYXNlID0gMDsKIAloZHNwLT5yZXNfcG9ydCA9
IDA7CisJaGRzcC0+Y29udHJvbF9yZWdpc3RlciA9IDA7CisJaGRzcC0+Y29udHJvbDJfcmVnaXN0
ZXIgPSAwOwogCWhkc3AtPmlvX3R5cGUgPSBVbmRlZmluZWQ7CiAJZm9yIChpID0gMDsgaSA8IEhE
U1BfTUFYX0NIQU5ORUxTOyArK2kpCiAJCWhkc3AtPnBsYXliYWNrX21peGVyX2N0bHNbaV0gPSAw
OwpAQCAtNDEyNSw2ICs0MTg0LDcgQEAKIAlzd2l0Y2ggKGhkc3AtPmZpcm13YXJlX3JldiAmIDB4
ZmYpIHsKIAljYXNlIDB4YToKIAljYXNlIDB4YjoKKwljYXNlIDB4MzI6CiAJCWhkc3AtPmNhcmRf
bmFtZSA9ICJSTUUgSGFtbWVyZmFsbCBEU1AiOwogCQlicmVhazsKIApAQCAtNDIwMCw2ICs0MjYw
LDcgQEAKIAogCWlmIChpc185NjUyKSB7CiAJICAgICAgICBoZHNwLT5pb190eXBlID0gSDk2NTI7
CisJCS8qIEZJWE1FIDogbm8gbW9yZSBuZWVkZWQgaGVyZSAqLwogCSAgICAgICAgc25kX2hkc3Bf
OTY1Ml9lbmFibGVfbWl4ZXIgKGhkc3ApOwogCX0KIAo=

------=_20030827133926_54689--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
