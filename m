From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [BUG] soc/sti: a possible sleep-in-atomic bug in
 uni_player_ctl_iec958_put
Date: Tue, 12 Dec 2017 17:11:56 +0100
Message-ID: <26c49bcf-65d9-f7d7-d281-a1cb0f978ebb@st.com>
References: <425ee21c-b6c2-640b-15fd-6ff84b79a986@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 646A7266DF0
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 17:11:59 +0100 (CET)
In-Reply-To: <425ee21c-b6c2-640b-15fd-6ff84b79a986@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, dan.carpenter@oracle.com
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

SGVsbG8gSmlhLUp1LAoKCk9uIDEyLzEyLzIwMTcgMDM6MjcgUE0sIEppYS1KdSBCYWkgd3JvdGU6
Cj4gQWNjb3JkaW5nIHRvIHNvdW5kL3NvYy9zdGkvdW5pcGVyaWZfcGxheWVyLmMsIHRoZSBkcml2
ZXIgbWF5IHNsZWVwIHVuZGVyCj4gYSBzcGlubG9jay4KPiBUaGUgZnVuY3Rpb24gY2FsbCBwYXRo
IGlzOgo+IHVuaV9wbGF5ZXJfY3RsX2llYzk1OF9wdXQgKGFjcXVpcmUgdGhlIHNwaW5sb2NrKQo+
IMKgIHVuaV9wbGF5ZXJfc2V0X2NoYW5uZWxfc3RhdHVzCj4gwqDCoMKgIG11dGV4X2xvY2sgLS0+
IG1heSBzbGVlcAo+IAo+IEkgZG8gbm90IGZpbmQgYSBnb29kIHdheSB0byBmaXggaXQsIHNvIEkg
b25seSByZXBvcnQuCj4gVGhpcyBwb3NzaWJsZSBidWcgaXMgZm91bmQgYnkgbXkgc3RhdGljIGFu
YWx5c2lzIHRvb2wgKERTQUMpIGFuZCBjaGVja2VkCj4gYnkgbXkgY29kZSByZXZpZXcuCnlvdSBy
aWdodCwgbXV0ZXggdW5kZXIgc3BpbiBsb2NrIGlzIG5vdCByZWNvbW1lbmRlZC4uLiBJIHdpbGwg
aGF2ZSBhIGxvb2sKVGhhbmtzIQoKUmVnYXJkcwpBcm5hdWQKCj4gCj4gCj4gVGhhbmtzLAo+IEpp
YS1KdSBCYWkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
