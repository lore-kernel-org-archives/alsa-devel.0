From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 02/20] ASoC: S3C: I2Sv2: Reject immidiate
	register value
Date: Wed, 10 Mar 2010 21:27:10 +0900
Message-ID: <1b68c6791003100427h20a7af3cr750e0de4ce1d1c1a@mail.gmail.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<20100310103203.GE24422@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f192.google.com (mail-qy0-f192.google.com
	[209.85.221.192])
	by alsa0.perex.cz (Postfix) with ESMTP id C1A21103898
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:27:12 +0100 (CET)
Received: by qyk30 with SMTP id 30so8003614qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 04:27:11 -0800 (PST)
In-Reply-To: <20100310103203.GE24422@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXIgMTAsIDIwMTAgYXQgNzozMiBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFdlZCwgTWFyIDEwLCAyMDEwIGF0
IDA0OjQ4OjUxUE0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6Cj4+IFRvd2FyZHMgZ2VuZXJhbGl6
aW5nIENQVSBkcml2ZXIgaW50ZXJmYWNlLCBkbyBub3QgYWNjZXB0IGRpcmVjdCBmaWVsZAo+PiB2
YWx1ZXMgZm9yIHRoZSBCQ0xLIGFuZCBSQ0xLLgo+PiBUaGUgbWFjaGluZSBkcml2ZXIgc2hvdWxk
IHNpbXBseSByZXF1ZXN0IHRoZSBGUy1tdWx0aXBsZSBhbmQgbm90IHByb3ZpZGUKPj4gdGhlIHZh
bHVlIHRvIGJlIHNldCBpbiBkaXZpZGUgZmllbGQgb2YgSUlTTU9ELgo+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEphc3NpIEJyYXIgPGphc3NpLmJyYXJAc2Ftc3VuZy5jb20+Cj4KPiBUaGlzIGlzIGdvb2Qg
YnV0IGl0IG5lZWRzIHRvIGFsc28gdXBkYXRlIGFsbCB0aGUgbWFjaGluZSBkcml2ZXJzIHRoYXQK
PiB1c2UgdGhlIGRpcmVjdCByZWdpc3RlciB2YWx1ZXMuIMKgQSBicmllZiBncmVwIHRocm91Z2gg
c3VnZ2VzdHMgdGhhdCB0aGUKPiB1ZGExMzR4IG1hY2hpbmUgYW5kIHRoZSBPcGVuTW9rbyBtYWNo
aW5lcyBuZWVkIGEgbG9vaywgdGhvdWdoIEkgZGlkbid0Cj4gYWN0dWFsbHkgY2hlY2sgd2hpY2gg
REFJIGRyaXZlciB0aGV5J3JlIGFsbCB1c2luZy4gwqBJZiBub3RoaW5nIHVzZXMgdGhpcwo+IGZl
YXR1cmUgdGhlbiBqdXN0IG5vdGUgdGhhdCBpbiB0aGUgY2hhbmdlbG9nIChpZiB0aGUgZmVhdHVy
ZSBpcyB1bnVzZWQKPiB0aGF0J3MgZXZlbiBtb3JlIHJlYXNvbiB0byByZW1vdmUgaXQgYW55d2F5
KS4KczNjLWkycy12Mi5jIGlzIHNoYXJlZCBvbmx5IGJ5IHMzYzI0MTIgYW5kIHMzYzY0eHguCnNt
ZGs2NHh4X3dtODU4MCBhbmQgaml2ZV93bTg3NTAgYWxyZWFkeSB1c2UgYXBwcm9wcmlhdGUgdmFs
dWVzLgpXaWxsIGFkZCB0aGUgbm90ZSBpbiBjaGFuZ2Vsb2cuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
