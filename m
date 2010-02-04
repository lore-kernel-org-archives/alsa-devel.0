From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: [PATCH] hda-analyzer: Avoid AttributeError when codec
	has no nodes
Date: Thu,  4 Feb 2010 19:30:54 +0200
Message-ID: <1265304654-14439-1-git-send-email-ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 05599103824
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 18:25:46 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

V2hlbiB0cmF2ZXJzaW5nIGNhcmQvY29kZWMvbm9kZXMgZHVyaW5nIHRyZWV3aWRnZXQgY3JlYXRp
b24sIGl0J3MgcXVpdGUKcG9zc2libGUgdGhhdCBjb2RlYy5ub2RlcyByYWlzZXMgYW4gQXR0cmli
dXRlRXJyb3IgaWYgdGhlIGN1cnJlbnQgY29kZWMKZG9lc24ndCBzZWVtIHRvIGhhdmUgYSBub2Rl
cyBkaWN0aW9uYXJ5LgoKU2ltcGx5IGluaXRpYWxpemUgaXQgdG8gYW4gZW1wdHkgZGljdGlvbmFy
eSBpbiB0aGUgYmVnaW5uaW5nIG9mCmFuYWx5emUoKS4KClNpZ25lZC1vZmYtYnk6IE96YW4gw4dh
xJ9sYXlhbiA8b3phbkBwYXJkdXMub3JnLnRyPgotLS0KIGhkYS1hbmFseXplci9oZGFfY29kZWMu
cHkgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9oZGEtYW5hbHl6ZXIvaGRhX2NvZGVjLnB5IGIvaGRhLWFuYWx5
emVyL2hkYV9jb2RlYy5weQppbmRleCBjYmVhM2Y4Li5kNTg3YTI4IDEwMDY0NAotLS0gYS9oZGEt
YW5hbHl6ZXIvaGRhX2NvZGVjLnB5CisrKyBiL2hkYS1hbmFseXplci9oZGFfY29kZWMucHkKQEAg
LTgxOCw2ICs4MTgsNyBAQCBjbGFzcyBIREFDb2RlYzoKICAgZGVmIGFuYWx5emUoc2VsZik6CiAg
ICAgc2VsZi5hZmcgPSBOb25lCiAgICAgc2VsZi5tZmcgPSBOb25lCisgICAgc2VsZi5ub2RlcyA9
IHt9CiAgICAgc2VsZi52ZW5kb3JfaWQgPSBzZWxmLnBhcmFtX3JlYWQoQUNfTk9ERV9ST09ULCBQ
QVJBTVNbJ1ZFTkRPUl9JRCddKQogICAgIHNlbGYuc3Vic3lzdGVtX2lkID0gc2VsZi5wYXJhbV9y
ZWFkKEFDX05PREVfUk9PVCwgUEFSQU1TWydTVUJTWVNURU1fSUQnXSkKICAgICBzZWxmLnJldmlz
aW9uX2lkID0gc2VsZi5wYXJhbV9yZWFkKEFDX05PREVfUk9PVCwgUEFSQU1TWydSRVZfSUQnXSkK
QEAgLTg2Niw3ICs4NjcsNiBAQCBjbGFzcyBIREFDb2RlYzoKIAogICAgIG5vZGVzX2NvdW50LCBu
aWQgPSBzZWxmLmdldF9zdWJfbm9kZXMoc2VsZi5hZmcpCiAgICAgc2VsZi5iYXNlX25pZCA9IG5p
ZAotICAgIHNlbGYubm9kZXMgPSB7fQogICAgIGZvciBpIGluIHJhbmdlKG5vZGVzX2NvdW50KToK
ICAgICAgIHNlbGYubm9kZXNbbmlkXSA9IEhEQU5vZGUoc2VsZiwgbmlkKQogICAgICAgbmlkICs9
IDEKLS0gCjEuNi41LjYKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
