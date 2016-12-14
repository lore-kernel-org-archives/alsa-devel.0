From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 5/7] ALSA: x86: hdmi: Improve position
	reporting
Date: Wed, 14 Dec 2016 08:09:20 -0600
Message-ID: <5d237318-61b3-fb22-be28-dfcc88554d20@linux.intel.com>
References: <20161212181043.12512-1-jerome.anand@intel.com>
 <20161212181043.12512-6-jerome.anand@intel.com>
 <s5hr35aekim.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5hr35aekim.wl-tiwai@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>, Jerome Anand <jerome.anand@intel.com>
Cc: intel-gfx@lists.freedesktop.org, broonie@kernel.org, rakesh.a.ughreja@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMTIvMTQvMTYgNjo1NyBBTSwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IE9uIE1vbiwgMTIgRGVj
IDIwMTYgMTk6MTA6NDEgKzAxMDAsCj4gSmVyb21lIEFuYW5kIHdyb3RlOgo+Pgo+PiBVc2UgYSBo
dyByZWdpc3RlciB0byBjYWxjdWxhdGUgc3ViLXBlcmlvZCBwb3NpdGlvbiByZXBvcnRzLgo+PiBU
aGlzIG1ha2VzIFB1bHNlQXVkaW8gaGFwcGllci4KPj4KPj4gU2lnbmVkLW9mZi1ieTogRGF2aWQg
SGVubmluZ3Nzb24gPGRhdmlkLmhlbm5pbmdzc29uQGNhbm9uaWNhbC5jb20+Cj4+IFNpZ25lZC1v
ZmYtYnk6IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5p
bnRlbC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEplcm9tZSBBbmFuZCA8amVyb21lLmFuYW5kQGlu
dGVsLmNvbT4KPgo+IFRoZXJlIGlzIG5vIGJpZyBtZXJpdCB0byBrZWVwIHRoaXMgYSBzZXBhcmF0
ZSBwYXRjaC4KPiBQbGVhc2UgZm9sZCBpbnRvIHRoZSBtYWluIHBhdGNoLgo+IFlvdSBjYW4gcHV0
IHNvbWUgY29tbWVudCBpbiB0aGUgY29kZSBmb3IgZXhwbGFuYXRpb24uCgpUaGUgcmVhc29uIHdl
IGtlcHQgdGhpcyBwYXRjaCBhbmQgdGhlIG5leHQgc2VwYXJhdGUgaXMgcHVyZWx5IApwcm9jZWR1
cmFsOiB0aGV5IHdlcmUgY29udHJpYnV0ZWQgYnkgQ2Fub25pY2FsIGluIHRoZWlyIEJheXRyYWls
IENvbXB1dGUgClN0aWNrIGtlcm5lbCwgYW5kIHdlIGRpZG4ndCB3YW50IHRvIHNxdWFzaCB0aGlz
IGJsaW5kbHksIGVzcGVjaWFsbHkgCnNpbmNlIERhdmlkIGhhcyBnb25lIHNpbGVudC4KSSBkb24n
dCBtaW5kIGZvbGRpbmcgdGhpcyBjb2RlIGludG8gdGhlIEludGVsIHBhdGNoZXMgYnV0IEkgd2Fz
bid0IHN1cmUgCnRoaXMgd2FzIGFwcHJvcHJpYXRlIG9yIGV2ZW4gYWxsb3dlZC4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcg
bGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
