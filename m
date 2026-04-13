Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE61EBFD16
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:17:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB3986020B;
	Mon, 13 Apr 2026 11:16:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB3986020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776071828;
	bh=ek+SZp4pwN0DgSYhrDZI0dT97w8R2qST41JNkezWQP4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=b7L+3R94kiT8HvL/ot6cW5SWEyfPt9m/5JaqgkGepdq+2tnADG6BbrdhILj6dSXIH
	 anSXKvzjV80FTJtWXbQxQV80gO30mym7OuOZ63TPmEsQLZnR7+Wb7LK6Q6YNtTU+Qm
	 P2Nio/43EspLKWLTmZ2XCXnJctv93NF3dmIlKLT4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D175F805F3; Mon, 13 Apr 2026 11:16:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EA0AF805EA;
	Mon, 13 Apr 2026 11:16:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB86FF80537; Mon, 13 Apr 2026 11:16:24 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9CB8DF800EE
	for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2026 11:16:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CB8DF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=HeU0jZcH
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63D9G7Je83969815,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776071767; bh=Zo3zlnGt5c4Fs/ZJiy32Vy9AabpNQrlyB+owBC1LIgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version;
	b=HeU0jZcHRkqCW2XTi4gbBsk/Qn876Cvf2xKFgJ2wQHGOX4neayEqgsE0tw4nqGvRg
	 HfTZ9e4GkJqus2gvN9xlexVC3pADk0sLU/i6XF27XlkGIq/xw07+MbeQ5K3lUkaOHS
	 JhXmKWfzjJ52UmbxEUZQn/GfqC12+bytSL58Jpl+MzGl0a2WRAeAdEQfDH5Lj061Z9
	 mGvSscFo+Q1WWif64WqNdqMVJywZ2LDFFts3Li+QjnduA1O8m1rxByWRL/wHHGAd2D
	 8ZTP0p9Gs6PPB+fxsOQEz+/P/oxLzp3b537JsH/RmFLyvVISoRknpxazhXLS+XeUUY
	 ReJqaKtlraaAw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63D9G7Je83969815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 17:16:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 13 Apr 2026 17:16:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 13 Apr 2026 17:16:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 13 Apr 2026 17:16:07 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>,
        =?iso-8859-1?Q?J=E9r=E9my_Bethmont?=
	<jeremy.bethmont@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>
Subject: RE: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC287)
 after commit d2e01e0c5e94
Thread-Topic: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC287)
 after commit d2e01e0c5e94
Thread-Index: AQHcsCEJ0ioheXDhmUiIGGE8KvE4VLWmzTwAgAAbEQCAAAJMAIA2AOEQ
Date: Mon, 13 Apr 2026 09:16:07 +0000
Message-ID: <f59a70ca796b4d09822f514e7f25ac5c@realtek.com>
References: 
 <CAC88DfsHrhyhy0Pn1O-z9egBvMYu=6NYgcvcC6KCgwh_-Ldkxg@mail.gmail.com>
	<87a4wgrxil.wl-tiwai@suse.de>
	<CAC88DfvjQvZvdvGdZ00woMymE2tUWk=2Dbqi3EzuzSHxGjEnzw@mail.gmail.com>
 <871phsrsnf.wl-tiwai@suse.de>
In-Reply-To: <871phsrsnf.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.21.6.42]
Content-Type: multipart/mixed;
	boundary="_002_f59a70ca796b4d09822f514e7f25ac5crealtekcom_"
MIME-Version: 1.0
Message-ID-Hash: LME3SDDE235TTVVSYKAQKTECHLHJVM6Z
X-Message-ID-Hash: LME3SDDE235TTVVSYKAQKTECHLHJVM6Z
X-MailFrom: kailang@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LME3SDDE235TTVVSYKAQKTECHLHJVM6Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_f59a70ca796b4d09822f514e7f25ac5crealtekcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

You can test attach patch.

BR,
Kailang

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Tuesday, March 10, 2026 4:33 PM
To: J=E9r=E9my Bethmont <jeremy.bethmont@gmail.com>
Cc: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org; regressions=
@lists.linux.dev; regressions@leemhuis.info
Subject: Re: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC28=
7) after commit d2e01e0c5e94


External mail : This email originated from outside the organization. Do not=
 reply, click links, or open attachments unless you recognize the sender an=
d know the content is safe.



On Tue, 10 Mar 2026 09:24:38 +0100,
J=E9r=E9my Bethmont wrote:
>
> Hi Takashi,
>
> Thank you for looking into this so quickly.
>
> As requested, I have attached the output of `alsa-info.sh --no-upload`=20
> from my machine.
>
> Please let me know if you have a proposed patch you would like me to=20
> test. I am happy to build it and verify if it resolves the popping on=20
> my hardware.

