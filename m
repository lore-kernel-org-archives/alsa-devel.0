From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 15:44:44 +0200
Message-ID: <CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name> <4E537524.9010303@ladisch.de>
	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name>
	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>
	<4E53A748.4070404@amlie.name>
	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>
	<4E53AAE4.2070303@amlie.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd32cfaf88cc204ab2c6547
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id A7536103A0F
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 15:44:45 +0200 (CEST)
Received: by pzk1 with SMTP id 1so185618pzk.2
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2011 06:44:44 -0700 (PDT)
In-Reply-To: <4E53AAE4.2070303@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

--000e0cd32cfaf88cc204ab2c6547
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Aug 23, 2011 at 3:28 PM, Kristian Amlie <kristian@amlie.name> wrote:
> On 08/23/11 15:16, Daniel Mack wrote:
>> On Tue, Aug 23, 2011 at 3:12 PM, Kristian Amlie <kristian@amlie.name> wrote:
>>> Here is the output from one complete run of cu, including connecting,
>>> pressing a key once on the instrument and killing cu afterwards:
>> ...
>> And now once again without killing cu, please. I'm interested in the
>> last commands that occur before the device starts working.
>
> Here you go:
>
> [21535.096008] change_speed(): urb_value: 16696, urb_index: 0
> [21535.097918] update_mctrl(): urb_value: 771, priv->interface: 0
> [21535.099917] change_speed(): urb_value: 49230, urb_index: 0
> [21535.103055] change_speed(): urb_value: 49230, urb_index: 0
> [21535.106037] change_speed(): urb_value: 49230, urb_index: 0

Ok, then let's try the attached patch. In case it doesn't work, you
might need to check whether there are any more ctrl requests sent by
the fdti_sio driver that need to be added to the MIDI driver as well.


Daniel

