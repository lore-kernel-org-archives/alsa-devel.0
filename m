From: "David Hubbard" <david.c.hubbard@gmail.com>
Subject: Re: Edirol UA-4FX
Date: Wed, 28 Nov 2007 12:23:32 -0700
Message-ID: <4dfa50520711281123o4ea74babra50f0a09330bb359@mail.gmail.com>
References: <4dfa50520711281050v4a710af5q11644b0cf7dd10c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6835_18713492.1196277812076"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E38124B70
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 20:23:33 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1971186wag
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 11:23:32 -0800 (PST)
In-Reply-To: <4dfa50520711281050v4a710af5q11644b0cf7dd10c1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

------=_Part_6835_18713492.1196277812076
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Luis, and Alsa list,

I recently got an Edirol UA-4FX. It works just fine as a generic USB
Audio device. I've written up all the details at
http://alsa.opensrc.org/index.php/Edirol_UA-4FX (shamelessly stolen
from the Edirol_UA-25 page).

The the UA-4FX needs a patch to usbaudio.c create_ua700_ua25_quirk()
and usbquirks.h, and then it has full support. (MIDI I/O, sample rates
up to 96 kHz) I've made an attempt, mostly to get it working on my
machine. Can you review it?

Thanks,
David

------=_Part_6835_18713492.1196277812076
Content-Type: text/plain; name=ua4fx.patch.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9k7ku6j0
Content-Disposition: attachment; filename=ua4fx.patch.txt

