Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5A606A31A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=e98M6Q6q;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NN814RjH
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38E1960222;
	Mon, 23 Nov 2026 13:05:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38E1960222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435510;
	bh=I1aKXR9ijVo54fPsUtfQJc4pzK0oKnWRohZe99yK/0E=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=e98M6Q6q9DgnMTRbi/DlkZjxE5f3ydrId6OaqCodAdTdc15m5syixAQGZCDsiXuhr
	 69vVKoDIJhcw3XYUjLKqYjvls9BqJxLt9JsRWutWEbkm+0K12MwISaYycF3eMLbHt5
	 WEg8+sYJj9mukpgkM2DFnNo63C0mAJd1mCGHTtt8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1ED5FF80727; Mon, 23 Nov 2026 13:02:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9AE3F8071C;
	Mon, 23 Nov 2026 13:02:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C51A2F80537; Sat, 21 Nov 2026 23:02:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1795298555;
	b=SzaJA5yY2FLb82o9BdjEdIkqy6twU9LlvVEarRxr+qK9eOT01x8wEeKPkzhuEGpcgbwo
	 QDHDQ8muJb23FfwNC6jTUZFmMcHmxaK1YEFjf3EDksaPJVs4V4Fe8Tp3giJFhBldt1BGx
	 FN6bnsegLYRnBJGuqOni9IHf4LikVy57/udjkRp5gE3Z/slki1TY5i3hl7WkMuakrNUjc
	 Rha8ApEbX+x1eMw/c2SNDlcpnxMyug8wiMbEQewTVl2qxkc9iFF3FPj4x7Ks+63mW5E9S
	 Mgf8r6zzpzKDEiKbrb9NtAna36AzMYQFNsPjgfbAsxmL5Czls0H18RUosGeL+2XnidA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795298555;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=Kq52nqHKhSwi0ZaDW01NU9uGBLr+srghtEZL+eLhVgk=;
	b=es1LUpoSpWMehiJg8osMgjuxBjQtDOz5N2694jh+fZKYWRVKXTD1Qi7B5xB0AA7dIL8U
	 Fl/BO2pKmK1bOB6JH7pHnHDwf3IzemNZXVsgb8pD7/DSJ/C8tNN+VPJb0UKKaM+8uv+5a
	 61bm713ID3l95rEJjkVApHjenw1kWRiR5J0Giv8Qf8a39cYzCxiiLbyDH9GVoiTqoL02Q
	 TmZivfWLBqu8KK5kphQfjGCGDF9AmAk4bw+9emeSer04Z8ikGtI0H6OYy61EN4Gh5r0ys
	 enEIHrCXfmTR+88MmcmvjF9Q6/8mVqCzMMTrbdG6pluR+ic+xqUe9dKbaX6h1ye/htg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NN814RjH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8B82CF800C1
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2026 23:02:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B82CF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NN814RjH
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c505b2e1cb9so385737566b.2
        for <alsa-devel@alsa-project.org>;
 Sat, 21 Nov 2026 14:02:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795298553; cv=none;
        d=google.com; s=arc-20260327;
        b=X7DybJHYBitf6Q3ePrAZjff0ZjA4dUzSuya7YShydoKDY/CdnEIqTn7O4n1WpIYg3F
         UNoDoLgoyP0fcucKGaChvfI7E5fgREesTa2SimiGQTSPbV4XEnTGNw+sDoF3oepTR/Rn
         HQIHbbhnCCx/ZTELt1MgkaYTkF3OUEqCrhwRsI02LHOq5FIFm6CpCpSp/dX6RQOcYTfp
         dZIJ99U0xDQ6PE43VRx0Kz7KRMjmHwzleMKoEZ60Lifp1g6XhUKFqiI1CG62dZMcVSUV
         qaJqm+1fw9ZKNLrOKD9N6NdQIQx6ryy8XHV9l0hSnFsp3BwMG3+ps9qO0U29bU5m2Kcd
         u0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Kq52nqHKhSwi0ZaDW01NU9uGBLr+srghtEZL+eLhVgk=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=ObdqgnSbGSvxq0FFdMRyU2cheE3fkbPPpfpsX5Rfyp2KxpWQGaHtLdh+3+hzIOW4N1
         DzZiL9eEYesP+I+jCWDxpCWWhTrsrrq+JmGpUefuc21+HvOj6gG2WxTryVEL3JVuLLp8
         +Rd6ng7IRNjs2KN9+m1lK2VjTsinDR8z0JCQKpXYmwSLZszlfLCsRW6duJmRA91AwheJ
         2AaQIkoRm+bjcStYGXx02crrYLZGLJTl3OBT3+Ug8T24HcwrR7ptqc9bPYpTCFacFM9m
         ZstXBxEKwNgirvxotIVpQugVX2S+3CJQ8fOO7PnA0jPQByteyvIOdfSHz39iaHZi5+lg
         Fqxw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795298553; x=1795903353;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Kq52nqHKhSwi0ZaDW01NU9uGBLr+srghtEZL+eLhVgk=;
        b=NN814RjHTXgYgdUeTKfI04hMFWRSS3t2dw7GJq8Jz0Bfgqa21ostimaR8LR4wfSK3G
         t3Sq6lhE5LbPlKS38VziRgzq63tFzNH42WVbLdPaiftjmTqRuVh2u1aykCPkdx5DAAQl
         GHQ+3QP1wfitUehQXelse8N1FobCDtqjHqBA8xKUV+4VGFjB7qDk2tFZgdCK3S5nwnU1
         9RO/QDhiqiMW10V8HHczo7qf3pHZJrUkm+MhQJyRWYtikgQympmPBEska9x9uAG2ob79
         T8wxWSqwzH+7eGDSXZtFgupEkvYnPQsMytwfuxvOgbbjpmp9+gmSC4aV98pNMUxNB3jT
         WIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795298553; x=1795903353;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kq52nqHKhSwi0ZaDW01NU9uGBLr+srghtEZL+eLhVgk=;
        b=UJXFOJvVK9AkG3sLoL9j0w/zrrPrT/seo/ttA/cjMJRISGxktaddXGHlqwLTBkLgPc
         hdq8a9dQ73HrXdSWvfi2XqnPr8efO10tHhEAm95M7HFZ/g/gaXCPCITEGKTXQs9hJ/4q
         PX4XZxSghuLSM8J17d7TQeCpG2YrK8g+AJUa9sVC3m66SaW04pycNIRXpnkbUn18hGFd
         NC2thuS7GK4lBmzeLUQGXyUYj5TV52sTeZTaur0/JMsC1lhSVAdWP8/lMoeSEgTY2K8Y
         7hwpAlAWiM7Qe1Jg/DMFwj2o+ANEfobSezGXspyhV9+ebbJ13cdxKADgvjidE+rSPzqI
         37mQ==
