From: "Matthew Flint" <mkflint@gmail.com>
Subject: Re: Patches for Packard Bell EasyNote laptop support
Date: Thu, 8 Feb 2007 20:13:16 +0000
Message-ID: <a330ebc0702081213x2fbb2d0bv15cfdb1d5485a16f@mail.gmail.com>
References: <a330ebc0702070724u4b82ca8cic8118fde6fbffc22@mail.gmail.com>
	<s5h8xfaue1f.wl%tiwai@suse.de> <s5h64advr95.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12037_25201350.1170965596102"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h64advr95.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_12037_25201350.1170965596102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> OK, I took a look a bit more, and wrote a patch for testing.
> Could you check whether the patch below works with the latest ALSA
> tree?  You can get the latest tree from
>         ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/

Takashi,

Thank-you for your efforts - but I didn't know which snapshot version
your patch was for.

I've created a patch which works OK against snapshot
"alsa-driver-hg20070208.tar.bz2" (see attached file). Files patched
are in directory alsa-kernel/

Matthew

------=_Part_12037_25201350.1170965596102
Content-Type: application/octet-stream; name=easynote-a8208-ac97patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_exxmn3sa
Content-Disposition: attachment; filename="easynote-a8208-ac97patch"

ZGlmZiAtTmF1ciBhL3BjaS9hYzk3L2FjOTdfY29kZWMuYyBiL3BjaS9hYzk3L2FjOTdfY29kZWMu
YwotLS0gYS9wY2kvYWM5Ny9hYzk3X2NvZGVjLmMJMjAwNy0wMi0wMSAwMTowMDoxNy4wMDAwMDAw
MDAgKzAwMDAKKysrIGIvcGNpL2FjOTcvYWM5N19jb2RlYy5jCTIwMDctMDItMDggMTk6NTQ6NDEu
MDAwMDAwMDAwICswMDAwCkBAIC0xNDMsNiArMTQzLDcgQEAKIHsgMHg0MzUyNTk3MCwgMHhmZmZm
ZmZmOCwgIkNTNDIwMiIsCQlOVUxMLAkJTlVMTCB9LAogeyAweDQzNTg1NDIxLCAweGZmZmZmZmZm
LCAiSFNEMTEyNDYiLAkJTlVMTCwJCU5VTEwgfSwJLy8gU21hcnRNQyBJSQogeyAweDQzNTg1NDI4
LCAweGZmZmZmZmY4LCAiQ3gyMDQ2OCIsCQlwYXRjaF9jb25leGFudCwJTlVMTCB9LCAvLyBTbWFy
dEFNQyBmaXhtZTogdGhlIG1hc2sgbWlnaHQgYmUgZGlmZmVyZW50Cit7IDB4NDM1ODU0MzEsIDB4
ZmZmZmZmZmYsICJDeDIwNTUxIiwgICAgICAgICAgIHBhdGNoX2N4MjA1NTEsICBOVUxMIH0sCiB7
IDB4NDQ1NDMwMzEsIDB4ZmZmZmZmZjAsICJEVDAzOTgiLAkJTlVMTCwJCU5VTEwgfSwKIHsgMHg0
NTRkNDMyOCwgMHhmZmZmZmZmZiwgIkVNMjgwMjgiLAkJTlVMTCwJCU5VTEwgfSwgIC8vIHNhbWUg
YXMgVFIyODAyOD8KIHsgMHg0NTgzODMwOCwgMHhmZmZmZmZmZiwgIkVTUzE5ODgiLAkJTlVMTCwJ
CU5VTEwgfSwKZGlmZiAtTmF1ciBhL3BjaS9hYzk3L2FjOTdfcGF0Y2guYyBiL3BjaS9hYzk3L2Fj
OTdfcGF0Y2guYwotLS0gYS9wY2kvYWM5Ny9hYzk3X3BhdGNoLmMJMjAwNy0wMS0zMCAwMTowMDoy
NC4wMDAwMDAwMDAgKzAwMDAKKysrIGIvcGNpL2FjOTcvYWM5N19wYXRjaC5jCTIwMDctMDItMDgg
MTk6NTY6MDMuMDAwMDAwMDAwICswMDAwCkBAIC0xMzM4LDYgKzEzMzgsMTIgQEAKIAlyZXR1cm4g
MDsKIH0KIAoraW50IHBhdGNoX2N4MjA1NTEoc3RydWN0IHNuZF9hYzk3ICphYzk3KQoreworCXNu
ZF9hYzk3X3VwZGF0ZV9iaXRzKGFjOTcsIDB4NWMsIDB4MDEsIDB4MDEpOworCXJldHVybiAwOwor
fQorCiAvKgogICogQW5hbG9nIERldmljZSBBRDE4eHgsIEFEMTl4eCBjb2RlY3MKICAqLwpkaWZm
IC1OYXVyIGEvcGNpL2FjOTcvYWM5N19wYXRjaC5oIGIvcGNpL2FjOTcvYWM5N19wYXRjaC5oCi0t
LSBhL3BjaS9hYzk3L2FjOTdfcGF0Y2guaAkyMDA2LTEyLTIzIDAxOjAwOjIwLjAwMDAwMDAwMCAr
MDAwMAorKysgYi9wY2kvYWM5Ny9hYzk3X3BhdGNoLmgJMjAwNy0wMi0wOCAxOTo1NjoyOC4wMDAw
MDAwMDAgKzAwMDAKQEAgLTM5LDYgKzM5LDcgQEAKIGludCBwYXRjaF9jaXJydXNfY3M0Mjk5KHN0
cnVjdCBzbmRfYWM5NyAqIGFjOTcpOwogaW50IHBhdGNoX2NpcnJ1c19zcGRpZihzdHJ1Y3Qgc25k
X2FjOTcgKiBhYzk3KTsKIGludCBwYXRjaF9jb25leGFudChzdHJ1Y3Qgc25kX2FjOTcgKiBhYzk3
KTsKK2ludCBwYXRjaF9jeDIwNTUxKHN0cnVjdCBzbmRfYWM5NyAqIGFjOTcpOwogaW50IHBhdGNo
X2FkMTgxOShzdHJ1Y3Qgc25kX2FjOTcgKiBhYzk3KTsKIGludCBwYXRjaF9hZDE4ODEoc3RydWN0
IHNuZF9hYzk3ICogYWM5Nyk7CiBpbnQgcGF0Y2hfYWQxODg1KHN0cnVjdCBzbmRfYWM5NyAqIGFj
OTcpOwo=
------=_Part_12037_25201350.1170965596102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_12037_25201350.1170965596102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_12037_25201350.1170965596102--
