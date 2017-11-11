From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: sgio2audio: Adjust two null pointer
 checks in snd_sgio2audio_create()
Date: Sat, 11 Nov 2017 20:23:31 +0100
Message-ID: <249efc55-0688-6772-fc70-526a1bfa2603@users.sourceforge.net>
References: <eb375101-03bd-37bb-67ef-e261eeca206e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id B9D6A266B67
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 20:24:09 +0100 (CET)
In-Reply-To: <eb375101-03bd-37bb-67ef-e261eeca206e@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

RnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0PgpEYXRl
OiBTYXQsIDExIE5vdiAyMDE3IDIwOjEwOjIyICswMTAwCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRl
bnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29k
aW5nOiA4Yml0CgpUaGUgc2NyaXB0IOKAnGNoZWNrcGF0Y2gucGzigJ0gcG9pbnRlZCBpbmZvcm1h
dGlvbiBvdXQgbGlrZSB0aGUgZm9sbG93aW5nLgoKQ29tcGFyaXNvbiB0byBOVUxMIGNvdWxkIGJl
IHdyaXR0ZW4gIeKApgoKVGh1cyBmaXggdGhlIGFmZmVjdGVkIHNvdXJjZSBjb2RlIHBsYWNlcy4K
ClNpZ25lZC1vZmYtYnk6IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdl
Lm5ldD4KLS0tCiBzb3VuZC9taXBzL3NnaW8yYXVkaW8uYyB8IDQgKystLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9t
aXBzL3NnaW8yYXVkaW8uYyBiL3NvdW5kL21pcHMvc2dpbzJhdWRpby5jCmluZGV4IDllMTc1YTE4
NGI2Ni4uNDAyN2YwZmM4ZGI2IDEwMDY0NAotLS0gYS9zb3VuZC9taXBzL3NnaW8yYXVkaW8uYwor
KysgYi9zb3VuZC9taXBzL3NnaW8yYXVkaW8uYwpAQCAtODQxLDE0ICs4NDEsMTQgQEAgc3RhdGlj
IGludCBzbmRfc2dpbzJhdWRpb19jcmVhdGUoc3RydWN0IHNuZF9jYXJkICpjYXJkLAogCQlyZXR1
cm4gLUVOT0VOVDsKIAogCWNoaXAgPSBremFsbG9jKHNpemVvZigqY2hpcCksIEdGUF9LRVJORUwp
OwotCWlmIChjaGlwID09IE5VTEwpCisJaWYgKCFjaGlwKQogCQlyZXR1cm4gLUVOT01FTTsKIAog
CWNoaXAtPmNhcmQgPSBjYXJkOwogCiAJY2hpcC0+cmluZ19iYXNlID0gZG1hX2FsbG9jX2NvaGVy
ZW50KE5VTEwsIE1BQ0VJU0FfUklOR0JVRkZFUlNfU0laRSwKIAkJCQkJICAgICAmY2hpcC0+cmlu
Z19iYXNlX2RtYSwgR0ZQX1VTRVIpOwotCWlmIChjaGlwLT5yaW5nX2Jhc2UgPT0gTlVMTCkgewor
CWlmICghY2hpcC0+cmluZ19iYXNlKSB7CiAJCXByaW50ayhLRVJOX0VSUgogCQkgICAgICAgInNn
aW8yYXVkaW86IGNvdWxkIG5vdCBhbGxvY2F0ZSByaW5nIGJ1ZmZlcnNcbiIpOwogCQlrZnJlZShj
aGlwKTsKLS0gCjIuMTUuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