X-Gm-Message-State: APuU4Z+o0OVWztrFrL+bHFDnKc0LOfD+YJlIT8F4MRJF7kbFWfgiWSaK
	bMzk5mXw2NRrSw76U7jWSGFPQiuVYOtrApGjFNzZO2B84pnRGgNg3Sxn3zBpLdiDzafnq6uzzPd
	7s3tbWiDiBPdC/FIn6tmoZwtBM9w+rPdjspjgeNw=
X-Gm-Gg: AZFdTZcrLTEukWgTbR4BoSceJrIYgSQ3/OWfKaghF5Md1prp2i8GNx6edH48vmspbl9
	UVbMfCeXwTccUjYQnaqtqlyxOK76mPjQ9t0dMf7ccp7FwifjvEHWUGE3SsvDcQH3m/+v6HMRiBx
	vETe6WkDhTbmtdL+5pRxdCEY9ybj0PvShw/KuaelioctiBqSkc9tjtao4HBZKotWSSjVCem+woH
	r0diT8+vAmUB+zcAZ6S6aA3v3UM6GbrCqLPrx92Wm2t7cCesPI7F4gDtNo0gvdJg+glyeg/Bm7s
	t4N6Ns0g1Vn/D24nAOCPTHs6kL9d1Yxl4DIyH6nB4oYZo2nB9e8TqKmEB8Lxf+EIrkmzkahETA9
	QOT9VX78mWo5lovpN2nMLElS7FHJ8bE2qFzPKfJq/3a4DPhfFy/6ojH1zMHbw
X-Received: by 2002:a17:906:409a:b0:c46:9d50:8af0 with SMTP id
 a640c23a62f3a-c513ac9a35bmr485325366b.36.1795298553375; Sat, 21 Nov 2026
 14:02:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Bhagavatiprasad Vaghela <hello.bhagavati@gmail.com>
