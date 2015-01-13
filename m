From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress_driver.h: include
	sound/core.h explicitly
Date: Tue, 13 Jan 2015 20:15:49 +0530
Message-ID: <20150113144549.GC3085@intel.com>
References: <1418989110-10011-1-git-send-email-qais.yousef@imgtec.com>
 <54B5048F.2070709@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DBE7C260434
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 15:47:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54B5048F.2070709@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBKYW4gMTMsIDIwMTUgYXQgMTE6NDI6MDdBTSArMDAwMCwgUWFpcyBZb3VzZWYgd3Jv
dGU6Cj4gUGluZwo+IAo+IE9uIDEyLzE5LzIwMTQgMTE6MzggQU0sIFFhaXMgWW91c2VmIHdyb3Rl
Ogo+ID5GaXhlcyB0aGUgZm9sbG93aW5nIGNvbXBpbGF0aW9uIGVycm9yOgo+ID4KPiA+ICAgIGlu
Y2x1ZGUvc291bmQvY29tcHJlc3NfZHJpdmVyLmg6IEluIGZ1bmN0aW9uIOKAmHNuZF9jb21wcl9k
cmFpbl9ub3RpZnnigJk6Cj4gPiAgICBpbmNsdWRlL3NvdW5kL2NvbXByZXNzX2RyaXZlci5oOjE3
NzoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYc25kX0JVR19P
TuKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPiA+ICAgICAgaWYg
KHNuZF9CVUdfT04oIXN0cmVhbSkpCj4gPgo+ID5zbmRfQlVHX09OKCkgaXMgZGVmaW5lZCBpbiBz
b3VuZC9jb3JlLmggYnV0IHRoZSBmaWxlIGlzIG5vdCBpbmNsdWRlZCBleHBsaWNpdGx5LAo+ID5z
byBpbmNsdWRlIGl0Lgo+ID4KPiA+U2lnbmVkLW9mZi1ieTogUWFpcyBZb3VzZWYgPHFhaXMueW91
c2VmQGltZ3RlYy5jb20+Cj4gPkNjOiBWaW5vZCBLb3VsIDx2aW5vZC5rb3VsQGludGVsLmNvbT4K
PiA+Q2M6IEphcm9zbGF2IEt5c2VsYSA8cGVyZXhAcGVyZXguY3o+Cj4gPkNjOiBUYWthc2hpIEl3
YWkgPHRpd2FpQHN1c2UuZGU+Cj4gPkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4g
PgpMb29rcyBva2F5IHRvIG1lCgpBY2tlZC1ieTogVmlub2QgS291bCA8dmlub2Qua291bEBpbnRl
bC5jb20+CgpUaGFua3MKLS0gCn5WaW5vZAoKPiA+LS0tCj4gPiAgaW5jbHVkZS9zb3VuZC9jb21w
cmVzc19kcml2ZXIuaCB8IDEgKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
ID4KPiA+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvc291bmQvY29tcHJlc3NfZHJpdmVyLmggYi9pbmNs
dWRlL3NvdW5kL2NvbXByZXNzX2RyaXZlci5oCj4gPmluZGV4IDM5NmU4ZjczNjcwYS4uMWUyNTMx
MDU4YjdlIDEwMDY0NAo+ID4tLS0gYS9pbmNsdWRlL3NvdW5kL2NvbXByZXNzX2RyaXZlci5oCj4g
PisrKyBiL2luY2x1ZGUvc291bmQvY29tcHJlc3NfZHJpdmVyLmgKPiA+QEAgLTI3LDYgKzI3LDcg
QEAKPiA+ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvc2No
ZWQuaD4KPiA+KyNpbmNsdWRlIDxzb3VuZC9jb3JlLmg+Cj4gPiAgI2luY2x1ZGUgPHNvdW5kL2Nv
bXByZXNzX29mZmxvYWQuaD4KPiA+ICAjaW5jbHVkZSA8c291bmQvYXNvdW5kLmg+Cj4gPiAgI2lu
Y2x1ZGUgPHNvdW5kL3BjbS5oPgo+IAoKLS0gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
