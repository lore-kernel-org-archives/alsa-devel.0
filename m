From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ASoC: cs35l32: prevent unexpected parse result
	of device tree
Date: Tue, 15 Mar 2016 21:06:13 +0900
Message-ID: <1458043574-6078-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id BF3102612AF
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 13:06:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brian.austin@cirrus.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGksCgpXaGVuIGNvbXBpbGluZyByZWNlbnQga2VybmVsLCBJIGdvdCBhIHdhcm5pbmcgY2F1c2Vk
IGJ5IGEgY29kZWMgaW4gQVNvQy4KCnNvdW5kL3NvYy9jb2RlY3MvY3MzNWwzMi5jOiBJbiBmdW5j
dGlvbiDigJhjczM1bDMyX2kyY19wcm9iZeKAmToKc291bmQvc29jL2NvZGVjcy9jczM1bDMyLmM6
Mjc4OjI6IHdhcm5pbmc6IOKAmHZhbOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRo
aXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5pbml0aWFsaXplZF0KICBzd2l0Y2ggKHZhbCkgewogIF4K
c291bmQvc29jL2NvZGVjcy9jczM1bDMyLmM6MjcyOjE1OiBub3RlOiDigJh2YWzigJkgd2FzIGRl
Y2xhcmVkIGhlcmUKICB1bnNpZ25lZCBpbnQgdmFsOwogICAgICAgICAgICAgICBeCgpJJ20gbm90
IGFuIEFTb0MgZGV2ZWxvcGVyLCBmdXJ0aGVybW9yZSwgaGF2ZSBubyBrbm93bGVkZ2UgYWJvdXQg
dGhpcyBDaXJydXMKY29kZWMuIEFsdGhvdWdoLCBhcyBhIHF1aWNrIGdsYW5jZSBpdCBtYXkgaW5j
bHVkZSBhIGxvZ2ljYWwgYnVnIHRvIGFzc2lnbiB3cm9uZwppbmZvcm1hdGlvbiB0byBzdHJ1Y3R1
cmUgbWVtYmVyIGFzIGEgcmV1bHQgb2YgcGFyc2luZyBkZXZpY2UgdHJlZS4KClRoaXMgcGF0Y2gg
aXMgbXkgcHJvcG9zYWwgdG8gZml4IGl0LiBJJ20gaGFwcHkgdG8gcmVjZWl2ZSB5b3VyIGNvbW1l
bnRzLgoKUmVnYXJkcwoKClRha2FzaGkgU2FrYW1vdG8gKDEpOgogIEFTb0M6IGNzMzVsMzI6IGZp
eCB1bmV4cGVjdGVkIHBhcnNlIHJlc3VsdCBvZiBkZXZpY2UgdHJlZSBibG9iCgogc291bmQvc29j
L2NvZGVjcy9jczM1bDMyLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKCi0tIAoyLjcuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
