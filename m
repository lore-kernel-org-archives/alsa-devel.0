From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Fix inaudible internal speakers
 on CyberpowerPC Gamer Xplorer N57001 laptop
Date: Fri, 10 Jun 2011 09:39:16 -0400
Message-ID: <BANLkTinBGGsUB7GUwCf6NYtYKQ8PiVHxkA@mail.gmail.com>
References: <BANLkTinHXyDWKQAEOWf9z1DhKj=XCmxUNw@mail.gmail.com>
	<s5hmxhry1bh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3001b82d31088104a55bb2ef
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 64DCA10383E
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 15:39:17 +0200 (CEST)
Received: by wwf26 with SMTP id 26so2093156wwf.20
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 06:39:17 -0700 (PDT)
In-Reply-To: <s5hmxhry1bh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--20cf3001b82d31088104a55bb2ef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Thu, Jun 9, 2011 at 2:18 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Any chance to test model=3Dauto with the very latest snapshot driver (or
> 3.0-rc2 kernel)? =C2=A0The auto-parser works better than the static quirk
> nowaday, but needs a bit more testing before switching to it as
> default.

The original reporter has verified that the autoparser in the latest
snapshot driver works well. Thus, this patch is only necessary for
2.6.38 and 2.6.39, which I've clarified in the commit message in the
newly attached patch.

Cheers,
-Dan

--20cf3001b82d31088104a55bb2ef
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-inaudible-internal-speakers-on-Cyberpow.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-inaudible-internal-speakers-on-Cyberpow.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gor6k0h20

RnJvbSA4YWM0NTY5OTMzN2VhZWVhMWQ3NDYxNDJiN2FlNWNkOGU1OTA1NGZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IEZyaSwgMTAgSnVuIDIwMTEgMDk6MzA6NTMgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IEZpeCBpbmF1ZGlibGUgaW50ZXJuYWwgc3BlYWtlcnMgb24gQ3liZXJwb3dlclBDCiBH
YW1lciBYcGxvcmVyIE41NzAwMSBsYXB0b3AKCkJ1Z0xpbms6IGh0dHBzOi8vbGF1bmNocGFkLm5l
dC9idWdzLzc2MTE3MQoKVGhlIG9yaWdpbmFsIHJlcG9ydGVyIG5lZWRzIHRoZSBtb2RlbD1hc3Vz
IHF1aXJrIGZvciBoaXMgaW50ZXJuYWwKc3BlYWtlcnMgdG8gYmUgYXVkaWJsZSwgc28gYWRkIGFu
IGVudHJ5IGluIHRoZSBxdWlyayB0YWJsZSBmb3IgaGlzIFBDSQpTU0lELgoKVGhpcyBwYXRjaCBp
cyBvbmx5IG5lY2Vzc2FyeSBmb3IgMi42LjM4IGFuZCAyLjYuMzkga2VybmVscy4gVGhlIGF1dG8t
CnBhcnNlciBpbiAzLjAgd29ya3MgbXVjaCBiZXR0ZXIsIGFuZCB0aGUgb3JpZ2luYWwgcmVwb3J0
ZXIgaGFzIHRlc3RlZAppdCBzdWNjZXNzZnVsbHkgaW4gdGhlIGxhdGVzdCBhbHNhLWRyaXZlciBk
YWlseSBzbmFwc2hvdC4KClJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IHRvbWRlZXJpbmc3CkNjOiA8
c3RhYmxlQGtlcm5lbC5vcmc+IFsyLjYuMzgsIDIuNi4zOV0KU2lnbmVkLW9mZi1ieTogRGFuaWVs
IFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfY29u
ZXhhbnQuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jIGIv
c291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCmluZGV4IDlmYmZkM2IuLmFjYjNjMzAgMTAw
NjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYworKysgYi9zb3VuZC9wY2kv
aGRhL3BhdGNoX2NvbmV4YW50LmMKQEAgLTMxMzUsNiArMzEzNSw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
c25kX3BjaV9xdWlyayBjeHQ1MDY2X2NmZ190YmxbXSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTdh
YSwgMHgzYTBkLCAiTGVub3ZvIFUzNTAiLCBDWFQ1MDY2X0FTVVMpLAogCVNORF9QQ0lfUVVJUkso
MHgxN2FhLCAweDM4YWYsICJMZW5vdm8gRzU2MCIsIENYVDUwNjZfQVNVUyksCiAJU05EX1BDSV9R
VUlSS19WRU5ET1IoMHgxN2FhLCAiTGVub3ZvIiwgQ1hUNTA2Nl9JREVBUEFEKSwgLyogRmFsbGJh
Y2sgZm9yIExlbm92b3Mgd2l0aG91dCBkb2NrIG1pYyAqLworCVNORF9QQ0lfUVVJUksoMHgxYjBh
LCAweDIwOTIsICJDeWJlcnBvd2VyUEMgR2FtZXIgWHBsb3JlciBONTcwMDEiLCBDWFQ1MDY2X0FT
VVMpLAogCXt9CiB9OwogCi0tIAoxLjcuNS4zCgo=
--20cf3001b82d31088104a55bb2ef
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf3001b82d31088104a55bb2ef--
