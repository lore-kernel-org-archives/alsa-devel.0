From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/7] ASoC: topology: fixes and improvements
Date: Fri, 25 Jan 2019 14:06:41 -0600
Message-ID: <20190125200648.12470-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E2DE2666B3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:06:57 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

TW9kdWxlIGxvYWQvdW5sb2FkIHRlc3RzIGV4cG9zZWQgYSBzZXQgb2Ygd2Vha25lc3NlcyBpbiBi
b3RoIHRoZSBTT0YKYW5kIFNreWxha2UgZHJpdmVycywgc29tZSBvZiB3aGljaCBhcmUgcmVsYXRl
ZCB0byB0aGUgdG9wb2xvZ3kKZnJhbWV3b3JrLiBUaGlzIHBhdGNoc2V0IHByb3ZpZGVzIGEgY29t
YmluZWQgc2V0IG9mIGZpeGVzIGlkZW50aWZpZWQKYnkgdGhlIHR3byB0ZWFtcy4KCkRBUE0gcm91
dGVzIHdlcmUgYWxzbyBub3QgcHJvcGVybHkgaGFuZGxlZCwgbGVhZGluZyB0byBjb25mdXNpbmcK
aXNzdWVzIHdoZW4gdGhlIHRvcG9sb2d5IHJlc291cmNlcyB3ZXJlIHJlbGVhc2VkLgoKQWxsIHRo
ZXNlIHBhdGNoZXMgd2VyZSB0ZXN0ZWQgb24gdG9wIG9mIHRoZSBTT0YgdHJlZSwgd2hpY2ggdHJh
Y2tzCk1hcmsncyBicmFuY2ggb24gYSB3ZWVrbHkgYmFzaXMuCgpBbWFkZXVzeiBTxYJhd2nFhHNr
aSAoMyk6CiAgQVNvQzogdG9wb2xvZ3k6IFJlZHVjZSBudW1iZXIgb2YgZGVyZWZlcmVuY2VzIHdo
ZW4gYWNjZXNzaW5nIGRvYmoKICBBU29DOiB0b3BvbG9neTogUmVtb3ZlIHdpZGdldHMgZnJvbSBk
b2JqIGxpc3QKICBBU29DOiB0b3BvbG9neTogRml4IG1lbW9yeSBsZWFrIGZyb20gc29jX3RwbGdf
ZGVudW1fY3JlYXRlX3RleHRzCgpCYXJkIGxpYW8gKDIpOgogIEFTb0M6IHRvcG9sb2d5OiBmaXgg
bWVtb3J5IGxlYWsgaW4gc29jX3RwbGdfZGFwbV93aWRnZXRfY3JlYXRlCiAgQVNvQzogdG9wb2xv
Z3k6IHVubG9hZCBwaHlzaWNhbCBkYWkgbGluayBpbiByZW1vdmUKClJhbmphbmkgU3JpZGhhcmFu
ICgyKToKICBBU29DOiB0b3BvbG9neTogYWRkIFNORF9TT0NfRE9CSl9HUkFQSCB0eXBlIGZvciBk
YXBtIHJvdXRlcwogIEFTb0M6IHRvcG9sb2d5OiBtb2RpZnkgZGFwbSByb3V0ZSBsb2FkaW5nIHJv
dXRpbmUgYW5kIGFkZCBkYXBtIHJvdXRlCiAgICB1bmxvYWRpbmcKCiBpbmNsdWRlL3NvdW5kL3Nv
Yy1kYXBtLmggICAgIHwgICAyICsKIGluY2x1ZGUvc291bmQvc29jLXRvcG9sb2d5LmggfCAgIDgg
Ky0KIHNvdW5kL3NvYy9zb2MtdG9wb2xvZ3kuYyAgICAgfCAxNjUgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTQ0IGluc2VydGlvbnMoKyksIDMx
IGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
