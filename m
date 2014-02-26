From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCHv2] ASoC: Intel: Baytrail: Fix implicit
	declaration of function 'memcpy_fromio'
Date: Wed, 26 Feb 2014 15:31:46 +0200
Message-ID: <1393421506-2411-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <1393420341-31625-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id F178A2617B6
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 14:31:55 +0100 (CET)
In-Reply-To: <1393420341-31625-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Liam Girdwood <lgirdwood@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, kbuild test robot <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

U29tZSBrZXJuZWwgY29uZmlndXJhdGlvbnMgY2FuIGNhdXNlIGZvbGxvd2luZyBidWlsZCBlcnJv
cjoKCnNvdW5kL3NvYy9pbnRlbC9zc3QtYmF5dHJhaWwtaXBjLmM6IEluIGZ1bmN0aW9uIOKAmHNz
dF9ieXRfZ2V0X2RzcF9wb3NpdGlvbuKAmToKc291bmQvc29jL2ludGVsL3NzdC1iYXl0cmFpbC1p
cGMuYzo3NDQ6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmG1l
bWNweV9mcm9taW/igJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAg
bWVtY3B5X2Zyb21pbygmZndfdHN0YW1wLAogIF4KY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRy
ZWF0ZWQgYXMgZXJyb3JzCgpGaXggdGhpcyBieSBpbmNsdWRpbmcgPGxpbnV4L2lvLmg+IGV4cGxp
Y2l0bHkuCgpSZXBvcnRlZC1ieToga2J1aWxkIHRlc3Qgcm9ib3QgPGZlbmdndWFuZy53dUBpbnRl
bC5jb20+ClNpZ25lZC1vZmYtYnk6IEphcmtrbyBOaWt1bGEgPGphcmtrby5uaWt1bGFAbGludXgu
aW50ZWwuY29tPgotLS0KdjI6IGluY2x1ZGluZyA8bGludXgvaW8uaD4gaW5zdGVhZCBvZiA8YXNt
L2lvLmg+LiBUaGFua3MgdG8gVGFrYXNoaSBJd2FpIGZvcgpub3RpY2luZyAoY2hlY2twYXRjaC5w
bCB0ZWxscyBpdCB0b28pLgoKQWxzbyBzc3QtZHNwLiwgc3N0LWJheXRyYWlsLWRzcC5jIGFuZCBz
c3QtaGFzd2VsbC1kc3AuYyBhcmUgdXNpbmcKbWVtY3B5X2Zyb21pby9fdG9pbyBidXQgdGhlcmUg
PGFzbS9pby5oPiBzZWVtcyB0byBjb21lIHZpYQo8bGludXgvZG1hLW1hcHBpbmcuaD4gb3IgPGxp
bnV4L2lvLmg+IHNvIEkgZGlkbid0IHRvdWNoIHRoZW0uCi0tLQogc291bmQvc29jL2ludGVsL3Nz
dC1iYXl0cmFpbC1pcGMuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpk
aWZmIC0tZ2l0IGEvc291bmQvc29jL2ludGVsL3NzdC1iYXl0cmFpbC1pcGMuYyBiL3NvdW5kL3Nv
Yy9pbnRlbC9zc3QtYmF5dHJhaWwtaXBjLmMKaW5kZXggOGM5MWE2OGI5MGJjLi5jMTJlMTk0YmJj
NmIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9pbnRlbC9zc3QtYmF5dHJhaWwtaXBjLmMKKysrIGIv
c291bmQvc29jL2ludGVsL3NzdC1iYXl0cmFpbC1pcGMuYwpAQCAtMjYsNiArMjYsNyBAQAogI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgogI2luY2x1ZGUgPGxpbnV4L2t0aHJlYWQu
aD4KICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPgorI2luY2x1ZGUgPGxpbnV4L2lvLmg+CiAj
aW5jbHVkZSA8YXNtL2RpdjY0Lmg+CiAKICNpbmNsdWRlICJzc3QtYmF5dHJhaWwtaXBjLmgiCi0t
IAoxLjguNS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
