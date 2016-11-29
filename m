From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][alsa-lib] topology: fix unused-const-variable
	warning
Date: Wed, 30 Nov 2016 00:44:32 +0900
Message-ID: <20161129154432.8299-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id BA70F2667C9
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 16:44:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

TGFzdCB5ZWFyLCB1bnVzZWQgc3RhdGljIGNvbnN0IHZhcmlhYmxlIHdhcyBhZGRlZCwgdGhlbiBj
b21waWxlciBnZW5lcmF0ZXMKYSBiZWxvdyB3YXJuaW5nLgoKZGFwbS5jOjQzOjMwOiB3YXJuaW5n
OiDigJh3aWRnZXRfY29udHJvbF9tYXDigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LWNvbnN0LXZhcmlhYmxlPV0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWFwX2VsZW0gd2lkZ2V0X2Nv
bnRyb2xfbWFwW10gPSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fgoKVGhpcyBjb21taXQgcmVtb3ZlcyBpdC4KCkZpeGVzOiAwMWEwZTFhMWMyMTkgKCJ0
b3BvbG9neTogQWRkIERBUE0gb2JqZWN0IHBhcnNlciIpClNpZ25lZC1vZmYtYnk6IFRha2FzaGkg
U2FrYW1vdG8gPG8tdGFrYXNoaUBzYWthbW9jY2hpLmpwPgotLS0KIHNyYy90b3BvbG9neS9kYXBt
LmMgfCA4IC0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9zcmMvdG9wb2xvZ3kvZGFwbS5jIGIvc3JjL3RvcG9sb2d5L2RhcG0uYwppbmRleCBlODMw
NzUxLi44YzU4NWE3IDEwMDY0NAotLS0gYS9zcmMvdG9wb2xvZ3kvZGFwbS5jCisrKyBiL3NyYy90
b3BvbG9neS9kYXBtLmMKQEAgLTM5LDE0ICszOSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWFw
X2VsZW0gd2lkZ2V0X21hcFtdID0gewogCXsiZGFpX2xpbmsiLCBTTkRfU09DX1RQTEdfREFQTV9E
QUlfTElOS30sCiB9OwogCi0vKiBtYXBwaW5nIG9mIHdpZGdldCBrY29udHJvbCB0ZXh0IG5hbWVz
IHRvIHR5cGVzICovCi1zdGF0aWMgY29uc3Qgc3RydWN0IG1hcF9lbGVtIHdpZGdldF9jb250cm9s
X21hcFtdID0gewotCXsidm9sc3ciLCBTTkRfU09DX1RQTEdfREFQTV9DVExfVk9MU1d9LAotCXsi
ZW51bV9kb3VibGUiLCBTTkRfU09DX1RQTEdfREFQTV9DVExfRU5VTV9ET1VCTEV9LAotCXsiZW51
bV92aXJ0IiwgU05EX1NPQ19UUExHX0RBUE1fQ1RMX0VOVU1fVklSVH0sCi0JeyJlbnVtX3ZhbHVl
IiwgU05EX1NPQ19UUExHX0RBUE1fQ1RMX0VOVU1fVkFMVUV9LAotfTsKLQogc3RhdGljIGludCBs
b29rdXBfd2lkZ2V0KGNvbnN0IGNoYXIgKncpCiB7CiAJdW5zaWduZWQgaW50IGk7Ci0tIAoyLjku
MwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