QWRkIEFsc2Egc3VwcG9ydCBmb3IgUm9sYW5kIEVkaXJvbCBVQS00RlggaW4gQWR2YW5jZWQgbW9k
ZQooZm9yIE1JREkgc3VwcG9ydCBhbmQgc2FtcGxlIHJhdGVzIG9mIDQ4IGtIeiBhbmQgOTYga0h6
KQp1c2JhdWRpby5jLCB1c2JxdWlya3MuaApTaWduZWQtb2ZmLWJ5OiBkYXZpZC5jLmh1YmJhcmRA
Z21haWwuY29tCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KZGlmZiAtdSBzb3VuZC91c2IvdXNiYXVkaW8uYy4wMCBzb3Vu
ZC91c2IvdXNiYXVkaW8uYwotLS0gc291bmQvdXNiL3VzYmF1ZGlvLmMuMDAJMjAwNy0xMS0yOCAw
MjoxMzoxMC4wMDAwMDAwMDAgLTA3MDAKKysrIHNvdW5kL3VzYi91c2JhdWRpby5jCTIwMDctMTEt
MjggMDI6NDQ6NDcuMDAwMDAwMDAwIC0wNzAwCkBAIC0yOTMwLDcgKzI5MzAsNyBAQAogfQogCiAv
KgotICogQ3JlYXRlIGEgc3RyZWFtIGZvciBhbiBFZGlyb2wgVUEtNzAwL1VBLTI1IGludGVyZmFj
ZS4gIFRoZSBvbmx5IHdheQorICogQ3JlYXRlIGEgc3RyZWFtIGZvciBhbiBFZGlyb2wgVUEtNzAw
L1VBLTI1L1VBLTRGWCBpbnRlcmZhY2UuICBUaGUgb25seSB3YXkKICAqIHRvIGRldGVjdCB0aGUg
c2FtcGxlIHJhdGUgaXMgYnkgbG9va2luZyBhdCB3TWF4UGFja2V0U2l6ZS4KICAqLwogc3RhdGlj
IGludCBjcmVhdGVfdWE3MDBfdWEyNV9xdWlyayhzdHJ1Y3Qgc25kX3VzYl9hdWRpbyAqY2hpcCwK
QEAgLTI5NTAsOCArMjk1MCwxMSBAQAogCXN0cnVjdCBhdWRpb2Zvcm1hdCAqZnA7CiAJaW50IHN0
cmVhbSwgZXJyOwogCi0JLyogYm90aCBQQ00gYW5kIE1JREkgaW50ZXJmYWNlcyBoYXZlIDIgYWx0
c2V0dGluZ3MgKi8KLQlpZiAoaWZhY2UtPm51bV9hbHRzZXR0aW5nICE9IDIpCisJLyogYm90aCBQ
Q00gYW5kIE1JREkgaW50ZXJmYWNlcyBoYXZlIDIgYWx0c2V0dGluZ3MsCisJICogZXhjZXB0IFVB
LTRGWCBhdCA0OCBrSHosIFBDTSBpbnRlcmZhY2UgaGFzIDMgYWx0c2V0dGluZ3MgKi8KKwlpZiAo
aWZhY2UtPm51bV9hbHRzZXR0aW5nICE9IDIgJiYKKwkJKGNoaXAtPnVzYl9pZCAhPSBVU0JfSUQo
MHgwNTgyLCAweDAwYTMpIHx8CisJCQlpZmFjZS0+bnVtX2FsdHNldHRpbmcgIT0gMykpCiAJCXJl
dHVybiAtRU5YSU87CiAJYWx0cyA9ICZpZmFjZS0+YWx0c2V0dGluZ1sxXTsKIAlhbHRzZCA9IGdl
dF9pZmFjZV9kZXNjKGFsdHMpOwpkaWZmIC11IHNvdW5kL3VzYi91c2JxdWlya3MuaC4wMCBzb3Vu
ZC91c2IvdXNicXVpcmtzLmgKLS0tIHNvdW5kL3VzYi91c2JxdWlya3MuaC4wMAkyMDA3LTExLTI4
IDAyOjE1OjExLjAwMDAwMDAwMCAtMDcwMAorKysgc291bmQvdXNiL3VzYnF1aXJrcy5oCTIwMDct
MTEtMjggMDI6MTc6NTEuMDAwMDAwMDAwIC0wNzAwCkBAIC0xMzExLDYgKzEzMTEsMzcgQEAKIAl9
CiB9LAogCS8qIFRPRE86IGFkZCBFZGlyb2wgTUQtUDEgc3VwcG9ydCAqLworewkvKgorCSAqIFRo
aXMgcXVpcmsgaXMgZm9yIHRoZSAiQWR2YW5jZWQiIG1vZGVzIG9mIHRoZSBFZGlyb2wgVUEtNEZY
LgorCSAqIElmIHRoZSBzd2l0Y2ggaXMgbm90IGluIGFuIGFkdmFuY2VkIHNldHRpbmcsIHRoZSBV
QS00RlggaGFzCisJICogSUQgMHgwNTgyLzB4MDBhNCBhbmQgaXMgc3RhbmRhcmQgY29tcGxpYW50
IChubyBxdWlya3MpLCBidXQKKwkgKiBvZmZlcnMgb25seSAxNi1iaXQgUENNIGF0IDQ0LjEga0h6
IGFuZCBubyBNSURJLgorCSAqLworCVVTQl9ERVZJQ0VfVkVORE9SX1NQRUMoMHgwNTgyLCAweDAw
YTMpLAorCS5kcml2ZXJfaW5mbyA9ICh1bnNpZ25lZCBsb25nKSAmIChjb25zdCBzdHJ1Y3Qgc25k
X3VzYl9hdWRpb19xdWlyaykgeworCQkudmVuZG9yX25hbWUgPSAiRURJUk9MIiwKKwkJLnByb2R1
Y3RfbmFtZSA9ICJVQS00RlgiLAorCQkuaWZudW0gPSBRVUlSS19BTllfSU5URVJGQUNFLAorCQku
dHlwZSA9IFFVSVJLX0NPTVBPU0lURSwKKwkJLmRhdGEgPSAoY29uc3Qgc3RydWN0IHNuZF91c2Jf
YXVkaW9fcXVpcmtbXSkgeworCQkJeworCQkJCS5pZm51bSA9IDAsCisJCQkJLnR5cGUgPSBRVUlS
S19BVURJT19FRElST0xfVUE3MDBfVUEyNQorCQkJfSwKKwkJCXsKKwkJCQkuaWZudW0gPSAxLAor
CQkJCS50eXBlID0gUVVJUktfQVVESU9fRURJUk9MX1VBNzAwX1VBMjUKKwkJCX0sCisJCQl7CisJ
CQkJLmlmbnVtID0gMiwKKwkJCQkudHlwZSA9IFFVSVJLX0FVRElPX0VESVJPTF9VQTcwMF9VQTI1
CisJCQl9LAorCQkJeworCQkJCS5pZm51bSA9IC0xCisJCQl9CisJCX0KKwl9Cit9LAogewogCS8q
IFJvbGFuZCBTSC0yMDEgKi8KIAlVU0JfREVWSUNFKDB4MDU4MiwgMHgwMGFkKSwK
------=_Part_6835_18713492.1196277812076
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_6835_18713492.1196277812076--
