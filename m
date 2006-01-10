From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Support for EDIROL UM-3ex
Date: Tue, 10 Jan 2006 15:29:14 +0100
Message-ID: <1136903354.43c3c4ba5738a@webmail.uni-halle.de>
References: <200512312154.35173.busterbcook@yahoo.com>
 <s5hmzi5h2s4.wl%tiwai@suse.de> <200601100734.33174.busterbcook@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_zyH2UfoJf7RdBbPSdCPYGQ)"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200601100734.33174.busterbcook@yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brent Cook <busterbcook@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This message is in MIME format.

--Boundary_(ID_zyH2UfoJf7RdBbPSdCPYGQ)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

Brent Cook wrote:
> On Monday 09 January 2006 08:52, Takashi Iwai wrote:
> > Could you regenerate a patch for Linus' latest git tree (also together
> > with Signed-off-by line) ?
>
> Here you go.

I usually try to keep the product IDs sorted, and a composite quirk isn't
needed for devices with only one interface.  And I added your Signed-off-by
line.  Would the patch below be OK?


Clemens

==========

Subject: Support for EDIROL UM-3EX

This is my naive attempt at adding ALSA device support. The attached
patch provides support for the EDIROL UM-3ex. This is a 3-port USB midi
interface with a built-in USB hub and the ability to chain 2 other
UM-3x's in a master-slave configuration. I only have one, so I do not
know how this works in practice.

Signed-off-by: Brent Cook <busterbcook@yahoo.com>

--Boundary_(ID_zyH2UfoJf7RdBbPSdCPYGQ)
Content-type: application/octet-stream; name=um3ex.patch
Content-transfer-encoding: BASE64
Content-disposition: attachment; filename=um3ex.patch

SW5kZXg6IGFsc2Eta2VybmVsL3VzYi91c2JtaWRpLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYWxzYS9hbHNhLWtlcm5lbC91c2IvdXNi
bWlkaS5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjYxCmRpZmYgLXUgLXIxLjYx
IHVzYm1pZGkuYwotLS0gYWxzYS1rZXJuZWwvdXNiL3VzYm1pZGkuYwkxNyBOb3Yg
MjAwNSAxNTowODowMiAtMDAwMAkxLjYxCisrKyBhbHNhLWtlcm5lbC91c2IvdXNi
bWlkaS5jCTEwIEphbiAyMDA2IDE0OjE1OjM1IC0wMDAwCkBAIC0xMDgyLDYgKzEw
ODIsOCBAQAogCXsgVVNCX0lEKDB4MDU4MiwgMHgwMDRkKSwgMCwgIiVzIE1JREki
IH0sCiAJeyBVU0JfSUQoMHgwNTgyLCAweDAwNGQpLCAxLCAiJXMgMSIgfSwKIAl7
IFVTQl9JRCgweDA1ODIsIDB4MDA0ZCksIDIsICIlcyAyIiB9LAorCS8qIEVkaXJv
bCBVTS0zRVggKi8KKwl7IFVTQl9JRCgweDA1ODIsIDB4MDA5YSksIDMsICIlcyBD
b250cm9sIiB9LAogCS8qIE0tQXVkaW8gTWlkaVNwb3J0IDh4OCAqLwogCXsgVVNC
X0lEKDB4MDc2MywgMHgxMDMxKSwgOCwgIiVzIENvbnRyb2wiIH0sCiAJeyBVU0Jf
SUQoMHgwNzYzLCAweDEwMzMpLCA4LCAiJXMgQ29udHJvbCIgfSwKSW5kZXg6IGFs
c2Eta2VybmVsL3VzYi91c2JxdWlya3MuaAo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJD
UyBmaWxlOiAvY3Zzcm9vdC9hbHNhL2Fsc2Eta2VybmVsL3VzYi91c2JxdWlya3Mu
aCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS41OApkaWZmIC11IC1yMS41OCB1c2Jx
dWlya3MuaAotLS0gYWxzYS1rZXJuZWwvdXNiL3VzYnF1aXJrcy5oCTIxIE5vdiAy
MDA1IDE2OjQwOjAwIC0wMDAwCTEuNTgKKysrIGFsc2Eta2VybmVsL3VzYi91c2Jx
dWlya3MuaAkxMCBKYW4gMjAwNiAxNDoxNTozNSAtMDAwMApAQCAtMTA5MCw2ICsx
MDkwLDE5IEBACiAJCX0KIAl9CiB9LAoreworCVVTQl9ERVZJQ0UoMHgwNTgyLCAw
eDAwOWEpLAorCS5kcml2ZXJfaW5mbyA9ICh1bnNpZ25lZCBsb25nKSAmIChjb25z
dCBzdHJ1Y3Qgc25kX3VzYl9hdWRpb19xdWlyaykgeworCQkudmVuZG9yX25hbWUg
PSAiRURJUk9MIiwKKwkJLnByb2R1Y3RfbmFtZSA9ICJVTS0zRVgiLAorCQkuaWZu
dW0gPSAwLAorCQkudHlwZSA9IFFVSVJLX01JRElfRklYRURfRU5EUE9JTlQsCisJ
CS5kYXRhID0gJiAoY29uc3Qgc3RydWN0IHNuZF91c2JfbWlkaV9lbmRwb2ludF9p
bmZvKSB7CisJCQkub3V0X2NhYmxlcyA9IDB4MDAwZiwKKwkJCS5pbl9jYWJsZXMg
ID0gMHgwMDBmCisJCX0KKwl9Cit9LAogCiAvKiBHdWlsbGVtb3QgZGV2aWNlcyAq
LwogewpAQCAtMTExOCw3ICsxMTMxLDYgQEAKIAkvKiBUT0RPOiBhZGQgRWRpcm9s
IFBDLTUwIHN1cHBvcnQgKi8KIAkvKiBUT0RPOiBhZGQgRWRpcm9sIFBDLTgwIHN1
cHBvcnQgKi8KIAkvKiBUT0RPOiBhZGQgRWRpcm9sIFVBLTFFWCBzdXBwb3J0ICov
Ci0JLyogVE9ETzogYWRkIEVkaXJvbCBVTS0zIHN1cHBvcnQgKi8KIAkvKiBUT0RP
OiBhZGQgRWRpcm9sIE1ELVAxIHN1cHBvcnQgKi8KIAogLyogTWlkaW1hbi9NLUF1
ZGlvIGRldmljZXMgKi8K

--Boundary_(ID_zyH2UfoJf7RdBbPSdCPYGQ)--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