I guess dropping the alc_process_coef_fw(codec, en_coefs) call at closing w=
ould fix your problem while keeping the one at open.
But I'm not sure about any side-effect by that.
Kailang, could you check this?

BTW, when you disable runtime PM, does the pop noise still appears?


thanks,

Takashi

>
> Best regards,
> Jeremy
>
> On Tue, 10 Mar 2026 at 13:47, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Tue, 10 Mar 2026 01:01:11 +0100,
> > J=E9r=E9my Bethmont wrote:
> > >
> > > Hi Takashi, Kailang,
> > >
> > > I am reporting an audio regression introduced in kernel 6.18.13 on=20
> > > the Lenovo ThinkPad X1 Carbon Gen 12 (Meteor Lake, Realtek ALC287=20
> > > codec,
> > > SSID: 0x17aa231e).
> > >
> > > Since this update, the laptop emits a short, noticeable hardware=20
> > > pop/blip from the speakers exactly when an audio stream closes and=20
> > > the PCM state suspends. It happens consistently a few seconds=20
> > > after playback finishes (e.g., after a system notification or=20
> > > terminal bell).
> > >
> > > I have tracked the regression down to the following commit:
> > > d2e01e0c5e947da0b5005ca89efa82baeb232adc ("ALSA: hda/realtek -=20
> > > fixed speaker no sound")
> > >
> > > #regzbot introduced: d2e01e0c5e947da0b5005ca89efa82baeb232adc
> > >
> > > Root cause analysis:
> > > The commit modifies the `alc287_alc1318_playback_pcm_hook`=20
> > > function, adding raw COEF writes to disable/enable AMP silence=20
> > > detection on HDA_GEN_PCM_ACT_OPEN and HDA_GEN_PCM_ACT_CLOSE.
> > >
> > > Because `alc287_alc1318_playback_pcm_hook` is a shared hook used=20
> > > by multiple Lenovo ALC287/ALC1318 devices, these unconditional=20
> > > `WRITE_COEF` instructions are being sent to hardware that does not=20
> > > need the silence detection fix. On the X1 Carbon Gen 12, executing=20
> > > `alc_process_coef_fw(codec, en_coefs)` upon stream close triggers=20
> > > an immediate electrical pop. Monitoring with `pw-mon` confirms the=20
> > > hardware pop coincides perfectly with the monitor_FR / monitor_FL=20
> > > ports going idle/suspended.
> > >
> > > Proposed solution:
> > > Could we revert this commit, or alternatively, wrap these specific=20
> > > silence-detection COEF writes in a targeted `ALC287_FIXUP` quirk=20
> > > matched via SSID/DMI, rather than executing them globally in the=20
> > > shared playback hook?
> >
> > Could you give alsa-info.sh output?  Run the script with --no-upload=20
> > option and attach the output.
> >
> > I guess the bug might not be specific to your device but happening=20
> > in general with all matching ones.  As a workaround for such a pop=20
> > noise, we often need to reorder verbs or put some delay between verbs.
> >
> >
> > Takashi
>
>
>
> --
> J=E9r=E9my Bethmont
>

--_002_f59a70ca796b4d09822f514e7f25ac5crealtekcom_
Content-Type: application/octet-stream; name="0000-x1-gen12-speaker.patch"
Content-Description: 0000-x1-gen12-speaker.patch
Content-Disposition: attachment; filename="0000-x1-gen12-speaker.patch";
	size=2204; creation-date="Mon, 13 Apr 2026 09:14:44 GMT";
	modification-date="Tue, 12 Nov 2024 06:16:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5NWI2NGJmYzI2YzQ5MmNhMmZiZmYxNzE4ZmRmNDBmN2RhNDk5YjRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMTIgTm92IDIwMjQgMTQ6MDM6NTMgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIHVwZGF0ZSBzZXQgR1BJTzMgdG8gZGVmYXVsdCBmb3IgVGhpbmtwYWQg
d2l0aCBBTEMxMzE4CgpJZiB1c2VyIG5vIHVwZGF0ZSBCSU9TLCB0aGUgc3BlYWtlciB3aWxsIG5v
IHNvdW5kLgpUaGlzIHBhdGNoIHN1cHBvcnQgb2xkIEJJT1MgdG8gaGF2ZSBzb3VuZCBmcm9tIHNw
ZWFrZXIuCgpGaXhlczogMWU3MDc3NjlkZjA3ICgiQUxTQTogaGRhL3JlYWx0ZWsgLSBTZXQgR1BJ
TzMgdG8gZGVmYXVsdCBhdCBTNCBzdGF0ZSBmb3IgVGhpbmtwYWQgd2l0aCBBTEMxMzE4IikKU2ln
bmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgpkaWZmIC0tZ2l0
IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYwppbmRleCA3NGNhMGJiNmMwOTEuLmQ4M2IyOWY5YTcwZiAxMDA2NDQKLS0tIGEvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKQEAgLTc0NTAsNyArNzQ1MCw2IEBAIHN0YXRpYyB2b2lkIGFsYzI4N19hbGMxMzE4X3Bs
YXliYWNrX3BjbV9ob29rKHN0cnVjdCBoZGFfcGNtX3N0cmVhbSAqaGluZm8sCiAJCQkJICAgc3Ry
dWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiAJCQkJICAgaW50IGFjdGlvbikKIHsK
LQlhbGNfd3JpdGVfY29lZl9pZHgoY29kZWMsIDB4MTAsIDB4ODgwNik7IC8qIENoYW5nZSBNTEsg
dG8gR1BJTzMgKi8KIAlzd2l0Y2ggKGFjdGlvbikgewogCWNhc2UgSERBX0dFTl9QQ01fQUNUX09Q
RU46CiAJCWFsY193cml0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDVhLCAweDAwLCAweDk1NGYpOyAv
KiB3cml0ZSBncGlvMyB0byBoaWdoICovCkBAIC03NDY0LDcgKzc0NjMsNiBAQCBzdGF0aWMgdm9p
ZCBhbGMyODdfYWxjMTMxOF9wbGF5YmFja19wY21faG9vayhzdHJ1Y3QgaGRhX3BjbV9zdHJlYW0g
KmhpbmZvLAogc3RhdGljIHZvaWQgYWxjMjg3X3M0X3Bvd2VyX2dwaW8zX2RlZmF1bHQoc3RydWN0
IGhkYV9jb2RlYyAqY29kZWMpCiB7CiAJaWYgKGlzX3M0X3N1c3BlbmQoY29kZWMpKSB7Ci0JCWFs
Y193cml0ZV9jb2VmX2lkeChjb2RlYywgMHgxMCwgMHg4ODA2KTsgLyogQ2hhbmdlIE1MSyB0byBH
UElPMyAqLwogCQlhbGNfd3JpdGVfY29lZmV4X2lkeChjb2RlYywgMHg1YSwgMHgwMCwgMHg1NTRm
KTsgLyogd3JpdGUgZ3BpbzMgYXMgZGVmYXVsdCB2YWx1ZSAqLwogCX0KIH0KQEAgLTc0NzMsOSAr
NzQ3MSwxNyBAQCBzdGF0aWMgdm9pZCBhbGMyODdfZml4dXBfbGVub3ZvX3RoaW5rcGFkX3dpdGhf
YWxjMTMxOChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIAkJCSAgICAgICBjb25zdCBzdHJ1Y3Qg
aGRhX2ZpeHVwICpmaXgsIGludCBhY3Rpb24pCiB7CiAJc3RydWN0IGFsY19zcGVjICpzcGVjID0g
Y29kZWMtPnNwZWM7CisgICAgICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY29lZl9mdyBjb2Vmc1td
ID0geworCQlXUklURV9DT0VGKDB4MjQsIDB4MDAxMyksIFdSSVRFX0NPRUYoMHgyNSwgMHgwMDAw
KSwgV1JJVEVfQ09FRigweDI2LCAweEMzMDApLAorCQlXUklURV9DT0VGKDB4MjgsIDB4MDAwMSks
IFdSSVRFX0NPRUYoMHgyOSwgMHhiMDIzKSwKKwkJV1JJVEVfQ09FRigweDI0LCAweDAwMTMpLCBX
UklURV9DT0VGKDB4MjUsIDB4MDAwMCksIFdSSVRFX0NPRUYoMHgyNiwgMHhDMzAxKSwKKwkJV1JJ
VEVfQ09FRigweDI4LCAweDAwMDEpLCBXUklURV9DT0VGKDB4MjksIDB4YjAyMyksCisgICAgICAg
IH07CiAKIAlpZiAoYWN0aW9uICE9IEhEQV9GSVhVUF9BQ1RfUFJFX1BST0JFKQogCQlyZXR1cm47
CisJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHgxMCwgMTw8MTEsIDE8PDExKTsKKwlhbGNf
cHJvY2Vzc19jb2VmX2Z3KGNvZGVjLCBjb2Vmcyk7CiAJc3BlYy0+cG93ZXJfaG9vayA9IGFsYzI4
N19zNF9wb3dlcl9ncGlvM19kZWZhdWx0OwogCXNwZWMtPmdlbi5wY21fcGxheWJhY2tfaG9vayA9
IGFsYzI4N19hbGMxMzE4X3BsYXliYWNrX3BjbV9ob29rOwogfQo=

--_002_f59a70ca796b4d09822f514e7f25ac5crealtekcom_--
