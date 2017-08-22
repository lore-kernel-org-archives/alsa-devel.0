From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ALSA: pcsp: Use common error handling code in
 snd_card_pcsp_probe()
Date: Tue, 22 Aug 2017 16:36:35 +0200
Message-ID: <139363f6-e059-defb-357e-f18645ba9768@users.sourceforge.net>
References: <08ee0d6b-788b-2845-6964-e1e55c2d2292@users.sourceforge.net>
 <20170822121625.syvr64kwyh5xjexg@mwanda> <s5hziar9483.wl-tiwai@suse.de>
 <f138ba40-a61f-cdab-3d9b-699dbcacad9d@users.sourceforge.net>
 <s5ho9r792yl.wl-tiwai@suse.de>
 <fc4d8c96-7de2-e8f0-4cb4-5dda795d298a@users.sourceforge.net>
 <s5hbmn78zmg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C3BF266812
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 16:38:41 +0200 (CEST)
In-Reply-To: <s5hbmn78zmg.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

Pj4gSSBnb3QgdGhlIGltcHJlc3Npb24gdGhhdCB0aGUgZnVuY3Rpb25zIHdoaWNoIGFyZSBjYWxs
ZWQgYXQgdGhlIHVwZGF0ZWQgcGxhY2VzCj4+IGJ5IHRoZSBmdW5jdGlvbiDigJxzbmRfY2FyZF9w
Y3NwX3Byb2Jl4oCdIGluZGljYXRlIGEgc3VjY2Vzc2Z1bCBleGVjdXRpb24KPj4gb25seSBieSB6
ZXJvIHNvIGZhci4KPiAKPiBZb3UgaGF2ZSB0aGUgaW1wcmVzc2lvbiwgZ3JlYXQuCgpUaGlzIGFz
cGVjdCBpcyBhbHNvIGEgZ2VuZXJhbCBwcm9ncmFtbWluZyBpbnRlcmZhY2UgaXNzdWUgZm9yIHNv
bWUgZnVuY3Rpb25zLgoKCj4gQW5kIHdoYXQncyB0aGUgcmVhc29uIHRvIGRyb3AgdGhlIG5lZ2F0
aXZlIGNoZWNrPwoKKiBJIGZpbmQgaXQgYSBiaXQgc2FmZXIgd2hlbiB0aGUgZXJyb3IgcHJlZGlj
YXRlIGlzIOKAnHJldHVybiB2YWx1ZSAhPSAw4oCdLgoKKiBJdCBpcyBhbHNvIGEgc21hbGwgc291
cmNlIGNvZGUgcmVkdWN0aW9uLgoKCj4gSXQncyBub3QgY2xlYXJlciwgbm90IGJldHRlciByZWFk
YWJsZS4KCkl0IHNlZW1zIHRoYXQgd2UgaGF2ZSBnb3QgZGlmZmVyZW50IGRldmVsb3BtZW50IG9w
aW5pb25zIHRoaXMgdGltZS4KCgo+IEFuZCwgdGhlIHdvcnN0IHBhcnQgaXMgdGhhdCB5b3UndmUg
ZG9uZSBpdCBzaWxlbnRseSBldmVuIHdpdGhvdXQKPiBtZW50aW9uaW5nIGluIHRoZSBjaGFuZ2Ug
bG9nIGF0IGFsbC4gIFRoYXQncyByZWFsbHkgYmFkLgo+IEp1c3QgZG9uJ3QgZG8gaXQuCgpJIGZv
dW5kIGl0IG5vdCByZWxldmFudCBlbm91Z2ggZm9yIHRoZSBjb21taXQgbWVzc2FnZS4KCgo+IEZv
ciBleGFtcGxlLCB0aGUgY29udHJvbCBBUEkgZnVuY3Rpb25zIG1heSByZXR1cm4gdGhlIHBvc2l0
aXZlIG51bWJlcgo+IHdoZW4gdGhlIHZhbHVlIGdvdCBjaGFuZ2VkLCAwIGZvciBlbHNlLCBhbmQg
YSBuZWdhdGl2ZSBudW1iZXIgZm9yIHRoZQo+IGVycm9yLiAgVGhlIGZ1bmN0aW9ucyByZXR1cm5p
bmcgc29tZSBudW1iZXJzIG1heSByZXR1cm4gcG9zaXRpdmUKPiBudW1iZXJzLCBvZiBjb3Vyc2Uu
CgpEaWQgSSB0b3VjaCBhbnkgc3BlY2lmaWMgZnVuY3Rpb24gY2FsbHMgd2hpY2ggYmVsb25nIHRv
IHRoaXMKcHJvZ3JhbW1pbmcgaW50ZXJmYWNlIGNhdGVnb3J5PwoKUmVnYXJkcywKTWFya3VzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
