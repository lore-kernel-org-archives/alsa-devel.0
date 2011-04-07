From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sst: fix compile error
Date: Thu, 7 Apr 2011 07:27:18 +0100
Message-ID: <20110407062717.GA14519@opensource.wolfsonmicro.com>
References: <20110407021813.5372.82489.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A2984103870
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 08:27:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110407021813.5372.82489.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, gregkh@suse.de`, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBBcHIgMDcsIDIwMTEgYXQgMTA6MTg6MTNBTSArMDgwMCwgTHUgR3VhbnF1biB3cm90
ZToKPiBBZGQgc2V2ZXJhbCBpbmNsdWRlIGZpbGVzIHRvIGZpeCB0aGUgYmVsb3cgY29tcGlsZSBl
cnJvci4KPiAKPiBkcml2ZXJzL3N0YWdpbmcvaW50ZWxfc3N0L2ludGVsbWlkLmM6IEluIGZ1bmN0
aW9uIOKAmHNuZF9pbnRlbG1hZF9zc3RfcmVnaXN0ZXLigJk6Cj4gZHJpdmVycy9zdGFnaW5nL2lu
dGVsX3NzdC9pbnRlbG1pZC5jOjYxMjoyOiBlcnJvcjog4oCYc3N0X2Rydl9jdHjigJkgdW5kZWNs
YXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4gZHJpdmVycy9zdGFnaW5nL2ludGVs
X3NzdC9pbnRlbG1pZC5jOjYxMjoyOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBp
cyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgo+IAo+
IFNpZ25lZC1vZmYtYnk6IEx1IEd1YW5xdW4gPGd1YW5xdW4ubHVAaW50ZWwuY29tPgoKSXMgdGhp
cyBuZWVkZWQgaW4gMi42LjM5PyAgR3JlZywgSSdtIGhhcHB5IHRvIHRha2UgdGhpcyB0aHJvdWdo
IEFTb0MgaWYKeW91J3JlIE9LIHdpdGggdGhhdC4KCj4gLS0tCj4gIGRyaXZlcnMvc3RhZ2luZy9p
bnRlbF9zc3QvaW50ZWxtaWQuYyB8ICAgIDMgKysrCj4gIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdp
bmcvaW50ZWxfc3N0L2ludGVsbWlkLmMgYi9kcml2ZXJzL3N0YWdpbmcvaW50ZWxfc3N0L2ludGVs
bWlkLmMKPiBpbmRleCAzMmRlZDE0Li5iYmRhMzBmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc3Rh
Z2luZy9pbnRlbF9zc3QvaW50ZWxtaWQuYwo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9pbnRlbF9z
c3QvaW50ZWxtaWQuYwo+IEBAIC0zNyw4ICszNywxMSBAQAo+ICAjaW5jbHVkZSA8c291bmQvcGNt
X3BhcmFtcy5oPgo+ICAjaW5jbHVkZSA8c291bmQvaW5pdHZhbC5oPgo+ICAjaW5jbHVkZSA8bGlu
dXgvZ3Bpby5oPgo+ICsjaW5jbHVkZSA8bGludXgvZmlybXdhcmUuaD4KPiAgI2luY2x1ZGUgImlu
dGVsX3NzdC5oIgo+ICAjaW5jbHVkZSAiaW50ZWxfc3N0X2lvY3RsLmgiCj4gKyNpbmNsdWRlICJp
bnRlbF9zc3RfZndfaXBjLmgiCj4gKyNpbmNsdWRlICJpbnRlbF9zc3RfY29tbW9uLmgiCj4gICNp
bmNsdWRlICJpbnRlbG1pZF9zbmRfY29udHJvbC5oIgo+ICAjaW5jbHVkZSAiaW50ZWxtaWRfYWRj
X2NvbnRyb2wuaCIKPiAgI2luY2x1ZGUgImludGVsbWlkLmgiCj4gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
