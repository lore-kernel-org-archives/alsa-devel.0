From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Correct rx format
 unit configuration
Date: Wed, 14 Jan 2015 14:33:32 +0200
Message-ID: <54B6621C.7060505@ti.com>
References: <1409817173-29234-1-git-send-email-peter.ujfalusi@ti.com>
 <54B64EC4.6040600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A29A4264F33
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 13:33:36 +0100 (CET)
In-Reply-To: <54B64EC4.6040600@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMDEvMTQvMjAxNSAwMToxMSBQTSwgUGFzY2FsIEh1ZXJzdCB3cm90ZToKPiBIZXkgUGV0ZXIs
IGFsbCwKPiAKPiB0aGUgcGF0Y2ggKDhlMzAwNmQwMmI0NmE3MjI3MjlhM2JiZDZhNzc0ZWFlOTlj
NmM4YjgpLCBjYXVzZXMgbG90cyBvZgo+IHRlcnJpYmxlIG5vaXNlIG9uIGEgY3VzdG9tIGJ1aWx0
IGFtMzN4eCBiYXNlZCBib2FyZCwgaWYgSSBtYXAgdGhlIGlucHV0Cj4gdG8gdGhlIG91dHB1dCBs
aWtlIHNvOgo+IAo+IGFyZWNvcmQgLWYgUzE2X0xFIC1yIDQ4MDAwIC1jMiAtRCBodzowLDEgLUYg
MCAtLXBlcmlvZC1zaXplPTEwMgo+IDQgLUIgMCAtLWJ1ZmZlci1zaXplPTQwOTYgfCBhcGxheSAt
RCBodzowLDAgLQoKRldJVyB0aGUgLUYwIGFuZCAtQjAgaXMgcmVkdW5kYW50IGFuZCB5b3UgY2Fu
IHVzZSAtZmRhdCBpbnN0ZWFkIG9mIC1mIFMxNl9MRQotciA0ODAwMCAtYzIKCj4gSWYgSSB1bmRv
IHlvdXIgY2hhbmdlcywgZXZlcnl0aGluZyB3b3JrcyBmaW5lLiBUZXN0ZWQgd2l0aCAzLjE0LjIz
IGFuZAo+IDMuMTguMS4KCllvdSBtZWFuIG9ubHkgdGhpcyBzaW5nbGUgY29tbWl0PwoKPiBEbyB5
b3UgaGF2ZSBhbnkgSWRlYSwgd2hhdCBtaWdodCBjYXVzZSB0aGF0IGJlaGF2aW9yPwoKTm8sIEkg
ZG9uJ3QuIEkgcXVpY2tseSBjaGVja2VkIG9uIGFtMzM1eCwgYW00Mzd4IGFuZCBvbiBKNiBib2Fy
ZHMgYW5kIHRoZQpjb21tYW5kIHlvdSBhcmUgdXNpbmcgd29ya3Mgdy9vIGFueSBpc3N1ZSBvciBk
aXN0b3J0aW9uIGluIHJlY29yZGVkIGF1ZGlvLgoKd2hhdCBjb2RlYyBvciBjb2RlY3MgYXJlIHlv
dSB1c2luZz8gSSBzZWUgdGhhdCB5b3UgcmVjb3JkIGZyb20gaHc6MCwxIGFuZCBwbGF5Cml0IGJh
Y2sgdG8gaHc6MCwwCkNhbiB5b3UgY2hlY2sgaWYgdGhlIHJlY29yZGVkIHNhbXBsZSBhbG9uZSBp
cyBjb3JyZWN0PyBKdXN0IHJlY29yZCBpdCB0byBhCmZpbGUgYW5kIGxvb2sgYXQgaXQgb24gdGhl
IFBDLiBJIGRpZCB0aGUgc2FtZSBhbmQgdGhlIHJlY29yZGVkIHNhbXBsZSBsb29rcwpmaW5lIG9u
IG15IFBDIGFzIHdlbGwuCgpMb29raW5nIGF0IHRoZSBwYXRjaCBhZ2FpbiwgSSBzdGlsbCB0aGlu
ayBpdCBpcyBhIHZhbGlkIGZpeC4KCi0tIApQw6l0ZXIKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
