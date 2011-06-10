From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Fix inaudible internal speakers
 on CyberpowerPC Gamer Xplorer N57001 laptop
Date: Fri, 10 Jun 2011 10:23:59 -0400
Message-ID: <BANLkTinuRrNrydT+BXXQcejVe70X9gjLyQ@mail.gmail.com>
References: <BANLkTinHXyDWKQAEOWf9z1DhKj=XCmxUNw@mail.gmail.com>
	<s5hmxhry1bh.wl%tiwai@suse.de>
	<BANLkTinBGGsUB7GUwCf6NYtYKQ8PiVHxkA@mail.gmail.com>
	<s5hipsd23dn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00221597484e189ac404a55c521f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 62062103C8D
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 16:24:00 +0200 (CEST)
Received: by wyg36 with SMTP id 36so2066986wyg.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 07:23:59 -0700 (PDT)
In-Reply-To: <s5hipsd23dn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

--00221597484e189ac404a55c521f
Content-Type: text/plain; charset=UTF-8

Hi Takashi,

On Fri, Jun 10, 2011 at 10:00 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Does 3.0-rc2 (or snapshot) work _as is_, or by passing model=auto?
> In the latter case, we'd need a corresponding entry, at least for 3.0.
> For 3.1, I'm going to apply model=auto as default.

Apologies for being unclear. The reporter needs to explicitly pass
model=auto using the snapshot. Attached is a patch _specifically for
sound-2.6 master HEAD and 3.0-rc2_ with an explanation for the
difference between the application of model quirks.

Cheers,
-Dan

--00221597484e189ac404a55c521f
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-inaudible-internal-speakers-on-Cyberpow.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-inaudible-internal-speakers-on-Cyberpow.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gor87htm0

RnJvbSBlNjJmOGJhNjczNjA5YzdlYTQyZWFiMmJmZmQ3YWI5MTBjZjcwODI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IEZyaSwgMTAgSnVuIDIwMTEgMTA6MTQ6MDEgLTA0MDAKU3ViamVjdDogW1BBVENIIHYyXSBB
TFNBOiBoZGE6IEZpeCBpbmF1ZGlibGUgaW50ZXJuYWwgc3BlYWtlcnMgb24KIEN5YmVycG93ZXJQ
QyBHYW1lciBYcGxvcmVyIE41NzAwMSBsYXB0b3AKCkJ1Z0xpbms6IGh0dHBzOi8vbGF1bmNocGFk
Lm5ldC9idWdzLzc2MTE3MQoKVGhlIG9yaWdpbmFsIHJlcG9ydGVyIG5lZWRzIHRoZSBtb2RlbD1h
dXRvIHF1aXJrIGZvciBoaXMgaW50ZXJuYWwKc3BlYWtlcnMgdG8gYmUgYXVkaWJsZSBpbiB0aGUg
bGF0ZXN0IGRhaWx5IHNuYXBzaG90LCBzbyBhZGQgYW4gZW50cnkgaW4KdGhlIHF1aXJrIHRhYmxl
IGZvciBoaXMgUENJIFNTSUQuCgpBIHRyaXZpYWxseSBkaWZmZXJlbnQgdmVyc2lvbiBvZiB0aGlz
IHBhdGNoIHVzaW5nIHRoZSBtb2RlbD1hc3VzIHF1aXJrCnNob3VsZCBiZSBhcHBsaWVkIHRvIHRo
ZSAyLjYuMzggYW5kIDIuNi4zOSBzdGFibGUga2VybmVscy4gV2UgZG9uJ3QgdXNlCnRoZSBhc3Vz
IHF1aXJrIGluIDMuMC1yYzIsIGJlY2F1c2UgMy4wLXJjMidzIGF1dG9wYXJzZXIgaXMgbXVjaApp
bXByb3ZlZC4KClJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IHRvbWRlZXJpbmc3ClNpZ25lZC1vZmYt
Ynk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRh
L3BhdGNoX2NvbmV4YW50LmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29u
ZXhhbnQuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYwppbmRleCAyMTdjYTllLi42
ZTg2NDI3IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50LmMKKysrIGIv
c291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCkBAIC0zMTAzLDYgKzMxMDMsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsgY3h0NTA2Nl9jZmdfdGJsW10gPSB7CiAJU05E
X1BDSV9RVUlSSygweDE3YWEsIDB4MzhhZiwgIkxlbm92byBHNTYwIiwgQ1hUNTA2Nl9BU1VTKSwK
IAlTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgzOTM4LCAiTGVub3ZvIEc1NjUiLCBDWFQ1MDY2X0FV
VE8pLAogCVNORF9QQ0lfUVVJUktfVkVORE9SKDB4MTdhYSwgIkxlbm92byIsIENYVDUwNjZfSURF
QVBBRCksIC8qIEZhbGxiYWNrIGZvciBMZW5vdm9zIHdpdGhvdXQgZG9jayBtaWMgKi8KKwlTTkRf
UENJX1FVSVJLKDB4MWIwYSwgMHgyMDkyLCAiQ3liZXJwb3dlclBDIEdhbWVyIFhwbG9yZXIgTjU3
MDAxIiwgQ1hUNTA2Nl9BVVRPKSwKIAl7fQogfTsKIAotLSAKMS43LjUuMwoK
--00221597484e189ac404a55c521f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00221597484e189ac404a55c521f--
