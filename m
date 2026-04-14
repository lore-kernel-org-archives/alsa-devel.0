Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729BCED7B84
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:58:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B88A8601F9;
	Tue, 14 Apr 2026 09:57:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B88A8601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776153477;
	bh=ahyyL0hoThB6eEOEI7KmgBsb1w1DyVwbbai/b9v7e74=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NxzQyvjwYaXPC/L9uNO8lK+n3GI+SIoTmMfJs+M4QGhxA1mckyBNtht5Psookg+y3
	 q72sfpGB3T05RbxpLylwktNsygM1SjcAXO4LN9K8n6uftwRsdzOOTGmWfA21VIuCEW
	 UZNrVpK823QdhrR6xcNWDRjCE8KUketlGO4g+f8c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1DFDF805EF; Tue, 14 Apr 2026 09:57:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74DABF805F2;
	Tue, 14 Apr 2026 09:57:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1384EF80510; Tue, 14 Apr 2026 09:57:15 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 228F8F800C1
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2026 09:57:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 228F8F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=fO0hTp0+
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63E7v1LG11625572,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776153421; bh=rxLxK2G66zyFnPgu2tZtbGHOkl0zHIw/bwfv/rqiMBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version;
	b=fO0hTp0+/eaWLQmax6fm8s9aAD3+KxSFExS9qSUHfOWbWXH0rVIOvN3cmv3WDQA9d
	 g2+ore44ZxgwbUZyFHKYWuQcMX8RjWSZ2KPPu69DYIhEnTJ+SyNuIVcK8A3CpsMOoE
	 B1niv1VhjtDyJeeTA4EAtDmSu0hmU8fewfihyAK+tWyWPg24aBM4thB9Nq1AM6ngmq
	 OSREnRJKg2r4r3jqvbSzrXafLN18zjuTG7q2HWNPNVviXNx0o6NxvXmFquEUfLgpiv
	 ODmgOY2rsAObpCuXJ4FTmAgog2jqnm7hE7faK87QqHKuFCfeP+Yhv6YFqun2sF1VuP
	 HaAFS7K97XzDA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63E7v1LG11625572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 15:57:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 15:57:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 14 Apr 2026 15:57:00 +0800
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
Thread-Index: 
 AQHcsCEJ0ioheXDhmUiIGGE8KvE4VLWmzTwAgAAbEQCAAAJMAIA2AOEQgADgZoCAAIeEwP//hW6AgAAEaoCAAIqosA==
Date: Tue, 14 Apr 2026 07:57:00 +0000
Message-ID: <c0c7f6edb6e7417a9b51fc2308ec31e4@realtek.com>
References: 
 <CAC88DfsHrhyhy0Pn1O-z9egBvMYu=6NYgcvcC6KCgwh_-Ldkxg@mail.gmail.com>
	<87a4wgrxil.wl-tiwai@suse.de>
	<CAC88DfvjQvZvdvGdZ00woMymE2tUWk=2Dbqi3EzuzSHxGjEnzw@mail.gmail.com>
	<871phsrsnf.wl-tiwai@suse.de>	<f59a70ca796b4d09822f514e7f25ac5c@realtek.com>
	<CAC88DftEBEEEvODGUZzkry+kgAm=SfH=PAsxwu+SABMBMRMs=Q@mail.gmail.com>
	<658f53ada52f4de9a0c852dd56554a2a@realtek.com>
	<CAC88DfvyuWeD99hhKKsHum+wpjjQrOKsdWvKVZMefjhcx3sKBw@mail.gmail.com>
 <871pgit2hk.wl-tiwai@suse.de>
In-Reply-To: <871pgit2hk.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.21.6.42]
Content-Type: multipart/mixed;
	boundary="_002_c0c7f6edb6e7417a9b51fc2308ec31e4realtekcom_"
MIME-Version: 1.0
Message-ID-Hash: ACEGKQCPP6HIB4AXIPDQYOYBBZCEY3IN
X-Message-ID-Hash: ACEGKQCPP6HIB4AXIPDQYOYBBZCEY3IN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ACEGKQCPP6HIB4AXIPDQYOYBBZCEY3IN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_c0c7f6edb6e7417a9b51fc2308ec31e4realtekcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

OK.
Attached.

Thanks.

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Tuesday, April 14, 2026 3:39 PM
To: J=E9r=E9my Bethmont <jeremy.bethmont@gmail.com>
Cc: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org; regressions=
@lists.linux.dev; regressions@leemhuis.info
Subject: Re: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC28=
7) after commit d2e01e0c5e94


External mail : This email originated from outside the organization. Do not=
 reply, click links, or open attachments unless you recognize the sender an=
d know the content is safe.



