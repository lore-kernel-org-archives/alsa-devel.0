From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4/9 v2] ALSA: usb-audio: use
	usb_fill_int_urb()
Date: Wed, 20 Jun 2018 15:52:49 +0200
Message-ID: <20180620135249.rcr4dkka5jkrattl@linutronix.de>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
 <20180619215521.13688-5-bigeasy@linutronix.de>
 <ce8ffb2b-35e8-1108-9065-81f4d3cb4d8d@cogentembedded.com>
 <20180620093827.ei6bqkkb4ahk3hbn@linutronix.de>
 <s5hlgb9mw42.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEC22673CB
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 15:52:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hlgb9mw42.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, tglx@linutronix.de, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: alsa-devel@alsa-project.org

T24gMjAxOC0wNi0yMCAxNToyMTo0OSBbKzAyMDBdLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4gPiB1
c2JfZmlsbF9pbnRfdXJiKCkgZW5zdXJlcyB0aGF0IHN5bmNpbnRlcnZhbCBpcyB3aXRoaW4gdGhl
IGFsbG93ZWQgcmFuZ2UKPiA+IG9uIEhTL1NTLiBUaGUgaW50ZXJ2YWwgdmFsdWUgc2VlbXMgdG8g
Y29tZSBmcm9tCj4gPiBzbmRfdXNiX3BhcnNlX2RhdGFpbnRlcnZhbCgpIHdoaWNoIGlzIGJJbnRl
cnZhbCAtIDEgYW5kIG9ubHkgaW4gdGhlIHJhZ2UKPiA+IDEg4oCmIDQuIFNvIGluIG9yZGVyIHRv
IGtlZXAgdGhlIG1hZ2ljIHdvcmtpbmcgSSBwYXNzIGRhdGFpbnRlcnZhbCArIDEuCj4gCj4gVGhp
cyBuZWVkcyBtb3JlIGV4cGxhbmF0aW9uLiAgQnkgdGhpcyBjb252ZXJzaW9uLCB0aGUgaW50ZXJ2
YWwKPiBjb21wdXRhdGlvbiBiZWNvbWVzIHJlYWxseSB0cmlja3kuCj4gCj4gVGhlcmUgYXJlIHR3
byBpbnRlcnZhbCBjYWxjdWxhdGlvbnMuICBUaGUgZmlyc3Qgb25lIGlzCj4gZnAtPmRhdGFpbnRl
cnZhbCBhbmQgaXQncyBmcm9tIHNuZF91c2JfcGFyc2VfZGF0YWludGVydmFsKCkgYXMgeW91Cj4g
bWVudGlvbmVkLiAgQW5kIGEgdHJpY2t5IHBhcnQgaXMgdGhhdCBmcC0+ZGF0YWludGVydmFsIGlz
IDAgb24KPiBGVUxMX1NQRUVELiAgQ2FzdWFsbHksIGZwLT5kYXRhaW50ZXJ2YWwrMSB3aWxsIGJl
IHRyYW5zbGF0ZWQgdG8gdGhlCj4gY29ycmVjdCB2YWx1ZSBzaW5jZSAoMCArIDEpID09ICgxIDw8
IDApLgo+IAo+IE9UT0gsIGZvciB0aGUgc3luYyBFUCwgaXQncyB0YWtlbiBmcm9tIGVwLT5zeW5j
aW50ZXJ2YWwsIHdoaWNoIGlzIHNldAo+IGluIHNuZF91c2JfYWRkX2VuZHBvaW50KCkuICBMdWNr
aWx5LCBhZ2FpbiwgZXAtPnN5bmNpbnRlcnZhbCArIDEgd29ya3MKPiBmb3IgRlVMTF9TUEVFRCBh
cyB3ZWxsLCBhcyAoMSArIDEpID09ICgxIDw8IDEpLgoKRG8geW91IHdhbnQgbWUgdG8gYWRkIHlv
dXIgYWRkaXRpb25hbCBleHBsYW5hdGlvbiB0byB0aGUgZGVzY3JpcHRpb24/CiAKPiB0aGFua3Ms
Cj4gCj4gVGFrYXNoaQoKU2ViYXN0aWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
