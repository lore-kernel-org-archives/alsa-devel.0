From: "Richard Fish" <bigfish@asmallpond.org>
Subject: [PATCH]: enable subwoofer on some laptops
Date: Tue, 5 Sep 2006 18:46:16 -0700
Message-ID: <7573e9640609051846v6e0c7d37hb0d7543bd8674201@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_141959_5457495.1157507176180"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_141959_5457495.1157507176180
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

On my Dell Inspiron e1705 with a Sigmatel stac9200, there is a
"subwoofer" that is attached to a separate speaker pin widget.  The
"Master" control only controls the 4 main speakers.

This patch should enable the subwoofer on similarly equipped laptops,
by creating the LFE mixer controls, although at present it is coded to
be very specific to the 9200.

It assumes that the first mono speaker pin with an amp is the
subwoofer, and I assume that no stac9200 implementation in the world
has both a Center/LFE line out _and_ an LFE speaker attached.  Since
the 9200 is only a 2-channel codec to begin with, this seems
reasonable, but I've probably made other potentially incorrect
assumptions, so please review carefully.

One problem with this patch, even if it works as intended, is that it
doesn't provide a very satisfying end-user experience, at least for
e1705 owners.  The problem is that the LFE pin is almost completely
independant of the Master control, so to change the volume the user
must operate both controls, which will likely throw the audio balance
off.  This can be avoided by using the PCM control, but PCM has no
mute switch.  And muting Master does not mute LFE, although setting
Master to 0 does mute LFE.

So I have another version of this patch that implements the actual LFE
channel volume as a function of the master and LFE volumes.  It is
really, really fugly, but at least it provides nice behavior for the
user!  It feels wrong to implement that kind of thing in the lowest
levels of the driver, but without a plugin mixer API (which I have no
clue where to start on that effort!), I don't see any other option.

Since the alternative is so fugly, I am holding that back for now,
even though it is what I intend to use on my system.  But if you are
at all interested in it, let me know and I'll clean it up a bit and
submit it.

I'm not sure whether it was Sigmatel or (more likely) Dell who screwed
this up so badly, but somebody should take a beating over this.

-Richard

------=_Part_141959_5457495.1157507176180
Content-Type: application/octet-stream; name=rjf-alsa-20060905.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_err1qong
Content-Disposition: attachment; filename="rjf-alsa-20060905.patch"

