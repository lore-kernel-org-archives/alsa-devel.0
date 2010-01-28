From: Wei Ni <wni@nvidia.com>
Subject: [PATCH]Change the AZX_MAX_PCMS to 10
Date: Thu, 28 Jan 2010 16:32:44 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1BFEAFA4039@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4039HKMAIL01nvidi_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BA5A103819
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 09:33:01 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'akpm' <akpm@linux-foundation.org>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Pavel Hofman' <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

--_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4039HKMAIL01nvidi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, Takashi
When I develop hdmi audio driver on the GT21x, I found a bug in the had_i=
ntel.c
In hda_codec.c, it has define "[HDA_PCM_TYPE_HDMI]  =3D { 3, 7, 8, 9, -1 =
},",
it support up to device 9 for HDMI.
But in hda_intel.c, it only define AZX_MAX_PCMS as 8.
So the GT21x have 4 hdmi codecs, when run azx_attach_pcm_stream(),
it will show error "Invalid PCM device number 8", and "... number 9", and=
=20return "-EINVAL".
We should change the AZX_MAX_PCMS to 10.

I attach the patch file, please check it.


Thanks
Wei.


-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

--_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4039HKMAIL01nvidi_
Content-Type: application/octet-stream;
	name="0001-Change-the-AZX_MAX_PCMS-to-10.patch"
Content-Description: 0001-Change-the-AZX_MAX_PCMS-to-10.patch
Content-Disposition: attachment;
	filename="0001-Change-the-AZX_MAX_PCMS-to-10.patch"; size=1213;
	creation-date="Thu, 28 Jan 2010 16:25:18 GMT";
	modification-date="Thu, 28 Jan 2010 16:25:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkZDNiZmRlNDE0MDE3OTU2ZTM2NWI0NWY5OTRlMmRkNGY1OGUwOTMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXZWkgTmkgPHduaUBudmlkaWEuY29tPgpEYXRlOiBUaHUsIDI4
IEphbiAyMDEwIDE2OjEzOjA3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gQ2hhbmdlIHRoZSBBWlhf
TUFYX1BDTVMgdG8gMTAKCkluIGhkYV9jb2RlYy5jLCBpdCBoYXMgZGVmaW5lCiJbSERBX1BDTV9U
WVBFX0hETUldICA9IHsgMywgNywgOCwgOSwgLTEgfSwiLAppdCBzdXBwb3J0IHVwIHRvIGRldmlj
ZSA5IGZvciBIRE1JLgpCdXQgaW4gaGRhX2ludGVsLmMsIGl0IG9ubHkgZGVmaW5lIEFaWF9NQVhf
UENNUyBhcyA4LgpTbyBpZiBpdCBoYXZlIDQgaGRtaSBjb2RlY3MsIHdoZW4gcnVuIGF6eF9hdHRh
Y2hfcGNtX3N0cmVhbSgpLAppdCB3aWxsIHNob3cgZXJyb3IgIkludmFsaWQgUENNIGRldmljZSBu
dW1iZXIgOCIsIGFuZCAiLi4uIG51bWJlciA5IiwKYW5kIHJldHVybiAiLUVJTlZBTCIuCldlIHNo
b3VsZCBjaGFuZ2UgdGhlIEFaWF9NQVhfUENNUyB0byAxMC4KClNpZ25lZC1vZmYtYnk6IFdlaSBO
aSA8d25pQG52aWRpYS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyB8ICAgIDIg
Ky0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9p
bnRlbC5jCmluZGV4IGI3NDllM2QuLjI1OTUyYTQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEv
aGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtMjYxLDcgKzI2
MSw3IEBAIGVudW0geyBTREkwLCBTREkxLCBTREkyLCBTREkzLCBTRE8wLCBTRE8xLCBTRE8yLCBT
RE8zIH07CiAvKiBtYXggYnVmZmVyIHNpemUgLSBubyBoL3cgbGltaXQsIHlvdSBjYW4gaW5jcmVh
c2UgYXMgeW91IGxpa2UgKi8KICNkZWZpbmUgQVpYX01BWF9CVUZfU0laRQkoMTAyNCoxMDI0KjEw
MjQpCiAvKiBtYXggbnVtYmVyIG9mIFBDTSBkZXZpY3MgcGVyIGNhcmQgKi8KLSNkZWZpbmUgQVpY
X01BWF9QQ01TCQk4CisjZGVmaW5lIEFaWF9NQVhfUENNUwkJMTAKIAogLyogUklSQiBpbnQgbWFz
azogb3ZlcnJ1blsyXSwgcmVzcG9uc2VbMF0gKi8KICNkZWZpbmUgUklSQl9JTlRfUkVTUE9OU0UJ
MHgwMQotLSAKMS41LjYKCg==

--_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4039HKMAIL01nvidi_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4039HKMAIL01nvidi_--
