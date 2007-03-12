From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [SOUND] hda_intel: build fix
Date: Mon, 12 Mar 2007 15:46:47 +0000
Message-ID: <20070312154647.GC11974__47510.8464168899$1173714566$gmane$org@linux-mips.org>
References: <20070310190513.GA24435@linux-mips.org>
	<s5h8xe2soxt.wl%tiwai@suse.de>
	<20070312135351.GA11974@linux-mips.org>
	<s5hzm6ijzep.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ftp.linux-mips.org (ftp.linux-mips.org [194.74.144.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 0942E2463D
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2007 16:48:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43959 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021373AbXCLPsm (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Mon, 12 Mar 2007 15:48:42 +0000
Content-Disposition: inline
In-Reply-To: <s5hzm6ijzep.wl%tiwai@suse.de>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org, perex@suse.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBNYXIgMTIsIDIwMDcgYXQgMDM6NDM6MTBQTSArMDEwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgoKPiBGYWlyIGVub3VnaC4gIEkgYWdyZWUgdGhhdCByZW1vdmluZyBjb25zdCBpcyB0aGUg
b25seSByZWFzb25hYmxlIGZpeAo+IHJpZ2h0IG5vdy4gICBCdXQgZnJvbSBzZW1hbnRpY3MsIGNv
bnN0IGlzIGEgZ29vZCB0aGluZywgYW5kIHBlb3BsZSBtYXkKPiB0cnkgdG8gYWRkIGl0IGFnYWlu
IGxhdGVyIGlmIHdlIGdldCByaWQgb2YgdGhlbSBub3cuICBTbywgaG93IGFib3V0IHRvCj4gY29t
bWVudCBvdXQgc3VjaCBhcyAvKmNvbnN0Ki8gaW4gZWFjaCBwbGFjZSB0byByZW1pbmQgdGhhdCBp
dCdzCj4gaW50ZW50aW9uYWw/CgpJIGNvbnNpZGVyIHRoYXQgaGFyZGVyIHRvIHJlYWQgYW5kIHVn
bGllci4gIElmIGFueXRoaW5nIG1heWJlIHNvbWV0aGluZwpsaWtlOgoKI2RlZmluZSBfX2NvbnN0
X2RldmluaXQKWy4uLl0Kc3RhdGljIF9fY29uc3RfZGV2aW5pdCBzdHJ1Y3Qgc25kX2tjb250cm9s
X25ldyBzbmRfaWNlMTcxMl9kZWx0YTEwMTBsdF93b3JkY2xvY2tfc3RhdHVzIF9fZGV2aW5pdGRh
dGEgPQoKV29ydGggaXQ/ICBJIGRvdWJ0LgoKPiBBbHNvLCBpbiB5b3VyIHBhdGNoIHRvIGljZTE3
MTIsIHlvdSBkb24ndCBoYXZlIHRvIHJlbW92ZSBjb25zdCBmcm9tIHRoZQo+IGNvZGVzIGluIHNu
ZF9pY2UxNzEyX3JlYWRfZWVwcm9tKCkgYW5kIHNuZF9pY2UxNzEyX3Byb2JlKCkgZnVuY3Rpb25z
Lgo+IFRoZXkgc2hvdWxkIHdvcmsgYXMgY29uc3QgcG9pbnRlci4KCk5vLCB0aGF0IHJlc3VsdHMg
aW4gd2FybmluZ3M6CgogIENDICAgICAgc291bmQvcGNpL2ljZTE3MTIvaWNlMTcxMi5vCnNvdW5k
L3BjaS9pY2UxNzEyL2ljZTE3MTIuYzogSW4gZnVuY3Rpb24g4oCYc25kX2ljZTE3MTJfcmVhZF9l
ZXByb23igJk6CnNvdW5kL3BjaS9pY2UxNzEyL2ljZTE3MTIuYzoyMzU0OiB3YXJuaW5nOiBhc3Np
Z25tZW50IGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZQpzb3VuZC9wY2kvaWNlMTcxMi9p
Y2UxNzEyLmM6IEluIGZ1bmN0aW9uIOKAmHNuZF9pY2UxNzEyX3Byb2Jl4oCZOgpzb3VuZC9wY2kv
aWNlMTcxMi9pY2UxNzEyLmM6MjY5Mzogd2FybmluZzogYXNzaWdubWVudCBmcm9tIGluY29tcGF0
aWJsZSBwb2ludGVyIHR5cGUKCiAgUmFsZgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUYWtlIFN1cnZleXMu
IEVhcm4gQ2FzaC4gSW5mbHVlbmNlIHRoZSBGdXR1cmUgb2YgSVQKSm9pbiBTb3VyY2VGb3JnZS5u
ZXQncyBUZWNoc2F5IHBhbmVsIGFuZCB5b3UnbGwgZ2V0IHRoZSBjaGFuY2UgdG8gc2hhcmUgeW91
cgpvcGluaW9ucyBvbiBJVCAmIGJ1c2luZXNzIHRvcGljcyB0aHJvdWdoIGJyaWVmIHN1cnZleXMt
YW5kIGVhcm4gY2FzaApodHRwOi8vd3d3LnRlY2hzYXkuY29tL2RlZmF1bHQucGhwP3BhZ2U9am9p
bi5waHAmcD1zb3VyY2Vmb3JnZSZDSUQ9REVWREVWCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