On Tue, 14 Apr 2026 09:23:31 +0200,
J=E9r=E9my Bethmont wrote:
>
> Hi Kailang, Takashi,
>
> I can confirm that applying this patch completely resolves the issue!
>
> I compiled and tested it on my ThinkPad X1 Carbon Gen 12 (ALC287)=20
> running kernel 6.19.11. The hardware popping noise upon PCM suspend is=20
> entirely gone.
>
> Thank you both for your incredible work on this. You can add my=20
> Tested-by tag when this gets merged upstream:
>
> Tested-by: Jeremy Bethmont <jeremy.bethmont@gmail.com>
>
> Best regards,
> Jeremy

Good to hear!

Kailang, please submit a proper fix patch for merging.


thanks,

Takashi

>
> On Tue, 14 Apr 2026 at 13:44, Kailang <kailang@realtek.com> wrote:
> >
> > Sorry!! Attached wrong file.
> > Attached again.
> >
> > -----Original Message-----
> > From: J=E9r=E9my Bethmont <jeremy.bethmont@gmail.com>
> > Sent: Tuesday, April 14, 2026 2:37 PM
> > To: Kailang <kailang@realtek.com>
> > Cc: Takashi Iwai <tiwai@suse.de>; alsa-devel@alsa-project.org;=20
> > regressions@lists.linux.dev; regressions@leemhuis.info
> > Subject: Re: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12=20
> > (ALC287) after commit d2e01e0c5e94
> >
> >
> > External mail : This email originated from outside the organization. Do=
 not reply, click links, or open attachments unless you recognize the sende=