Date: Sun, 22 Nov 2026 02:02:21 +0400
X-Gm-Features: Aa3M54pZT8jDLV0iwWspjTr4Irli0uq8zvHvmY-rEf3FoXjcxJ1wzE5ksiZv2tI
Message-ID: 
 <CAMiH3bUnzv0L3omU_TTFrAZ3gRf2FYoESk+to8uZG77vpFw7-A@mail.gmail.com>
Subject: [BUG] sof-essx8336 / es8326: internal speaker very quiet on Infinix
 INBOOK X1 NEO (Jasper Lake)
To: alsa-devel@alsa-project.org
Content-Type: multipart/mixed; boundary="0000000000008a72f20660d08485"
X-MailFrom: hello.bhagavati@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 5ICTANSACDQEHKR3IOVNQDA7PZUKPPIZ
X-Message-ID-Hash: 5ICTANSACDQEHKR3IOVNQDA7PZUKPPIZ
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:14 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5ICTANSACDQEHKR3IOVNQDA7PZUKPPIZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

--0000000000008a72f20660d08485
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a very quiet internal speaker on an Infinix INBOOK X1 NEO
laptop (Intel Celeron N5100, Jasper Lake) running Debian 13 with kernel
6.12.115. I would be grateful for any pointers on what to test.

Hardware
- Laptop: Infinix INBOOK X1 NEO (model XL22), BIOS from AMI Aptio
- Audio: sof-essx8336 machine driver with snd_soc_es8326 codec, SOF
firmware package firmware-sof-signed 2025.01-1
- ACPI device: ESSX8326:00 on I2C
- Kernel quirk mask reported by the driver: 0x1 (SSP1), no other quirks

Symptom
- The internal speaker plays but is very quiet.
- The headphone jack and Bluetooth audio work normally.
- The behaviour is the same on a Debian 13 live USB.
- [Windows on the same laptop: speaker is loud / normal. Please fill in.]

What I checked
- With the jack empty: Headphone Jack = off, Speaker switch = on, Headphone
switch = off, and the speakers-enable GPIO changes correctly between
plugged and unplugged states.
- All mixer controls are at maximum (SPKL, SPKR, HPL, DAC at 0 dB) and the
PipeWire volume is 100%.
- Disabling ACPI D3Cold in the BIOS fixed my touchpad but did not change
the speaker volume.
- [Other tests: power drain, HPVol SPKVol options, quirk values, older
kernels. Please fill in.]

I have collected the full details (DMI, dmesg audio lines, all mixer
controls, the ES8326 register dump, the ACPI/DSDT block for the audio
device, alsa-info) here: [link to your uploaded audio-report.tar.gz or
gist].

Please tell me if you need anything else, for example a register dump taken
under a different state or a test kernel. I am happy to run tests.

Thank you,
Bhagavatiprasad Vaghela
hello.bhagavati@gmail.com

--0000000000008a72f20660d08485
Content-Type: application/x-shellscript; name="collect-audio-report.sh"
Content-Disposition: attachment; filename="collect-audio-report.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_mwqyc59v0>
X-Attachment-Id: f_mwqyc59v0

