From: Delio Brignoli <dbrignoli@audioscience.com>
Subject: Make snd_card_free() a no-op again for NULL ptr
	argument
Date: Thu, 29 Jun 2017 12:46:33 +0200
Message-ID: <4ED8A548-C7E7-42A8-B3C7-0D32BFC49367@audioscience.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from GWA7.webcontrolcenter.com (gwa7.webcontrolcenter.com
 [63.134.207.34])
 by alsa0.perex.cz (Postfix) with ESMTP id CBCF72672C1
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 12:47:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8gVGFrYXNoaSwKCkNvbW1pdCDigJxBTFNBOiBVc2Ugc3RhbmRhcmQgZGV2aWNlIHJlZmNv
dW50IGZvciBjYXJkIGFjY291bnRpbmfigJ0gPGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvc291bmQvY29yZS9p
bml0LmM/aD12NC4xMi1yYzYmaWQ9ZjI0NjQwNjQ4MTg2YjU5YmQzOWY4Y2Q2NDBkNjMxYmRiNjFh
MzE5Nz4gY2hhbmdlZCB0aGUgYmVoYXZpb3VyIG9mIHNuZF9jYXJkX2ZyZWUoKSBpbiBjYXNlIG9m
IGEgTlVMTCBwdHIgYXJndW1lbnQuIEJlZm9yZSBmMjQ2NDA2NDgxODZiNTliZDM5ZjhjZDY0MGQ2
MzFiZGI2MWEzMTk3IHNuZF9jYXJkX2ZyZWUoKSB3YXMgYSBuby1vcCBpbiBjYXNlIG9mIGEgTlVM
TCBwdHIgYXJndW1lbnQgYXMgSSB3b3VsZCBleHBlY3QgZm9yIGEgKl9mcmVlKCkgZnVuY3Rpb24u
IEN1cnJlbnRseSBwYXNzaW5nIGEgTlVMTCBwdHIgcmVzdWx0cyBpbiBhIE5VTEwgcHRyIGRlcmVm
ZXJlbmNlLgoKSSBiZWxpZXZlIHRoZSBwcmV2aW91cyBiZWhhdmlvdXIgaXMgd29ydGggcmVzdG9y
aW5nLiBJZiB5b3UgYWdyZWUgSeKAmWxsIGZvbGxvdyB1cCB3aXRoIGEgcGF0Y2guCgpUaGFuayB5
b3UuCuKAlApEZWxpbwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
