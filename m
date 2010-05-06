From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 2/2] maestro3: Clear interrupts before enabling
	them
Date: Fri,  7 May 2010 00:12:13 +0300
Message-ID: <1273180333-15500-2-git-send-email-syrjala@sci.fi>
References: <1273180333-15500-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
	by alsa0.perex.cz (Postfix) with ESMTP id BE1B3103817
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 23:13:07 +0200 (CEST)
In-Reply-To: <1273180333-15500-1-git-send-email-syrjala@sci.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

RnJvbTogVmlsbGUgU3lyasOkbMOkIDxzeXJqYWxhQHNjaS5maT4KCkF2b2lkIHNwdXJpb3VzIGlu
dGVycnVwdHMgd2hlbiBpbml0aWFsaXppbmcgdGhlIGRldmljZS4KClNpZ25lZC1vZmYtYnk6IFZp
bGxlIFN5cmrDpGzDpCA8c3lyamFsYUBzY2kuZmk+Ci0tLQogc291bmQvcGNpL21hZXN0cm8zLmMg
fCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9tYWVzdHJvMy5jIGIvc291bmQvcGNpL21hZXN0cm8z
LmMKaW5kZXggYWRmNTU3YS4uOGY2MWZiYiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL21hZXN0cm8z
LmMKKysrIGIvc291bmQvcGNpL21hZXN0cm8zLmMKQEAgLTI0MjksNiArMjQyOSw3IEBAIHNuZF9t
M19lbmFibGVfaW50cyhzdHJ1Y3Qgc25kX20zICpjaGlwKQogCXZhbCA9IEFTU1BfSU5UX0VOQUJM
RSAvKnwgTVBVNDAxX0lOVF9FTkFCTEUqLzsKIAlpZiAoY2hpcC0+aHZfY29uZmlnICYgSFZfQ1RS
TF9FTkFCTEUpCiAJCXZhbCB8PSBIVl9JTlRfRU5BQkxFOworCW91dGIodmFsLCBjaGlwLT5pb2Jh
c2UgKyBIT1NUX0lOVF9TVEFUVVMpOwogCW91dHcodmFsLCBpbyArIEhPU1RfSU5UX0NUUkwpOwog
CW91dGIoaW5iKGlvICsgQVNTUF9DT05UUk9MX0MpIHwgQVNTUF9IT1NUX0lOVF9FTkFCTEUsCiAJ
ICAgICBpbyArIEFTU1BfQ09OVFJPTF9DKTsKLS0gCjEuNi40LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