r and know the content is safe.
> >
> >
> >
> > Hi Kailang,
> >
> > Thank you for the patch. However, I believe you may have attached the w=
rong file by mistake.
> >
> > The attached patch ("0000-x1-gen12-speaker.patch") is dated November 12=
, 2024. Its commit message mentions fixing an issue with older BIOS version=
s.
> >
> > Could you please double-check?
> >
> > Best regards,
> > Jeremy
> >
> > On Mon, 13 Apr 2026 at 16:16, Kailang <kailang@realtek.com> wrote:
> > >
> > > Hi Jeremy,
> > >
> > > You can test attach patch.
> > >
> > > BR,
> > > Kailang
> > >
> > > -----Original Message-----
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Sent: Tuesday, March 10, 2026 4:33 PM
> > > To: J=E9r=E9my Bethmont <jeremy.bethmont@gmail.com>
> > > Cc: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org;=20
> > > regressions@lists.linux.dev; regressions@leemhuis.info
> > > Subject: Re: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen=20
> > > 12
> > > (ALC287) after commit d2e01e0c5e94
> > >
> > >
> > > External mail : This email originated from outside the organization. =
Do not reply, click links, or open attachments unless you recognize the sen=
der and know the content is safe.
> > >
> > >
> > >
> > > On Tue, 10 Mar 2026 09:24:38 +0100, J=E9r=E9my Bethmont wrote:
> > > >
> > > > Hi Takashi,
> > > >
> > > > Thank you for looking into this so quickly.
> > > >
> > > > As requested, I have attached the output of `alsa-info.sh=20
> > > > --no-upload` from my machine.
> > > >
> > > > Please let me know if you have a proposed patch you would like=20
> > > > me to test. I am happy to build it and verify if it resolves the=20
> > > > popping on my hardware.
> > >
> > > I guess dropping the alc_process_coef_fw(codec, en_coefs) call at clo=
sing would fix your problem while keeping the one at open.
> > > But I'm not sure about any side-effect by that.
> > > Kailang, could you check this?
> > >
> > > BTW, when you disable runtime PM, does the pop noise still appears?
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > > >
> > > > Best regards,
> > > > Jeremy
> > > >
> > > > On Tue, 10 Mar 2026 at 13:47, Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > > On Tue, 10 Mar 2026 01:01:11 +0100, J=E9r=E9my Bethmont wrote:
> > > > > >
> > > > > > Hi Takashi, Kailang,
> > > > > >
> > > > > > I am reporting an audio regression introduced in kernel=20
> > > > > > 6.18.13 on the Lenovo ThinkPad X1 Carbon Gen 12 (Meteor=20
> > > > > > Lake, Realtek
> > > > > > ALC287 codec,
> > > > > > SSID: 0x17aa231e).
> > > > > >
> > > > > > Since this update, the laptop emits a short, noticeable=20
> > > > > > hardware pop/blip from the speakers exactly when an audio=20
> > > > > > stream closes and the PCM state suspends. It happens=20
> > > > > > consistently a few seconds after playback finishes (e.g.,=20
> > > > > > after a system notification or terminal bell).
> > > > > >
> > > > > > I have tracked the regression down to the following commit:
> > > > > > d2e01e0c5e947da0b5005ca89efa82baeb232adc ("ALSA: hda/realtek=20
> > > > > > - fixed speaker no sound")
> > > > > >
> > > > > > #regzbot introduced:=20
> > > > > > d2e01e0c5e947da0b5005ca89efa82baeb232adc
> > > > > >
> > > > > > Root cause analysis:
> > > > > > The commit modifies the `alc287_alc1318_playback_pcm_hook`
> > > > > > function, adding raw COEF writes to disable/enable AMP=20
> > > > > > silence detection on HDA_GEN_PCM_ACT_OPEN and HDA_GEN_PCM_ACT_C=
LOSE.
> > > > > >
> > > > > > Because `alc287_alc1318_playback_pcm_hook` is a shared hook=20
> > > > > > used by multiple Lenovo ALC287/ALC1318 devices, these=20
> > > > > > unconditional `WRITE_COEF` instructions are being sent to=20
> > > > > > hardware that does not need the silence detection fix. On=20
> > > > > > the X1 Carbon Gen 12, executing `alc_process_coef_fw(codec,=20
> > > > > > en_coefs)` upon stream close triggers an immediate=20
> > > > > > electrical pop. Monitoring with `pw-mon` confirms the=20
> > > > > > hardware pop coincides perfectly with the monitor_FR / monitor_=
FL ports going idle/suspended.
> > > > > >
> > > > > > Proposed solution:
> > > > > > Could we revert this commit, or alternatively, wrap these=20
> > > > > > specific silence-detection COEF writes in a targeted=20
> > > > > > `ALC287_FIXUP` quirk matched via SSID/DMI, rather than=20
> > > > > > executing them globally in the shared playback hook?
> > > > >
> > > > > Could you give alsa-info.sh output?  Run the script with=20
> > > > > --no-upload option and attach the output.
> > > > >
> > > > > I guess the bug might not be specific to your device but=20
> > > > > happening in general with all matching ones.  As a workaround=20
> > > > > for such a pop noise, we often need to reorder verbs or put some =
delay between verbs.
> > > > >
> > > > >
> > > > > Takashi
> > > >
> > > >
> > > >
> > > > --
> > > > J=E9r=E9my Bethmont
> > > >
> >
> >
> >
> > --
> > J=E9r=E9my Bethmont
>
>
>
> --
> J=E9r=E9my Bethmont

--_002_c0c7f6edb6e7417a9b51fc2308ec31e4realtekcom_
Content-Type: application/octet-stream;
	name="0000-x1-gen12-speaker-pop.patch"
Content-Description: 0000-x1-gen12-speaker-pop.patch
Content-Disposition: attachment; filename="0000-x1-gen12-speaker-pop.patch";
	size=2354; creation-date="Tue, 14 Apr 2026 07:55:42 GMT";
	modification-date="Tue, 14 Apr 2026 07:55:25 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkOTNiZTY5ODQyMTNiZDAzM2RmZjU0YWUzNDcyMmYyNDk1ZDJhNmU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMTQgQXByIDIwMjYgMTU6NDQ6MDQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIGZpeGVkIHNwZWFrZXIgbm8gc291bmQgdXBkYXRlCgpGaXhlZCBzcGVh
a2VyIGhhcyBwb3Agbm9pc2UuCgpGaXhlczogNjMwZmJjNmU4NzBlICgiQUxTQTogaGRhL3JlYWx0
ZWsgLSBmaXhlZCBzcGVha2VyIG5vIHNvdW5kIikKVGVzdGVkLWJ5OiBKZXJlbXkgQmV0aG1vbnQg
PGplcmVteS5iZXRobW9udEBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEthaWxhbmcgWWFuZyA8
a2FpbGFuZ0ByZWFsdGVrLmNvbT4KZGlmZiAtLWdpdCBhL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRl
ay9hbGMyNjkuYyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwppbmRleCAyY2Yx
Y2MzY2I5MWMuLjcyZDE5ZjE4MDg4MSAxMDA2NDQKLS0tIGEvc291bmQvaGRhL2NvZGVjcy9yZWFs
dGVrL2FsYzI2OS5jCisrKyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwpAQCAt
MzY1NCwyMiArMzY1NCwxMSBAQCBzdGF0aWMgdm9pZCBhbGMyODdfYWxjMTMxOF9wbGF5YmFja19w
Y21faG9vayhzdHJ1Y3QgaGRhX3BjbV9zdHJlYW0gKmhpbmZvLAogCQkJCSAgIHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCQkJCSAgIGludCBhY3Rpb24pCiB7Ci0Jc3RhdGlj
IGNvbnN0IHN0cnVjdCBjb2VmX2Z3IGRpc19jb2Vmc1tdID0gewotCQlXUklURV9DT0VGKDB4MjQs
IDB4MDAxMyksIFdSSVRFX0NPRUYoMHgyNSwgMHgwMDAwKSwgV1JJVEVfQ09FRigweDI2LCAweEMy
MDMpLAotCQlXUklURV9DT0VGKDB4MjgsIDB4MDAwNCksIFdSSVRFX0NPRUYoMHgyOSwgMHhiMDIz
KSwKLQl9OyAvKiBEaXNhYmxlIEFNUCBzaWxlbmNlIGRldGVjdGlvbiAqLwotCXN0YXRpYyBjb25z
dCBzdHJ1Y3QgY29lZl9mdyBlbl9jb2Vmc1tdID0gewotCQlXUklURV9DT0VGKDB4MjQsIDB4MDAx
MyksIFdSSVRFX0NPRUYoMHgyNSwgMHgwMDAwKSwgV1JJVEVfQ09FRigweDI2LCAweEMyMDMpLAot
CQlXUklURV9DT0VGKDB4MjgsIDB4MDA4NCksIFdSSVRFX0NPRUYoMHgyOSwgMHhiMDIzKSwKLQl9
OyAvKiBFbmFibGUgQU1QIHNpbGVuY2UgZGV0ZWN0aW9uICovCi0KIAlzd2l0Y2ggKGFjdGlvbikg
ewogCWNhc2UgSERBX0dFTl9QQ01fQUNUX09QRU46Ci0JCWFsY19wcm9jZXNzX2NvZWZfZncoY29k
ZWMsIGRpc19jb2Vmcyk7CiAJCWFsY193cml0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDVhLCAweDAw
LCAweDk1NGYpOyAvKiB3cml0ZSBncGlvMyB0byBoaWdoICovCiAJCWJyZWFrOwogCWNhc2UgSERB
X0dFTl9QQ01fQUNUX0NMT1NFOgotCQlhbGNfcHJvY2Vzc19jb2VmX2Z3KGNvZGVjLCBlbl9jb2Vm
cyk7CiAJCWFsY193cml0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDVhLCAweDAwLCAweDU1NGYpOyAv
KiB3cml0ZSBncGlvMyBhcyBkZWZhdWx0IHZhbHVlICovCiAJCWJyZWFrOwogCX0KQEAgLTM2OTIs
MTAgKzM2ODEsMTUgQEAgc3RhdGljIHZvaWQgYWxjMjg3X2ZpeHVwX2xlbm92b190aGlua3BhZF93
aXRoX2FsYzEzMTgoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsCiAJCVdSSVRFX0NPRUYoMHgyNCwg
MHgwMDEzKSwgV1JJVEVfQ09FRigweDI1LCAweDAwMDApLCBXUklURV9DT0VGKDB4MjYsIDB4QzMw
MSksCiAJCVdSSVRFX0NPRUYoMHgyOCwgMHgwMDAxKSwgV1JJVEVfQ09FRigweDI5LCAweGIwMjMp
LAogCX07CisJc3RhdGljIGNvbnN0IHN0cnVjdCBjb2VmX2Z3IGRpc19jb2Vmc1tdID0geworCQlX
UklURV9DT0VGKDB4MjQsIDB4MDAxMyksIFdSSVRFX0NPRUYoMHgyNSwgMHgwMDAwKSwgV1JJVEVf
Q09FRigweDI2LCAweEMyMDMpLAorCQlXUklURV9DT0VGKDB4MjgsIDB4MDAwNCksIFdSSVRFX0NP
RUYoMHgyOSwgMHhiMDIzKSwKKwl9OyAvKiBEaXNhYmxlIEFNUCBzaWxlbmNlIGRldGVjdGlvbiAq
LwogCiAJaWYgKGFjdGlvbiAhPSBIREFfRklYVVBfQUNUX1BSRV9QUk9CRSkKIAkJcmV0dXJuOwog
CWFsY191cGRhdGVfY29lZl9pZHgoY29kZWMsIDB4MTAsIDE8PDExLCAxPDwxMSk7CisJYWxjX3By
b2Nlc3NfY29lZl9mdyhjb2RlYywgZGlzX2NvZWZzKTsKIAlhbGNfcHJvY2Vzc19jb2VmX2Z3KGNv
ZGVjLCBjb2Vmcyk7CiAJc3BlYy0+cG93ZXJfaG9vayA9IGFsYzI4N19zNF9wb3dlcl9ncGlvM19k
ZWZhdWx0OwogCXNwZWMtPmdlbi5wY21fcGxheWJhY2tfaG9vayA9IGFsYzI4N19hbGMxMzE4X3Bs
YXliYWNrX3BjbV9ob29rOwo=

--_002_c0c7f6edb6e7417a9b51fc2308ec31e4realtekcom_--
