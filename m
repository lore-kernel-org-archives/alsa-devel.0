From: Paul Stone <metabagel@icloud.com>
Subject: mono/stereo translation & number of frames per period
Date: Thu, 30 Mar 2017 20:03:13 +0000 (GMT)
Message-ID: <c803630b-965e-40fa-be7b-e16c8682431f@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from st11p00im-asmtp002.me.com (st11p00im-asmtp002.me.com
 [17.172.80.96]) by alsa0.perex.cz (Postfix) with ESMTP id 1682D267153
 for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2017 22:03:17 +0200 (CEST)
Received: from process-dkim-sign-daemon.st11p00im-asmtp002.me.com by
 st11p00im-asmtp002.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 id <0ONN0030085DYJ00@st11p00im-asmtp002.me.com> for
 alsa-devel@alsa-project.org; Thu, 30 Mar 2017 20:03:16 +0000 (GMT)
Received: from st13p13im-spool002.me.com ([17.164.57.97])
 by st11p00im-asmtp002.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 with ESMTP id <0ONN00BVS91EGH10@st11p00im-asmtp002.me.com> for
 alsa-devel@alsa-project.org; Thu, 30 Mar 2017 20:03:14 +0000 (GMT)
Received: from localhost ([17.164.56.54]) by st13p13im-spool002.mac.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 with ESMTP id <0ONN009BD91EWB10@st13p13im-spool002.mac.com> for
 alsa-devel@alsa-project.org; Thu, 30 Mar 2017 20:03:14 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SSB0aG91Z2h0IHRoYXQgc2ltcGx5IGJ5IHJlcG9ydGluZyB0aGF0IG15IGRyaXZlciBvbmx5IHN1
cHBvcnRzIHR3byBjaGFubmVscywgdGhhdCBJIGNvdWxkIHNpbXBseSB1dGlsaXplIGEgbWl4ZXIg
b3IgdGhhdCBBTFNBIHdvdWxkIGF1dG9tYXRpY2FsbHkgc3VwcG9ydCBzZW5kaW5nIGFuZCByZWNl
aXZpbmcgbW9uYXVyYWwgZGF0YSB0by9mcm9tIG15IHN0ZXJlby1vbmx5IGRyaXZlci4gVWx0aW1h
dGVseSzCoEkgd2Fzbid0IGFibGUgdG8gbWFrZSBpdCB3b3JrLsKgSXMgdGhpcyBhIG1vZGUgb2Yg
b3BlcmF0aW9uIHRoYXQgQUxTQSBzdXBwb3J0cywgb3IgZG9lcyBBTFNBIHJlcXVpcmUgdGhlIGRy
aXZlciB0byBzdXBwb3J0IHNpbmdsZS1jaGFubmVsIG9wZXJhdGlvbiBpbiBvcmRlciB0byBzZW5k
L3JlY2VpdmUgbW9uYXVyYWwgZGF0YT8KClNvLCBJIGRlY2lkZWQgdGhhdCBJIHNob3VsZCBzdXBw
b3J0IGJvdGjCoG1vbm8gYW5kwqBzdGVyZW8gaW4gdGhlIGRyaXZlci4gSXTCoGFwcGVhcnMgdGhh
dCBBTFNBIGxvb2tzIGF0IHRoZSBtaW5pbXVtIHBlcmlvZCBzaXplIGFuZCBkZWNpZGVzIHRvIHNl
bmQgdGhhdCBtdWNoIGF1ZGlvIGRhdGEgZm9yIHBsYXliYWNrLiBUaGUgbWluaW11bSBwZXJpb2Qg
c2l6ZSBpcyBpbiBieXRlcywgd2hpY2ggbWVhbnMgdGhhdCB0aGUgbnVtYmVyIG9mIG1vbm8gYW5k
IHN0ZXJlbyBmcmFtZXMgcGVyIHBlcmlvZCB3aWxsIGRpZmZlci4gVGhpcyBpbnRyb2R1Y2VzIGEg
Yml0IG9mIGFkZGl0aW9uYWwgdW53YW50ZWQgY29tcGxleGl0eS4gSSdtIHdvbmRlcmluZyBpZiB0
aGVyZSBpcyBhIHdheSBmb3IgQUxTQSB0byBzdXBwb3J0IGEgZml4ZWQgbnVtYmVyIG9mIGZyYW1l
cyBwZXIgcGVyaW9kLiBJIHNlZcKgdGhhdCB0aGVyZSBpcyBhIGJpdCBmaWVsZCBTTkRSVl9QQ01f
SU5GT19GSUZPX0lOX0ZSQU1FUywgYW5kIGEgZmlmb19zaXplIGgvdyBwYXJhbWV0ZXIsIGJ1dCBJ
J20gbm90IHN1cmUgaG93IHRoaXMgcmVsYXRlcyB0byB0aGUgcGVyaW9kIHNpemUuCgpJIGZlZWwg
bGlrZSB0aGlzIGlzIGEgY29tbW9uIG1vZGUgb2Ygb3BlcmF0aW9uIChmaXhlZCBudW1iZXIgb2Yg
ZnJhbWVzIHBlciBwZXJpb2QsIHJlZ2FyZGxlc3Mgb2YgdGhlIG51bWJlciBvZiBjaGFubmVscyks
IGFuZCB0aGF0IGl0J3MgbGlrZWx5IHN1cHBvcnRlZCBieSBBTFNBLCBidXQgSSBkb24ndCBrbm93
IGhvdyBpdCdzIHN1cHBvc2VkIHRvIHdvcmsuIFNob3VsZCBJIHNldCB1cCBhIHJ1bGUgdG8gYWx0
ZXIgdGhlIG1pbmltdW0gcGVyaW9kIHNpemUsIGJhc2VkIG9uIHRoZSBudW1iZXIgb2YgY2hhbm5l
bHM/CgpCZXN0IFJlZ2FyZHMsClBhdWwgU3RvbmUKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
