From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: How ALSA handle PCM playing when the ALSA modules
	are removing
Date: Wed, 23 Jan 2019 14:22:41 +0900
Message-ID: <64eca10a-f73b-46ea-0cc2-c8cdde99f216@sakamocchi.jp>
References: <130c0184-88f9-df56-ac32-98627a1acb0e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 074602674AC
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2019 06:22:45 +0100 (CET)
Received: by mail-pf1-f195.google.com with SMTP id u6so556653pfh.11
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 21:22:45 -0800 (PST)
In-Reply-To: <130c0184-88f9-df56-ac32-98627a1acb0e@linux.intel.com>
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
To: "Zhu, Yingjiang" <yingjiang.zhu@linux.intel.com>, alsa-devel@alsa-project.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

SGksCgooSSdtIGFub3RoZXIgVGFrYXNoaS4pCgpPbiAyMDE5LzAxLzIzIDE0OjAxLCBaaHUsIFlp
bmdqaWFuZyB3cm90ZToKPiAgwqDCoMKgIMKgwqDCoCBJIGFtIGRvaW5nIGFuIEFMU0EgbW9kdWxl
IHRlc3Qgd2l0aCBpbnNlcnQgbW9kdWxlL3JlbW92ZSBtb2R1bGUgCj4gbG9vcCwgd2hlbiBwbGF5
aW5nIGEgd2F2ZSBkdXJpbmcgdGhpcyBsb29wLCB0aGVyZSB3aWxsIGJlIGtlcm5lbCBvb3BzLiAK
Ckl0J3MganVzdCBhIGJ1ZyBvZiB5b3VyIG1vZHVsZXMuCgpMaW51eCBrZXJuZWwgbW9kdWxlIGlz
IG1haW50YWluZWQgYnkgcmVmZXJlbmNlIGNvdW50ZXIuIEluIExpbnV4IHNvdW5kCnN1YnN5c3Rl
bSwgd2hlbiBhcHBsaWNhdGlvbnMgb3BlbnMgYW55IGNoYXJhY3RlciBkZXZpY2VzIGFkZGVkIGJ5
IGRyaXZlcgptb2R1bGUsIHRoZSByZWZlcmVuY2UgY291bnRlciBpcyBpbmNyZW1lbnRlZCwgdGhl
biBpdCBjYW5ub3QgYmUgdW5sb2FkCnVudGlsIGFsbCBvZiBjaGFyYWN0ZXIgZGV2aWNlcyBhZGRl
ZCBieSB0aGUgbW9kdWxlIGFyZSByZWxlYXNlZCBieQphcHBsaWNhdGlvbnMuCgpJZiB5b3UgY2Fu
IHVubG9hZCB5b3VyIG1vZHVsZSBkdXJpbmcgdHJhbnNtaXNzaW9uIG9mIGF1ZGlvIGRhdGEgZnJh
bWUsCml0J3MgYXBwYXJlbnRseSBhIGJ1ZyBvZiB5b3VyIG1vZHVsZS4KCj4gRG9lcyBBTFNBIG5l
ZWQgaGFuZGxlIHRoaXMgY2FzZT8gT3IganVzdCBmb3JiaWQgd2F2ZSBwbGF5aW5nIGR1cmluZyB0
aGUgCj4gbW9kdWxlIGxvYWQvdW5sb2FkPwo+ICDCoMKgwqAgwqDCoMKgIElmIHRoaXMgbmVlZCB0
byBiZSBoYW5kbGVkLCBtb2R1bGUgdW5sb2FkIHdpbGwgd2FpdCB0aGUgd2F2ZSAKPiBwbGF5IGVu
ZGluZywgb3IganVzdCBzdG9wIHRoZSB3YXZlIHBsYXkgYXQgdGhlIGZpcnN0IG9mIHRoZSBsb2Fk
L3VubG9hZD8KCkFsbCBvZiBjaGFyYWN0ZXIgZGV2aWNlcyBmb3IgYSBzb3VuZCBjYXJkIGFyZSBh
c3NvY2lhdGVkIHRvIHNvdW5kIGNhcmQKc3RydWN0dXJlIChzdHJ1Y3Qgc25kX2NhcmQpLiBLZXJu
ZWwgbW9kdWxlcyBzaG91bGQgc2V0ICdkaXNjb25uZWN0ZWQnCnN0YXRlIHRvIHRoZSBzdHJ1Y3R1
cmUgaW4gaXRzIGNhbGxiYWNrIGZvciAucmVtb3ZlIGludm9rZWQgaW4KdW5sb2FkaW5nL3VuYmlu
ZGluZyBvcGVyYXRpb24uIFRoZW4gYXBwbGlhdGlvbnMgcmVjZWl2ZXMgZXJyb3JzIGluIEkvTwpv
cGVyYXRpb25zIHRvIHRoZSBjaGFyYWN0ZXIgZGV2aWNlLiBUaGUgYXBwbGljYXRpb25zIGFyZSBl
eHBlY3RlZCB0bwpjbG9zZSB0aGUgY2hhcmFjdGVyIGRldmljZS4gV2hlbiBhbGwgb2YgY2hhcmFj
dGVyIGRldmljZXMgYXJlIGNsb3NlZCwKdGhlbiBzb3VuZCBjYXJkIHN0cnVjdHVyZSBpcyBnb2lu
ZyB0byBiZSByZWxlYXNlZC4KCgpSZWdhcmRzCgpUYWthc2hpIFNha2Ftb3RvCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