--000e0cd32cfaf88cc204ab2c6547
Content-Type: text/x-patch; charset=US-ASCII; name="starr-labs-midi.diff"
Content-Disposition: attachment; filename="starr-labs-midi.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_groxeq9g0

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9taWRpLmMgYi9zb3VuZC91c2IvbWlkaS5jCmluZGV4IGY5
Mjg5MTAuLjJjNDA4NzMgMTAwNjQ0Ci0tLSBhL3NvdW5kL3VzYi9taWRpLmMKKysrIGIvc291bmQv
dXNiL21pZGkuYwpAQCAtMjA3Myw2ICsyMDczLDEzIEBAIHZvaWQgc25kX3VzYm1pZGlfaW5wdXRf
c3RhcnQoc3RydWN0IGxpc3RfaGVhZCogcCkKIAkJc25kX3VzYm1pZGlfaW5wdXRfc3RhcnRfZXAo
dW1pZGktPmVuZHBvaW50c1tpXS5pbik7CiB9CiAKK3N0YXRpYyBpbnQgc25kX3VzYm1pZGlfZnRk
aV9jb21tYW5kKHN0cnVjdCBzbmRfdXNiX21pZGkgKnVtaWRpLAorCQkJCSAgICB1OCBjb21tYW5k
LCB1MTYgdmFsdWUpCit7CisJcmV0dXJuIHVzYl9jb250cm9sX21zZyh1bWlkaS0+ZGV2LCB1c2Jf
c25kY3RybHBpcGUodW1pZGktPmRldiwgMCksCisJCQkJY29tbWFuZCwgMHg0MCwgdmFsdWUsIDAs
IE5VTEwsIDAsIDEwMDApOworfQorCiAvKgogICogQ3JlYXRlcyBhbmQgcmVnaXN0ZXJzIGV2ZXJ5
dGhpbmcgbmVlZGVkIGZvciBhIE1JREkgc3RyZWFtaW5nIGludGVyZmFjZS4KICAqLwpAQCAtMjE2
Myw2ICsyMTcwLDI0IEBAIGludCBzbmRfdXNibWlkaV9jcmVhdGUoc3RydWN0IHNuZF9jYXJkICpj
YXJkLAogCQkvKiBlbmRwb2ludCAxIGlzIGlucHV0LW9ubHkgKi8KIAkJZW5kcG9pbnRzWzFdLm91
dF9jYWJsZXMgPSAwOwogCQlicmVhazsKKwljYXNlIFFVSVJLX01JRElfRlRESToKKwkJLyogcmVz
ZXQgdGhlIHBvcnQgKi8KKwkJZXJyID0gc25kX3VzYm1pZGlfZnRkaV9jb21tYW5kKHVtaWRpLCAw
LCAwKTsKKwkJaWYgKGVyciA8IDApCisJCQlicmVhazsKKworCQkvKiBzZXQgbWN0cmwgKi8KKwkJ
ZXJyID0gc25kX3VzYm1pZGlfZnRkaV9jb21tYW5kKHVtaWRpLCAxLCAweDMwMyk7CisJCWlmIChl
cnIgPCAwKQorCQkJYnJlYWs7CisKKwkJLyogc2V0IGJhdWQgcmF0ZSAqLworCQllcnIgPSBzbmRf
dXNibWlkaV9mdGRpX2NvbW1hbmQodW1pZGksIDMsIDB4YzA0ZSk7CisJCWlmIChlcnIgPCAwKQor
CQkJYnJlYWs7CisKKwkJZXJyID0gc25kX3VzYm1pZGlfZGV0ZWN0X3Blcl9wb3J0X2VuZHBvaW50
cyh1bWlkaSwgZW5kcG9pbnRzKTsKKwkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJc25kX3ByaW50ZChL
RVJOX0VSUiAiaW52YWxpZCBxdWlyayB0eXBlICVkXG4iLCBxdWlyay0+dHlwZSk7CiAJCWVyciA9
IC1FTlhJTzsKZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3MtdGFibGUuaCBiL3NvdW5kL3Vz
Yi9xdWlya3MtdGFibGUuaAppbmRleCBhNDJlM2VmLi42YzIyM2U4IDEwMDY0NAotLS0gYS9zb3Vu
ZC91c2IvcXVpcmtzLXRhYmxlLmgKKysrIGIvc291bmQvdXNiL3F1aXJrcy10YWJsZS5oCkBAIC0z
OSw2ICszOSwxNiBAQAogCS5pZFByb2R1Y3QgPSBwcm9kLCBcCiAJLmJJbnRlcmZhY2VDbGFzcyA9
IFVTQl9DTEFTU19WRU5ET1JfU1BFQwogCisvKiBTdGFyciBMYWJzIE1JREkgVVNCIGRldmljZSAq
LworeworCVVTQl9ERVZJQ0UoMHgwNDAzLCAweGI4ZDgpLAorCS5kcml2ZXJfaW5mbyA9ICh1bnNp
Z25lZCBsb25nKSAmIChjb25zdCBzdHJ1Y3Qgc25kX3VzYl9hdWRpb19xdWlyaykgeworCQkvKiAu
dmVuZG9yX25hbWUgPSAiU1RBUlIgTEFCUyIsICovCisJCS8qIC5wcm9kdWN0X25hbWUgPSAiU3Rh
cnIgTGFicyBNSURJIFVTQiBkZXZpY2UiLCAqLworCQkuaWZudW0gPSAwLAorCQkudHlwZSA9IFFV
SVJLX01JRElfRlRESQorCX0KK30sCiAvKiBDcmVhdGl2ZS9Ub3NoaWJhIE11bHRpbWVkaWEgQ2Vu
dGVyIFNCLTA1MDAgKi8KIHsKIAlVU0JfREVWSUNFKDB4MDQxZSwgMHgzMDQ4KSwKZGlmZiAtLWdp
dCBhL3NvdW5kL3VzYi91c2JhdWRpby5oIGIvc291bmQvdXNiL3VzYmF1ZGlvLmgKaW5kZXggMWU3
OTk4Ni4uM2UyYjAzNSAxMDA2NDQKLS0tIGEvc291bmQvdXNiL3VzYmF1ZGlvLmgKKysrIGIvc291
bmQvdXNiL3VzYmF1ZGlvLmgKQEAgLTgwLDYgKzgwLDcgQEAgZW51bSBxdWlya190eXBlIHsKIAlR
VUlSS19NSURJX0NNRSwKIAlRVUlSS19NSURJX0FLQUksCiAJUVVJUktfTUlESV9VUzEyMkwsCisJ
UVVJUktfTUlESV9GVERJLAogCVFVSVJLX0FVRElPX1NUQU5EQVJEX0lOVEVSRkFDRSwKIAlRVUlS
S19BVURJT19GSVhFRF9FTkRQT0lOVCwKIAlRVUlSS19BVURJT19FRElST0xfVUFYWCwK
--000e0cd32cfaf88cc204ab2c6547
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000e0cd32cfaf88cc204ab2c6547--
