From: Christian Wolf <wolflpz@web.de>
Subject: ALSA SDL VORBIS playback problem
Date: Tue, 2 Mar 2010 18:50:27 +0100 (CET)
Message-ID: <7299058.27442.1267552227471.JavaMail.fmail@mwmweb068>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 23AF6244E9
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 18:53:02 +0100 (CET)
Received: from mwmweb068 (mwmweb068.dlan.cinetic.de [172.20.18.82])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7689914A6B379
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 18:50:27 +0100 (CET)
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

SSdtIHVzaW5nIFNETCBvbiBhbiBBUk0gYmFzZWQgYm9hcmQgcnVubmluZyBMaW51eCAoT2xpbWV4
LUFUOTFTQU05MjYxKSAuIEkgc3VjY2Vzc2Z1bGx5IGNyb3NzLWNvbXBpbGVkLCBpbnN0YWxsZWQg
YW5kIHRlc3RlZCB0aGUgbGlicmFyaWVzIChTREwsIFNETF9taXhlcikgb24gdGhlIHN5c3RlbS4g
VGhlIHNvdW5kIG91dHB1dCBpcyBkb25lIHRocnUgQUxTQSAoU0RMX0FVRElPRFJJVkVSPWFsc2Ep
LiBBbmQgdGhlIG9nZyBmaWxlIGRlY29kaW5nIHRocnUgbGlidm9yYmlzL2xpYnZvcmJpc2ZpbGUg
bGlicmFyaWVzLgoKTm93IEknbSB0cnlpbmcgdG8gcGxheSBvZ2cgZmlsZXMuIEZpcnN0IEkgdXNl
ZCB0aGUgTWl4X0xvYWRXQVYgbWFjcm8gZnJvbSB0aGUgU0RMX01peGVyIGxpYnJhcnkgZm9yIHBs
YXliYWNrLiBUaGlzIHdvcmtlZCwgYnV0IHRoZSBtYWNybyBkZWNvbXByZXNzZXMgZmlyc3QgdGhl
IGNvbXBsZXRlIGF1ZGlvIGZpbGUgaW50byBtZW1vcnkgYW5kIHRoZW4gc3RhcnRzIHRoZSBwbGF5
YmFjay4gVGh1cyBsZWFkaW5nIHRvIGEgbG9uZyBkZWxheSBiZWZvcmUgcGxheWluZyB0aGUgbXVz
aWMuIFRoZXJlZm9yZSBJIHRyaWVkIGEgZGlmZmVyZW50IGFwcHJvYWNoIHdpdGggdGhlIE1peF9M
b2FkTVVTIG1hY3JvIChTRExfbWl4ZXIpIHRvIHBsYXkgdGhlIG9nZyBmaWxlLiBUaGlzIGZ1bmN0
aW9uIHN0cmVhbXMgdGhlIGZpbGVzIGRpcmVjdGx5IGZyb20gdGhlIGhhcmQtZGlzayBhbmQgYXZv
aWRzIHRoZSBsb25nIGRlY29kaW5nIHRpbWUuIFVuZm9ydHVuYXRlbHkgQUxTQSBzaG93cyBzZXZl
cmFsIGJ1ZmZlciB1bmRlci1ydW5zIGxlYWRpbmcgdG8gYSBkaXNydXB0ZWQgcGxheWJhY2suIFRv
IGZpeCB0aGlzIEkgdHJpZWQgZGlmZmVyZW50IGJ1ZmZlciBzaXplcywgYnV0IHRoZSBwcm9ibGVt
IGlzIHN0aWxsIGV4aXN0ZW50LgoKVGhlIGNvZGUgd29ya3MgZmluZSBvbiBteSBob3N0IHN5c3Rl
bSwgYnV0IG5vdCBvbiB0aGUgQVJNIHRhcmdldC4gQW5kIGknbSBub3Qgc3VyZSBpZiB0aGVzZSBw
cm9ibGVtcyBhcmUgY2F1c2VkIGJ5IHRoZSBBTFNBIGxpYj8KCkFueSBzb3J0IG9mIGhlbHAgd291
bGQgYmUgZ3JlYXQhCgpUaGFua3MgaW4gYWR2YW5jZQpDaHJpc3RpYW4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KR1JBVElTIGbDvHIg
YWxsZSBXRUIuREUtTnV0emVyOiBEaWUgbWF4ZG9tZSBNb3ZpZS1GTEFUIQpKZXR6dCBmcmVpc2No
YWx0ZW4gdW50ZXIgaHR0cDovL21vdmllZmxhdC53ZWIuZGUKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
