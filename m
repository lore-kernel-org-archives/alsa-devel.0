From: =?ISO-8859-1?Q?J=F6rg?= Krause <joerg.krause@embedded.rocks>
Subject: ALSA hooks: dlopen failed: snd_dlsym_start: symbol not
	found
Date: Fri, 26 Aug 2016 04:11:08 +0200
Message-ID: <1472177468.19908.28.camel@embedded.rocks>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B662266641
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 04:12:28 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 3sL4KR3tpqzypP
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 04:11:15 +0200 (CEST)
Received: from mail.embedded.rocks ([127.0.0.1])
 by localhost (mail.embedded.rocks [127.0.0.1]) (amavisd-new, port 10025)
 with ESMTP id TpqDi6ZHItRG for <alsa-devel@alsa-project.org>;
 Fri, 26 Aug 2016 04:11:14 +0200 (CEST)
Received: from nzxt.fritz.box (xd9bfe01d.dyn.telefonica.de [217.191.224.29])
 (Authenticated sender: joerg.krause@embedded.rocks)
 by mail.embedded.rocks (Postfix) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 04:11:14 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

SGksCgpJIGFtIHRyeWluZyB0byBidWlsZCBhIGN1c3RvbSBob29rIGxpYnJhcnkuIFRoZSBtaW5p
bWFsIGhvb2sgaXM6CgogICAgI2luY2x1ZGUgPGFsc2EvYXNvdW5kbGliLmg+CgogICAgaW50IF9z
bmRfcGNtX2hvb2tfYXVkaW9fc3RhdHVzX2luc3RhbGwoc25kX3BjbV90ICpwY20sIHNuZF9jb25m
aWdfdAogICAgKmNvbmYpCiAgICB7CiAgICAJICAgIHJldHVybiAwOwogICAgfQogICAgU05EX0RM
U1lNX0JVSUxEX1ZFUlNJT04oX3NuZF9wY21faG9va19hdWRpb19zdGF0dXNfaW5zdGFsbCwKICAg
IFNORF9DT05GSUdfRExTWU1fVkVSU0lPTl9IT09LKTsKCkkgY29tcGlsZSB0aGlzIGFzIGEgc2hh
cmVkIGxpYnJhcnk6CgogICAgJChDQykgLWZQSUMgLWxhc291bmQgLXNoYXJlZCAtV2wsLXNvbmFt
ZSxsaWIkKE5BTUUpLnNvICReIC1vICRACgpJZiBJIHRyeSB0byBsb2FkIHRoaXMgbGlicmFyeSB1
c2luZyBhcGxheSBJIGdldCB0aGUgZm9sbG93aW5nIGVycm9yOgoKICAgIGRsb3BlbiBmYWlsZWQ6
IEVycm9yIHJlbG9jYXRpbmcgL3Vzci9saWIvYWxzYS1saWIvbGliYXVkaW9zdGF0dXMuc286IAog
ICAgc25kX2Rsc3ltX3N0YXJ0OiBzeW1ib2wgbm90IGZvdW5kCgpUaGlzIGlzIHRoZSBvdXRwdXQg
b2YgdGhlIHByZXByb2Nlc3NvcjoKCiAgICBpbnQgX3NuZF9wY21faG9va19hdWRpb19zdGF0dXNf
aW5zdGFsbChzbmRfcGNtX3QgKnBjbSwgc25kX2NvbmZpZ190CiAgICAqY29uZikKICAgIHsKICAg
IMKgcmV0dXJuIDA7CiAgICB9CiAgICBzdGF0aWMgc3RydWN0IHNuZF9kbHN5bV9saW5rCiAgICBf
c25kX2Rsc3ltX19zbmRfcGNtX2hvb2tfYXVkaW9fc3RhdHVzX2luc3RhbGxfZGxzeW1fY29uZmln
X2hvb2tfMDAxOwogICAgdm9pZAogICAgX3NuZF9kbHN5bV9jb25zdHJ1Y3Rvcl9fc25kX3BjbV9o
b29rX2F1ZGlvX3N0YXR1c19pbnN0YWxsX2Rsc3ltX2NvbmYKICAgIGlnX2hvb2tfMDAxICh2b2lk
KSBfX2F0dHJpYnV0ZV9fICgoY29uc3RydWN0b3IpKTsKICAgIHZvaWQKICAgIF9zbmRfZGxzeW1f
Y29uc3RydWN0b3JfX3NuZF9wY21faG9va19hdWRpb19zdGF0dXNfaW5zdGFsbF9kbHN5bV9jb25m
CiAgICBpZ19ob29rXzAwMSAodm9pZCkgewogICAgCSAgICBfc25kX2Rsc3ltX19zbmRfcGNtX2hv
b2tfYXVkaW9fc3RhdHVzX2luc3RhbGxfZGxzeW1fY29uZmlnX2hvb2sKICAgIF8wMDEubmV4dCA9
IHNuZF9kbHN5bV9zdGFydDsKICAgIAkgICAgX3NuZF9kbHN5bV9fc25kX3BjbV9ob29rX2F1ZGlv
X3N0YXR1c19pbnN0YWxsX2Rsc3ltX2NvbmZpZ19ob29rCiAgICBfMDAxLmRsc3ltX25hbWUgPSAi
X3NuZF9wY21faG9va19hdWRpb19zdGF0dXNfaW5zdGFsbCI7CiAgICAJICAgIF9zbmRfZGxzeW1f
X3NuZF9wY21faG9va19hdWRpb19zdGF0dXNfaW5zdGFsbF9kbHN5bV9jb25maWdfaG9vawogICAg
XzAwMS5kbHN5bV9wdHIgPSAodm9pZCAqKSZfc25kX3BjbV9ob29rX2F1ZGlvX3N0YXR1c19pbnN0
YWxsOwogICAgCSAgICBzbmRfZGxzeW1fc3RhcnQgPQogICAgJl9zbmRfZGxzeW1fX3NuZF9wY21f
aG9va19hdWRpb19zdGF0dXNfaW5zdGFsbF9kbHN5bV9jb25maWdfaG9va18wMDEKICAgIDsKICAg
IH07CgpXaGF0IGRvIEkgbWlzcz8KCkJlc3QgcmVnYXJkcwpKw7ZyZyBLcmF1c2UKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
