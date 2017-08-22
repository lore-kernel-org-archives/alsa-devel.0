From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ALSA: pcsp: Use common error handling code in
 snd_card_pcsp_probe()
Date: Tue, 22 Aug 2017 17:03:00 +0200
Message-ID: <b434f976-33a1-7ced-55b5-b55487f2fb14@users.sourceforge.net>
References: <08ee0d6b-788b-2845-6964-e1e55c2d2292@users.sourceforge.net>
 <20170822121625.syvr64kwyh5xjexg@mwanda> <s5hziar9483.wl-tiwai@suse.de>
 <f138ba40-a61f-cdab-3d9b-699dbcacad9d@users.sourceforge.net>
 <s5ho9r792yl.wl-tiwai@suse.de>
 <fc4d8c96-7de2-e8f0-4cb4-5dda795d298a@users.sourceforge.net>
 <s5hbmn78zmg.wl-tiwai@suse.de>
 <139363f6-e059-defb-357e-f18645ba9768@users.sourceforge.net>
 <s5h378j8xos.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 86338266812
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 17:03:08 +0200 (CEST)
In-Reply-To: <s5h378j8xos.wl-tiwai@suse.de>
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

Pj4gKiBJIGZpbmQgaXQgYSBiaXQgc2FmZXIgd2hlbiB0aGUgZXJyb3IgcHJlZGljYXRlIGlzIOKA
nHJldHVybiB2YWx1ZSAhPSAw4oCdLgo+IAo+IENhbid0IGFncmVlLgoKSG93IGRvIHlvdSB0aGlu
ayBhYm91dCB0byByZWR1Y2UgdGhlIHByb2JhYmlsaXR5IHRoYXQgcG9zaXRpdmUgcmV0dXJuIHZh
bHVlcwp3aWxsIGFjY2lkZW50YWxseSBiZSBpbnRlcnByZXRlZCBhcyBhIHN1Y2Nlc3NmdWwgZnVu
Y3Rpb24gZXhlY3V0aW9uLgoKCj4gQW5kIEkgaGF2ZSBubyBpbnRlcmVzdCB0byBjb250aW51ZSBi
aWtlLXNoZWRkaW5nLCBzb3JyeS4KCkkgZG8gbm90IGxpa2UgdGhhdCB5b3UgcHJlZmVyIHRvIHB1
dCB0aGlzIHRlY2huaWNhbCBkZXRhaWwgaW50byBzdWNoCmEgY29tbXVuaWNhdGlvbiBjYXRlZ29y
eS4KCgo+IFlvdSBjYW4ndCBjb252aW5jZSBtZSByZWdhcmRpbmcgdGhpcy4KCldvdWxkIHlvdSBz
dGlsbCBsaWtlIHRvIGludGVncmF0ZSB0aGUgcHJvcG9zZWQgcmVmYWN0b3Jpbmcgd2l0aCB0aGUg
dXNlCm9mIHByZXZpb3VzIGZhaWx1cmUgcHJlZGljYXRlcyB0aGVuPwoKUmVnYXJkcywKTWFya3Vz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