IyEvdXNyL2Jpbi9lbnYgYmFzaAojIENvbGxlY3RzIGF1ZGlvIGhhcmR3YXJlL2RyaXZlciBpbmZv
IGZvciBhbiB1cHN0cmVhbSBidWcgcmVwb3J0LgojIFJFQUQtT05MWTogaXQgY2hhbmdlcyBub3Ro
aW5nIG9uIHlvdXIgc3lzdGVtLgojIFByaXZhY3k6IGl0IGRvZXMgTk9UIGNvbGxlY3Qgc2VyaWFs
IG51bWJlcnMsIE1BQyBhZGRyZXNzZXMsIGhvc3RuYW1lIG9yIGRpc2sgVVVJRHMuCiMgUnVuOiAg
YmFzaCBjb2xsZWN0LWF1ZGlvLXJlcG9ydC5zaCAgICAgIChpdCB3aWxsIGFzayBmb3IgeW91ciBz
dWRvIHBhc3N3b3JkKQojIFJlc3VsdDogfi9hdWRpby1yZXBvcnQvIChmb2xkZXIpIGFuZCB+L2F1
ZGlvLXJlcG9ydC50YXIuZ3ogKG9uZSBmaWxlIHRvIHVwbG9hZCkKCk9VVD0iJEhPTUUvYXVkaW8t
cmVwb3J0IgpybSAtcmYgIiRPVVQiOyBta2RpciAtcCAiJE9VVCIKc2VjKCkgeyBlY2hvOyBlY2hv
ICI9PT09PSAkMSA9PT09PSI7IH0KCnN1ZG8gLXYgfHwgZWNobyAic3VkbyBub3QgYXZhaWxhYmxl
OiBzb21lIHNlY3Rpb25zIHdpbGwgYmUgZW1wdHkiCgojIC0tLS0tLS0tLS0gMDEgc3lzdGVtIC0t
LS0tLS0tLS0KewpzZWMgIkRNSSAobm8gc2VyaWFsIG51bWJlcnMpIgpmb3IgZiBpbiBzeXNfdmVu
ZG9yIHByb2R1Y3RfbmFtZSBwcm9kdWN0X3ZlcnNpb24gcHJvZHVjdF9mYW1pbHkgYm9hcmRfdmVu
ZG9yIGJvYXJkX25hbWUgYm9hcmRfdmVyc2lvbiBiaW9zX3ZlbmRvciBiaW9zX3ZlcnNpb24gYmlv
c19kYXRlOyBkbwogIHByaW50ZiAnJXM6ICcgIiRmIjsgY2F0IC9zeXMvY2xhc3MvZG1pL2lkLyRm
IDI+L2Rldi9udWxsIHx8IGVjaG8gbi9hCmRvbmUKc2VjICJPUyIKZ3JlcCAtRSAnXihQUkVUVFlf
TkFNRXxWRVJTSU9OKT0nIC9ldGMvb3MtcmVsZWFzZQpzZWMgIktlcm5lbCIKdW5hbWUgLXIKc2Vj
ICJLZXJuZWwgY29tbWFuZCBsaW5lIChyb290IFVVSUQgcmVkYWN0ZWQpIgpzZWQgJ3Mvcm9vdD1V
VUlEPVteIF0qL3Jvb3Q9VVVJRD08cmVkYWN0ZWQ+LycgL3Byb2MvY21kbGluZQpzZWMgIkluc3Rh
bGxlZCBrZXJuZWxzIgpkcGtnIC1sICdsaW51eC1pbWFnZSonIDI+L2Rldi9udWxsIHwgZ3JlcCBe
aWkKc2VjICJBdWRpby1yZWxhdGVkIHBhY2thZ2VzIgpkcGtnIC1sIDI+L2Rldi9udWxsIHwgZ3Jl
cCAtaSAtRSAnZmlybXdhcmUtc29mfGFsc2EtdWNtfGFsc2EtdXRpbHN8cGlwZXdpcmUgfHdpcmVw
bHVtYmVyfGZpcm13YXJlLWludGVsJyAKc2VjICJTT0YgdG9wb2xvZ3kgZmlsZXMgZm9yIEVTODMz
NiIKbHMgLWwgL2xpYi9maXJtd2FyZS9pbnRlbC9zb2YtdHBsZy8gMj4vZGV2L251bGwgfCBncmVw
IC1pIC1FICdlczgzJwpzZWMgIm1vZHByb2JlLmQgYXVkaW8gc2V0dGluZ3MiCmdyZXAgLXIgLWkg
LUUgJ3NuZHxzb2Z8ZXM4MycgL2V0Yy9tb2Rwcm9iZS5kLyAyPi9kZXYvbnVsbApzZWMgIkNQVSIK
bHNjcHUgfCBncmVwIC1FICdNb2RlbCBuYW1lJwp9ID4gIiRPVVQvMDEtc3lzdGVtLnR4dCIgMj4m
MQoKIyAtLS0tLS0tLS0tIDAyIGF1ZGlvIGRyaXZlciAtLS0tLS0tLS0tCnsKc2VjICJBTFNBIGNh
cmRzIgpjYXQgL3Byb2MvYXNvdW5kL2NhcmRzCnNlYyAiUGxheWJhY2sgZGV2aWNlcyIKYXBsYXkg
LWwKc2VjICJMb2FkZWQgYXVkaW8gbW9kdWxlcyIKbHNtb2QgfCBncmVwIC1pIC1FICdzbmRfc29m
fGVzODN8ZXNzeHxzbmRfc29jfHNuZF9pbnRlbHxzbmRfaGRhJwpzZWMgIk1vZHVsZSBwYXJhbWV0
ZXJzIgpmb3IgbSBpbiAvc3lzL21vZHVsZS9zbmRfc29jX3NvZl9lczgzMzYgL3N5cy9tb2R1bGUv
c25kX2ludGVsX2RzcGNmZyAvc3lzL21vZHVsZS9zbmRfc29jX2VzODMyNjsgZG8KICBbIC1kICIk
bSIgXSAmJiB7IGVjaG8gIiRtIjsgZ3JlcCAtciAuICIkbS9wYXJhbWV0ZXJzIiAyPi9kZXYvbnVs
bDsgfQpkb25lCnNlYyAiUENJIGF1ZGlvIGRldmljZSIKbHNwY2kgLW5uayB8IGdyZXAgLWkgLUE0
IC1FICdhdWRpb3xtdWx0aW1lZGlhJwpzZWMgImRtZXNnOiBhdWRpbyBsaW5lcyAoSERNSSBJUEMg
ZXJyb3Igc3BhbSBzdXBwcmVzc2VkKSIKZWNobyAic3VwcHJlc3NlZCBIRE1JIGlwYyBlcnJvciBs
aW5lczogJChzdWRvIGRtZXNnIHwgZ3JlcCAtYyAnaXBjIHR4IGVycm9yJykiCnN1ZG8gZG1lc2cg
fCBncmVwIC1pIC1FICdzb2Z8ZXM4MzI2fGVzODMzNnxlc3N4fHNuZF98dHBsZ3xqYWNrfHNwZWFr
ZXInIHwgZ3JlcCAtdiAtRSAnaXBjIHR4IGVycm9yfHNvZl9pcGMzX3BjbV9od19wYXJhbXN8c25k
X3NvY19wY21fY29tcG9uZW50X2h3X3BhcmFtcycgfCBoZWFkIC0xNTAKfSA+ICIkT1VULzAyLWF1
ZGlvLWRyaXZlci50eHQiIDI+JjEKCiMgLS0tLS0tLS0tLSAwMyBtaXhlciAtLS0tLS0tLS0tCnsK
c2VjICJhbWl4ZXIgY29udGVudHMgKGFsbCBjb250cm9scyB3aXRoIHJhdyB2YWx1ZXMpIgphbWl4
ZXIgLWMgMCBjb250ZW50cwpzZWMgImFtaXhlciBzY29udGVudHMiCmFtaXhlciAtYyAwIHNjb250
ZW50cwp9ID4gIiRPVVQvMDMtbWl4ZXIudHh0IiAyPiYxCgojIC0tLS0tLS0tLS0gMDQgY29kZWMg
cmVnaXN0ZXJzIC0tLS0tLS0tLS0KewpzZWMgIkNvZGVjIHJlZ2lzdGVyIGR1bXAgKHJlZ21hcCki
ClI9JChzdWRvIGZpbmQgL3N5cy9rZXJuZWwvZGVidWcvcmVnbWFwIC1tYXhkZXB0aCAxIC1pbmFt
ZSAnKkVTU1gqJyAyPi9kZXYvbnVsbCB8IGhlYWQgLTEpCmlmIFsgLW4gIiRSIiBdICYmIFsgLWYg
IiRSL3JlZ2lzdGVycyIgXTsgdGhlbgogIGVjaG8gInNvdXJjZTogJFIvcmVnaXN0ZXJzIjsgc3Vk
byBjYXQgIiRSL3JlZ2lzdGVycyIKZWxzZQogIGVjaG8gIm5vIEVTU1ggcmVnbWFwIGZvdW5kIHVu
ZGVyIC9zeXMva2VybmVsL2RlYnVnL3JlZ21hcDoiOyBzdWRvIGxzIC9zeXMva2VybmVsL2RlYnVn
L3JlZ21hcCAyPiYxCmZpCn0gPiAiJE9VVC8wNC1jb2RlYy1yZWdpc3RlcnMudHh0IiAyPiYxCgoj
IC0tLS0tLS0tLS0gMDUgQUNQSSBkZXNjcmlwdGlvbiBvZiB0aGUgYXVkaW8gZGV2aWNlIC0tLS0t
LS0tLS0KewpzZWMgIkFDUEkgZGV2aWNlIGF0dHJpYnV0ZXMiCmZvciBkIGluIC9zeXMvYnVzL2Fj
cGkvZGV2aWNlcy9FU1NYKjsgZG8KICBbIC1lICIkZCIgXSB8fCBjb250aW51ZQogIGVjaG8gIi0t
ICRkIgogIGZvciBhIGluIGhpZCBwYXRoIHN0YXR1cyBtb2RhbGlhczsgZG8gcHJpbnRmICclczog
JyAiJGEiOyBjYXQgIiRkLyRhIiAyPi9kZXYvbnVsbDsgZG9uZQpkb25lCnNlYyAiSTJDIGRldmlj
ZXMiCmZvciBkIGluIC9zeXMvYnVzL2kyYy9kZXZpY2VzLyo7IGRvIHByaW50ZiAnJXM6ICcgIiQo
YmFzZW5hbWUgIiRkIikiOyBjYXQgIiRkL25hbWUiIDI+L2Rldi9udWxsOyBkb25lCnNlYyAiR1BJ
TyBsaW5lcyByZWxhdGVkIHRvIGF1ZGlvIgpzdWRvIGdyZXAgLWkgLUUgJ3Nwa3xzcGVha2VyfGhw
fGhlYWRwaG9uZXxtdXRlfGFtcCcgL3N5cy9rZXJuZWwvZGVidWcvZ3BpbyAyPi9kZXYvbnVsbApz
ZWMgIkRTRFQ6IGF1ZGlvIGRldmljZSBibG9jayAoZnJvbSB+L2FjcGktdHAvZHNkdC5kc2wpIgpE
PSIkSE9NRS9hY3BpLXRwL2RzZHQuZHNsIgppZiBbIC1mICIkRCIgXTsgdGhlbgogIGdyZXAgLW4g
LWkgLUUgJ0VTU1h8RVM4MzI2fEVTODMzNicgIiREIgogIGVjaG8gIi0tLS0gY29udGV4dCAtLS0t
IgogIGdyZXAgLW4gLWkgLUIzIC1BMTAwICdFU1NYODMyNicgIiREIiB8IGhlYWQgLTQwMAogIGVj
aG8gIi0tLS0gU1NEVCBmaWxlcyB0aGF0IG1lbnRpb24gRVNTWCAtLS0tIgogIGdyZXAgLWwgLWkg
J0VTU1gnICIkSE9NRSIvYWNwaS10cC8qLmRzbCAyPi9kZXYvbnVsbAplbHNlCiAgZWNobyAifi9h
Y3BpLXRwL2RzZHQuZHNsIG5vdCBmb3VuZC4gQ3JlYXRlIGl0IHdpdGg6IgogIGVjaG8gIiAgc3Vk
byBhcHQgaW5zdGFsbCBhY3BpY2EtdG9vbHM7IG1rZGlyIC1wIH4vYWNwaS10cCAmJiBjZCB+L2Fj
cGktdHAiCiAgZWNobyAiICBzdWRvIGFjcGlkdW1wID4gYWNwaS5vdXQgJiYgYWNwaXh0cmFjdCAt
YSBhY3BpLm91dCAmJiBpYXNsIC1kICouZGF0IgpmaQp9ID4gIiRPVVQvMDUtYWNwaS1hdWRpby50
eHQiIDI+JjEKCiMgLS0tLS0tLS0tLSAwNiBhbHNhLWluZm8gLS0tLS0tLS0tLQp7CkE9JChjb21t
YW5kIC12IGFsc2EtaW5mby5zaCB8fCBscyAvdXNyL3NiaW4vYWxzYS1pbmZvLnNoIDI+L2Rldi9u
dWxsKQppZiBbIC1uICIkQSIgXTsgdGhlbiBzdWRvICIkQSIgLS1zdGRvdXQ7IGVsc2UgZWNobyAi
YWxzYS1pbmZvLnNoIG5vdCBmb3VuZCAocGFja2FnZSBhbHNhLXV0aWxzKSI7IGZpCn0gPiAiJE9V
VC8wNi1hbHNhLWluZm8udHh0IiAyPiYxCgojIC0tLS0tLS0tLS0gMDcgbm90ZXMgdGVtcGxhdGUg
KHlvdSBmaWxsIHRoaXMgaW4pIC0tLS0tLS0tLS0KY2F0ID4gIiRPVVQvMDctTk9URVMtZmlsbC1p
bi50eHQiIDw8J0VPRicKRklMTCBUSElTIElOIEJFRk9SRSBTRU5ESU5HIChkZWxldGUgbGluZXMg
dGhhdCBkbyBub3QgYXBwbHkpCgpTeW1wdG9tOgotIEludGVybmFsIHNwZWFrZXIgcGxheXMgYnV0
IGlzIHZlcnkgcXVpZXQuIEhlYWRwaG9uZSBqYWNrIGFuZCBCbHVldG9vdGggYXVkaW8gYXJlIGZp
bmUuCi0gU2FtZSBvbiB0aGUgRGViaWFuIDEzIGxpdmUgVVNCIGFuZCBvbiB0aGUgaW5zdGFsbGVk
IHN5c3RlbS4KCldpbmRvd3M6Ci0gU3BlYWtlciBsb3VkbmVzcyBpbiBXaW5kb3dzIChzYW1lIGxh
cHRvcCwgc2FtZSB2b2x1bWUpOiAgW2xvdWQgLyBub3JtYWwgLyBxdWlldF0KLSBXaW5kb3dzIGF1
ZGlvIGRyaXZlciBuYW1lIC8gcHJvdmlkZXIgLyB2ZXJzaW9uIC8gZGF0ZTogICAgW2Zyb20gRGV2
aWNlIE1hbmFnZXIgPiBEcml2ZXIgdGFiXQotIFdpbmRvd3MgYXVkaW8gZGV2aWNlIEhhcmR3YXJl
IElEczogICAgICAgICAgICAgICAgICAgICAgICAgW0RldmljZSBNYW5hZ2VyID4gRGV0YWlscyA+
IEhhcmR3YXJlIElkc10KCldoYXQgSSBhbHJlYWR5IHRyaWVkIG9uIExpbnV4IChubyBjaGFuZ2Ug
aW4gbG91ZG5lc3MpOgotIEFsbCBtaXhlciB2b2x1bWVzIGF0IG1heGltdW0gKFNQS0wsIFNQS1Is
IEhQTCwgREFDKSwgUGlwZVdpcmUgdm9sdW1lIDEwMCUKLSBIZWFkcGhvbmVzIHVucGx1Z2dlZCwg
amFjayBzdGF0ZSAib2ZmIiwgU3BlYWtlciBzd2l0Y2ggb24sIEhlYWRwaG9uZSBzd2l0Y2ggb2Zm
Ci0gQklPUzogQUNQSSBEM0NvbGQgU3VwcG9ydCBkaXNhYmxlZCAoZml4ZWQgbXkgdG91Y2hwYWQs
IG5vIGVmZmVjdCBvbiBzcGVha2VyKQotIEZ1bGwgcG93ZXIgZHJhaW46ICAgICAgICAgICAgICAg
IFt0cmllZCAvIG5vdCB0cmllZCwgcmVzdWx0XQotICdIUFZvbCBTUEtWb2wnIGVudW0gb3B0aW9u
cyAwLTM6IFtyZXN1bHRdCi0gcXVpcms9MHgxMTogICAgICAgICAgICAgICAgICAgICAgW3RyaWVk
IC8gbm90IHRyaWVkLCByZXN1bHRdCi0gT2xkZXIga2VybmVscyA2LjEyLjk0IC8gNi4xMi4xMTM6
IFt0cmllZCAvIG5vdCB0cmllZCwgcmVzdWx0XQoKQ29udGFjdDogW3lvdXIgbmFtZV0sIFt5b3Vy
IGVtYWlsXQpFT0YKCnRhciBjemYgIiRIT01FL2F1ZGlvLXJlcG9ydC50YXIuZ3oiIC1DICIkSE9N
RSIgYXVkaW8tcmVwb3J0CmVjaG8KZWNobyAiRG9uZS4iCmVjaG8gIkZvbGRlciA6ICRPVVQiCmVj
aG8gIkFyY2hpdmU6ICRIT01FL2F1ZGlvLXJlcG9ydC50YXIuZ3ogKCQoZHUgLWggIiRIT01FL2F1
ZGlvLXJlcG9ydC50YXIuZ3oiIHwgY3V0IC1mMSkpIgplY2hvICJOZXh0ICAgOiBvcGVuIDA3LU5P
VEVTLWZpbGwtaW4udHh0LCBmaWxsIGl0IGluLCB0aGVuIHJlLWNyZWF0ZSB0aGUgYXJjaGl2ZSB3
aXRoOiIKZWNobyAiICAgICAgICAgdGFyIGN6ZiB+L2F1ZGlvLXJlcG9ydC50YXIuZ3ogLUMgfiBh
dWRpby1yZXBvcnQiCg==
--0000000000008a72f20660d08485--