W3NuZC1pbnRlbC1oZGFdIGVuYWJsZSBjZW50ZXIvTEZFIHNwZWFrZXIgb24gc29tZSBsYXB0b3Bz
CgpUaGlzIHBhdGNoIGFkZHMgTEZFIG1peGVyIGNvbnRyb2xzIGZvciBsYXB0b3BzIHdpdGggYSBz
dGFjOTIwMCBhbmQgYSBtb25vCnNwZWFrZXIgcGluIHdpdGggYW1wbGlmaWVyLgoKU2lnbmVkLW9m
Zi1ieTogUmljaGFyZCBGaXNoIDxiaWdmaXNoQGFzbWFsbHBvbmQub3JnPgoKLS0tIGFsc2Eta2Vy
bmVsL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYy5vcmlnCTIwMDYtMDktMDEgMTM6MDA6MDMuMDAw
MDAwMDAwIC0wNzAwCisrKyBhbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMJMjAw
Ni0wOS0wNSAxNDo1NTowNS4yOTcwMDM2OTIgLTA3MDAKQEAgLTEyMjMsNiArMTIyMyw1NiBAQAog
CXJldHVybiAwOwogfQogCisvKiBhZGQgcGxheWJhY2sgY29udHJvbHMgZm9yIExGRSBvdXRwdXQg
Ki8KK3N0YXRpYyBpbnQgc3RhYzkyMDBfYXV0b19jcmVhdGVfbGZlX2N0bHMoc3RydWN0IGhkYV9j
b2RlYyAqY29kZWMsCisJCQkJCXN0cnVjdCBhdXRvX3Bpbl9jZmcgKmNmZykKK3sKKwlzdHJ1Y3Qg
c2lnbWF0ZWxfc3BlYyAqc3BlYyA9IGNvZGVjLT5zcGVjOworCWludCBlcnI7CisJaGRhX25pZF90
IGxmZV9waW4gPSAweDA7CisJaW50IGk7CisKKwkvKgorCSAqIHNlYXJjaCBzcGVha2VyIG91dHMg
YW5kIGxpbmUgb3V0cyBmb3IgYSBtb25vIHNwZWFrZXIgcGluCisJICogd2l0aCBhbiBhbXAuICBJ
ZiBvbmUgaXMgZm91bmQsIGFkZCBMRkUgY29udHJvbHMKKwkgKiBmb3IgaXQuCisJICovCisJZm9y
IChpID0gMDsgaSA8IHNwZWMtPmF1dG9jZmcuc3BlYWtlcl9vdXRzICYmIGxmZV9waW4gPT0gMHgw
OyBpKyspIHsKKwkJaGRhX25pZF90IHBpbiA9IHNwZWMtPmF1dG9jZmcuc3BlYWtlcl9waW5zW2ld
OworCQl1bnNpZ25lZCBsb25nIHdjYXBzID0gZ2V0X3djYXBzKGNvZGVjLCBwaW4pOworCQl3Y2Fw
cyAmPSAoQUNfV0NBUF9TVEVSRU8gfCBBQ19XQ0FQX09VVF9BTVApOworCQlpZiAod2NhcHMgPT0g
QUNfV0NBUF9PVVRfQU1QKSB7CisJCQlsZmVfcGluID0gcGluOyAvKiBmb3VuZCBhIG1vbm8gc3Bl
YWtlciB3aXRoIGFuIGFtcCwgbXVzdCBiZSBsZmUgKi8KKwkJfQorCX0KKworCS8qIGlmIHNwZWFr
ZXJfb3V0cyBpcyAwLCB0aGVuIHNwZWFrZXJzIG1heSBiZSBpbiBsaW5lX291dHMgKi8KKwlpZiAo
bGZlX3BpbiA9PSAwICYmIHNwZWMtPmF1dG9jZmcuc3BlYWtlcl9vdXRzID09IDApIHsKKwkJZm9y
IChpID0gMDsgaSA8IHNwZWMtPmF1dG9jZmcubGluZV9vdXRzICYmIGxmZV9waW4gPT0gMHgwOyBp
KyspIHsKKwkJCWhkYV9uaWRfdCBwaW4gPSBzcGVjLT5hdXRvY2ZnLmxpbmVfb3V0X3BpbnNbaV07
CisJCQl1bnNpZ25lZCBsb25nIGNmZyA9IHNuZF9oZGFfY29kZWNfcmVhZChjb2RlYywgcGluLCAw
LCBBQ19WRVJCX0dFVF9DT05GSUdfREVGQVVMVCwgMHgwMCk7CisJCQlpZiAoZ2V0X2RlZmNmZ19k
ZXZpY2UoY2ZnKSA9PSBBQ19KQUNLX1NQRUFLRVIpIHsKKwkJCQl1bnNpZ25lZCBsb25nIHdjYXBz
ID0gZ2V0X3djYXBzKGNvZGVjLCBwaW4pOworCQkJCXdjYXBzICY9IChBQ19XQ0FQX1NURVJFTyB8
IEFDX1dDQVBfT1VUX0FNUCk7CisJCQkJaWYgKHdjYXBzID09IEFDX1dDQVBfT1VUX0FNUCkgewor
CQkJCQlsZmVfcGluID0gcGluOyAvKiBmb3VuZCBhIG1vbm8gc3BlYWtlciB3aXRoIGFuIGFtcCwg
bXVzdCBiZSBsZmUgKi8KKwkJCQl9CisJCQl9CisJCX0KKwl9CisKKwlpZiAobGZlX3Bpbikgewor
CQlpZiAoKGVyciA9IHN0YWM5Mnh4X2FkZF9jb250cm9sKHNwZWMsIFNUQUNfQ1RMX1dJREdFVF9W
T0wsICJMRkUgUGxheWJhY2sgVm9sdW1lIiwKKwkJCQlIREFfQ09NUE9TRV9BTVBfVkFMKGxmZV9w
aW4sIDEsIDAsIEhEQV9PVVRQVVQpKSkgPCAwKQorCQkJcmV0dXJuIGVycjsKKwkJaWYgKChlcnIg
PSBzdGFjOTJ4eF9hZGRfY29udHJvbChzcGVjLCBTVEFDX0NUTF9XSURHRVRfTVVURSwgIkxGRSBQ
bGF5YmFjayBTd2l0Y2giLAorCQkJCUhEQV9DT01QT1NFX0FNUF9WQUwobGZlX3BpbiwgMSwgMCwg
SERBX09VVFBVVCkpKSA8IDApCisJCQlyZXR1cm4gZXJyOworCX0KKworCXJldHVybiAwOworfQor
CiBzdGF0aWMgaW50IHN0YWM5MjAwX3BhcnNlX2F1dG9fY29uZmlnKHN0cnVjdCBoZGFfY29kZWMg
KmNvZGVjKQogewogCXN0cnVjdCBzaWdtYXRlbF9zcGVjICpzcGVjID0gY29kZWMtPnNwZWM7CkBA
IC0xMjM3LDYgKzEyODcsOSBAQAogCWlmICgoZXJyID0gc3RhYzkyMDBfYXV0b19jcmVhdGVfaHBf
Y3Rscyhjb2RlYywgJnNwZWMtPmF1dG9jZmcpKSA8IDApCiAJCXJldHVybiBlcnI7CiAKKwlpZiAo
KGVyciA9IHN0YWM5MjAwX2F1dG9fY3JlYXRlX2xmZV9jdGxzKGNvZGVjLCAmc3BlYy0+YXV0b2Nm
ZykpIDwgMCkKKwkJcmV0dXJuIGVycjsKKwogCWlmIChzcGVjLT5hdXRvY2ZnLmRpZ19vdXRfcGlu
KQogCQlzcGVjLT5tdWx0aW91dC5kaWdfb3V0X25pZCA9IDB4MDU7CiAJaWYgKHNwZWMtPmF1dG9j
ZmcuZGlnX2luX3BpbikK
------=_Part_141959_5457495.1157507176180
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_141959_5457495.1157507176180
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_141959_5457495.1157507176180--
