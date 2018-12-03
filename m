From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [PATCH] ASoC: pcm512x: Implement the digital_mute
	interface
Date: Mon, 3 Dec 2018 18:26:09 +0200
Message-ID: <95f88de0-ae1c-7618-7edf-9631d09d95ba@gmail.com>
References: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
 <20181126140200.GC9715@sirena.org.uk>
 <CAHEwa0BPZWFQLok5siyK7Dj43nChFF3sPwGxAO7ffpwheFdeBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A8041267AF1
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2018 17:26:13 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id q18so12825781wrx.9
 for <alsa-devel@alsa-project.org>; Mon, 03 Dec 2018 08:26:13 -0800 (PST)
In-Reply-To: <CAHEwa0BPZWFQLok5siyK7Dj43nChFF3sPwGxAO7ffpwheFdeBg@mail.gmail.com>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

UGluZ2luZyB0aGlzLCBpbiBjYXNlIGl0IHdhcyBidXJpZWQgdW5kZXIgb3RoZXIgbWVzc2FnZXMg
YW5kIGhhcwplc2NhcGVkIGF0dGVudGlvbi4KCk9uIDExLzI2LzE4IDk6MjMgUE0sIERpbWl0cmlz
IFBhcGF2YXNpbGlvdSB3cm90ZToKPiAgwqBTb3JyeSwgSSBwcm9iYWJseSBtaXN1bmRlcnN0YW5k
LsKgIERvIHlvdSBwcm9wb3NlIHJlbW92aW5nCj4gdGhlICJEaWdpdGFsIFBsYXliYWNrIFN3aXRj
aCIgY29udHJvbCBlbnRpcmVseT/CoCBJdCB3b3VsZAo+IGNlcnRhaW5seSBzaW1wbGlmeSB0aGlu
Z3MsIGFzIGZhciBhcyBpbXBsZW1lbnRpbmcgdGhlCj4gLmRpZ2l0YWxfbXV0ZSBjYWxsYmFjayBp
cyBjb25jZXJuZWQsIGJ1dCBpdCB3b3VsZCByZW1vdmUgdGhlIG9ubHkKPiB3YXkgb2YgbWFudWFs
bHkgbXV0aW5nIHRoZSBEQUMuwqAgVGhlICJEaWdpdGFsIFBsYXliYWNrIFZvbHVtZSIKPiBjb250
cm9sIGlzIHRoZSBtYWluIChhbmQgYmFzaWNhbGx5IHNvbGUsIGFwYXJ0IGZyb20gYSBzd2l0Y2hh
YmxlCj4gLTZkQiBhbmFsb2cgZ2FpbiBjb250cm9sKSB2b2x1bWUgY29udHJvbCBvZiB0aGUgREFD
IGFuZCByZW1vdmluZwo+IHRoZSBTd2l0Y2ggY29tcG9uZW50IHdvdWxkIG1ha2UgaXQgdW5tdXRh
YmxlLgo+IAo+IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIHVzZXMgdGhlIGNvbnRyb2wgdG8g
a2VlcCB0cmFjayBvZiB0aGUKPiB1c2VyJ3MgZGVzaXJlZCBtdXRlIHN0YXRlIGFuZCBhbGxvd3Mg
dGhlIC5kaWdpdGFsX211dGUgY2FsbGJhY2sgdG8KPiBvdmVycmlkZSBpdCwgaW4gYSB3YXkgdGhh
dCBpcyB0cmFuc3BhcmVudCB0byB0aGUgdXNlci4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
