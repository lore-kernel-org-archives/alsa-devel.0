Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA78AC55175
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:38:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B10A601EF;
	Mon,  3 Aug 2026 11:37:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B10A601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785749876;
	bh=OIaiFi+mW+j+QuXtVDlnERytpRMhtImnUig2nDAuWos=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=KfJxhWPOycOs1BywVCWg08AzGLxpkFwajldvDT8lhI+XV/sZSd1LylzD6MVM6Ce7r
	 ZdiigZeINnjmdokBuCKCcolvHqrfcTyAfTILVZiJ0souvenfve+d+LHmuEfgSF87nr
	 t6WssQheRYrXl8OV7k9M4UkMVu5uOSAQQwX4p9KU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44690F8063A; Mon,  3 Aug 2026 11:37:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 06535F8063A;
	Mon,  3 Aug 2026 11:37:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6338F804F3; Sun,  2 Aug 2026 01:00:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785625249;
	b=oFVhfq3yYNy2F5hkcqsfxHaaRslkJmR9HF1yr+UHSwLyYFVS/JWago4do+kE2j9tqull
	 fBEscqUZkIiD+1KakbPUcPY1kMrUQL5PpoCCj4WGA8oxwWsNK5TTiXx/sUqUqPBbeCcY3
	 88qNZkzhKdF7hKYWq20M2nCGSOnaGt+m/lrHdnUI87u7dUQKQpistWcAwRtnDdWAPZtsM
	 vpr2EfWyeM5wH/KQPuRJzyUrLTJKRpDdanId/aVFQbbUt/rB9j/yGTJsqNPpQfQUi3jZ5
	 vcp3A2eECLTwAdFpxaTqM9I5qfCpG2YJmwhBKeUUjSCMeZG/wvmYPtoVCcPjlLI9iaw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785625249;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=JEaUVZBQHljtc0jwQz+Cv3ZFJ4OMCSlUD7uqwTG9Dmg=;
	b=X0dEnm8w/R1/jIr0DRH8gI1I7X2/2HyrOrHCe1vF/wEF8lMV79MQ3v/OwuVoRlsJaMku
	 hWJfYRFsNw1udzpdsxJXSuNJk3AFEH5OiD4CuAkrsHKBnd4BteGG8walCIEVCnqO2Z95w
	 e3VFIKelmci8xqwUyYApjb45DxSvMKv7tWHPvE0pKF/3BcNPxpbEst4ZOO8Npur1sAFiY
	 KCUJ5fg8HWIyBgSK8cFG6Lw2iWKsRsqSw3L4+0U15N0/rk0HniNI0iBz6kRLT03jNsznB
	 Dl+0Cr1Zxp26JAQMRlLx3Ie0Umq9000d2NwP/MElJ7KFO4U3XahXca08m2Ch+UACy0Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XghPkqB+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6EF90F8024C
	for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2026 01:00:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EF90F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XghPkqB+
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-667b0ced2d3so3268843d50.2
        for <alsa-devel@alsa-project.org>;
 Sat, 01 Aug 2026 16:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785625246; cv=none;
        d=google.com; s=arc-20260327;
        b=RKdTCIRLM0pOpitKnCdd32hE1yRsgRC8dVhtjhCoHEFapbsX6VKStidXuH8AtEQRdd
         TWKvESEsu2Jdjcgg8zC6MoG21fHWCpXrxAKYNtvgNm4Zmgn/Brz07WULRfyfzp6Sq0f0
         0WOrOgE7O2j+uAod7s/EnSVM+p5J71lR2nvLTc/Ti8cQb500LYZW8w4lyr5i1zJGPCvr
         h9bjYI4UIfGhTCYRhDVN9w4emynnDLtLbwtYT1UutPxD7ACYvqG6MZCHP55WTHxiYBKz
         oEHA69kKx9f22zdzUBP47Wods9Vp2olUm17JPmlH1ODzheemv5yGzbFvkIvu2z2aWei4
         vZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LLSLHtNcKi8dp8WILp2YTfJ47xo3xTSo53c97Tb/Vws=;
        fh=D3jyEVY5qnZUNuYR0TrfGXQ1WJefQkO4YF9NMUrcKqg=;
        b=PBBEawe/2vlfSPG9VCkgqS5R80Lilcui/WluvvNCH8ztCV1rE3AkY2eWtq7MiRZgwd
         FuNK+dkGs6BDotk4cnr6CNxn9ICarOx1eDH2Ma7HOlDXLqLVTE2PW1JJQl1ZrZaOubrL
         7cJ0bNPcRj7zsr5/xXsVbjfT5nw/+0h4qcAchRUwnBmFcAQGXJqxcz6LAvDZS/4dBSpm
         9fL3GQYpWmCEJY4beaK5vwXF0bO6ARglqkRXMyWYngRX6WVM6yiOaYMdrKDGJ34B//Wg
         2NQUlBrELA5fAlxG3F/ScZQMQq16DfvtviNFC+FuEd95eElu7pMwQmmcZuh3ol60YW6T
         N3NQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785625246; x=1786230046;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LLSLHtNcKi8dp8WILp2YTfJ47xo3xTSo53c97Tb/Vws=;
        b=XghPkqB+04AJdCunrcfodV4IzrVZP66+ujF0u5FWffr1J8rQMzQNZSCyCUboDIcciE
         6K3RSlmJSVwVC9CZwuAUfUOC2RakDPoyUn9YgdBs2+karrx1nnp7Qz46uTh0TcxLQtR8
         F+9kQyCNuIPqp+eDNTCzPpdgwZgLuIGKHamxfBYtqJeVdRpILbVmO6aPowKuVeEvGOr6
         XBgXkmU2fNOR0Wkyj95wZR7B6lkE76jw8zvpGhTzJDI9nNimv3Wi/z+lDM0p9IGSjmFU
         5oApw/XNEwxtZVY2Y1458HuKtgQ0feFZNbTPfKNTRHwCxipXYHjZJ/+eZhlRb9rmyi4x
         +Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785625246; x=1786230046;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LLSLHtNcKi8dp8WILp2YTfJ47xo3xTSo53c97Tb/Vws=;
        b=H8wHEKXCDcJuxWuk7S08ODVWyImuAbqt23bzSXJB2aG1AnJukVQs13NXE7kvDwEXGY
         bfcz1t0G+Al4zbAuY/acfyFIGA55/dQmXgkvbmfH/QErQh3u5q4j9LypcjFbOGZsiHbk
         uw7YJDK9MbyJUIx1aTtNCPfXto3hYxH0SVMOx9mw9TitELpCxmHV6XJX257HQ+Z3qMd8
         n26tg09wB29MQXqZQkOyZKfEDXhdOXSadf7tP3rw/FBxEgyGf8Ruj0Zpf9gk1oyPgZll
         qR6sZYzrwy9ju6rXubTSlRPF21k8dFi7T+RA6ou6OK5Mlggd0JYAu7QqWOSkfd0PK6DD
         DdBA==
X-Gm-Message-State: AOJu0Yx/K4x2iinE+okzhDsrfoN/Dk9671NePNEUAyhH8Dw8Cd3boKp9
	HH4sdaXQtqsLGsKNVDg5SetNcXw7zoCUia1fwMkE00kVbzGlszuBljh5O52TLRMWj5blNWJTNsK
	oiHeSEG2rjuIPA+V8n+lwRGGt3XujZ9kv2PIZ7xNfjw==
X-Gm-Gg: AR+sD13v59UofZ6BU5RrqHNlA7cJIKSehDXN00wpvqIXyRxyR2NSeC52LZmdnjtLlZj
	kxP/uFUUvz4deFu6kAOqcDaw8hOHDHJZbK4hdzMMyOIO+pIxI3b1GcG3cJ4E5o4WK777wpxj3aW
	LLEY5MzxWiTXfOpxDJf4nFVc93OHc9UH2qw74YKvxLfJ/TUWvPt9quy3Z89o/bihM849plXvOCx
	Z5wyOkAOA+UyRck40DDqvrXo4/K8J48lakIif9nQmtPo0Q/TwbcYwhnActpMP5FQbqm/U+fydzK
	RqrWtITclRoE8y1llWaIbvkZQ+PLCB6dXuZwnDPhPCl7NH990krQWtSTbtjQXoPZeD9rPEy2jhD
	R1UypnRLt180JgGZE5rqmGDXGJ1R7rPbwHA==
X-Received: by 2002:a53:a789:0:b0:668:2553:a194 with SMTP id
 956f58d0204a3-6694f277ba3mr5424614d50.45.1785625246009; Sat, 01 Aug 2026
 16:00:46 -0700 (PDT)
MIME-Version: 1.0
From: Gemayel Lira <gemayellira@gmail.com>
Date: Sat, 1 Aug 2026 20:00:22 -0300
X-Gm-Features: AUfX_mxOb40xnoRfK9PDpNB-A-51rxTJShmEZYVvTTrqcWOspGYyZFRH9IaYZdA
Message-ID: 
 <CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com>
Subject: [PATCH] ALSA: hda/cs35l41: Add DSD property override for ASUS
 UX3405CA
To: alsa-devel@alsa-project.org
Cc: sbinding@opensource.cirrus.com, tiwai@suse.de
Content-Type: multipart/mixed; boundary="0000000000007dd328065804467a"
X-MailFrom: gemayellira@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GH5C5RG4756IKJ2WTGKNIAMDYRIO5QMF
X-Message-ID-Hash: GH5C5RG4756IKJ2WTGKNIAMDYRIO5QMF
X-Mailman-Approved-At: Mon, 03 Aug 2026 09:36:56 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GH5C5RG4756IKJ2WTGKNIAMDYRIO5QMF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--0000000000007dd328065804467a
Content-Type: text/plain; charset="UTF-8"

The ASUS Zenbook 14 UX3405CA (SSID 1043:1A63) has internal CS35L41
amplifiers, but was using the missing_speaker_id_gpio2 fallback entry.
This caused the right speaker channel to bind with VSPK voltage switch
disabled
(VSPK: 0), leading to a volume drop ~1 second after starting playback due to
power imbalance protection.

Add an explicit entry for 10431A63 in cs35l41_config_table with internal
boost
type, 4500mA peak current, and switch its model mapping to
generic_dsd_config.
This resolves the volume drop issue and enables proper internal boost for
both channels.

Pull Request on SOF Project:
https://github.com/thesofproject/linux/pull/5866

Signed-off-by: Gemayel Lira <gemayellira@gmail.com>

--0000000000007dd328065804467a
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-ALSA-hda-cs35l41-Add-DSD-property-override-for-ASUS-UX3405CA.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-cs35l41-Add-DSD-property-override-for-ASUS-UX3405CA.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msaz1mv40>
X-Attachment-Id: f_msaz1mv40

RnJvbSAxMDQzMUE2MzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZW1heWVsIExpcmEgPGdlbWF5ZWxsaXJhQGdtYWlsLmNvbT4K
RGF0ZTogU2F0LCAxIEF1ZyAyMDI2IDE5OjE1OjAwIC0wMzAwClN1YmplY3Q6IFtQQVRDSF0gQUxT
QTogaGRhL2NzMzVsNDE6IEFkZCBEU0QgcHJvcGVydHkgb3ZlcnJpZGUgZm9yIEFTVVMgVVgzNDA1
Q0EKClRoZSBBU1VTIFplbmJvb2sgMTQgVVgzNDA1Q0EgKFNTSUQgMTA0MzoxQTYzKSBoYXMgaW50
ZXJuYWwgQ1MzNUw0MQphbXBsaWZpZXJzLCBidXQgd2FzIHVzaW5nIHRoZSBgbWlzc2luZ19zcGVh
a2VyX2lkX2dwaW8yYCBmYWxsYmFjayBlbnRyeS4KVGhpcyBjYXVzZWQgdGhlIHJpZ2h0IHNwZWFr
ZXIgY2hhbm5lbCB0byBiaW5kIHdpdGggVlNQSyB2b2x0YWdlIHN3aXRjaCBkaXNhYmxlZAooVlNQ
SzogMCksIGxlYWRpbmcgdG8gYSB2b2x1bWUgZHJvcCB+MSBzZWNvbmQgYWZ0ZXIgc3RhcnRpbmcg
cGxheWJhY2sgZHVlIHRvCnBvd2VyIGltYmFsYW5jZSBwcm90ZWN0aW9uLgoKQWRkIGFuIGV4cGxp
Y2l0IGVudHJ5IGZvciAxMDQzMUE2MyBpbiBjczM1bDQxX2NvbmZpZ190YWJsZSB3aXRoIGludGVy
bmFsIGJvb3N0CnR5cGUsIDQ1MDBtQSBwZWFrIGN1cnJlbnQsIGFuZCBzd2l0Y2ggaXRzIG1vZGVs
IG1hcHBpbmcgdG8gYGdlbmVyaWNfZHNkX2NvbmZpZ2AuClRoaXMgcmVzb2x2ZXMgdGhlIHZvbHVt
ZSBkcm9wIGlzc3VlIGFuZCBlbmFibGVzIHByb3BlciBpbnRlcm5hbCBib29zdCBmb3IgYm90aCBj
aGFubmVscy4KClNpZ25lZC1vZmYtYnk6IEdlbWF5ZWwgTGlyYSA8Z2VtYXllbGxpcmFAZ21haWwu
Y29tPgotLS0KIHNvdW5kL2hkYS9jb2RlY3Mvc2lkZS1jb2RlY3MvY3MzNWw0MV9oZGFfcHJvcGVy
dHkuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvaGRhL2NvZGVjcy9zaWRlLWNvZGVjcy9jczM1bDQxX2hk
YV9wcm9wZXJ0eS5jIGIvc291bmQvaGRhL2NvZGVjcy9zaWRlLWNvZGVjcy9jczM1bDQxX2hkYV9w
cm9wZXJ0eS5jCmluZGV4IDQxNmQ3YmYuLjFjZjEyZjggMTAwNjQ0Ci0tLSBhL3NvdW5kL2hkYS9j
b2RlY3Mvc2lkZS1jb2RlY3MvY3MzNWw0MV9oZGFfcHJvcGVydHkuYworKysgYi9zb3VuZC9oZGEv
Y29kZWNzL3NpZGUtY29kZWNzL2NzMzVsNDFfaGRhX3Byb3BlcnR5LmMKQEAgLTEwNCw2ICsxMDQs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNzMzVsNDFfY29uZmlnIGNzMzVsNDFfY29uZmlnX3Rh
YmxlW10gPSB7CiAJeyAiMTA0MzE3RjMiLCAyLCBJTlRFUk5BTCwgeyBDUzM1TDQxX0xFRlQsIENT
MzVMNDFfUklHSFQsIDAsIDAgfSwgMCwgMSwgLTEsIDEwMDAsIDQ1MDAsIDI0IH0sCiAJeyAiMTA0
MzE4NjMiLCAyLCBJTlRFUk5BTCwgeyBDUzM1TDQxX0xFRlQsIENTMzVMNDFfUklHSFQsIDAsIDAg
fSwgMSwgMiwgMCwgMTAwMCwgNDUwMCwgMjQgfSwKIAl7ICIxMDQzMThEMyIsIDIsIEVYVEVSTkFM
LCB7IENTMzVMNDFfTEVGVCwgQ1MzNUw0MV9SSUdIVCwgMCwgMCB9LCAwLCAxLCAtMSwgMCwgMCwg
MCB9LAorCXsgIjEwNDMxQTYzIiwgMiwgSU5URVJOQUwsIHsgQ1MzNUw0MV9MRUZULCBDUzM1TDQx
X1JJR0hULCAwLCAwIH0sIC0xLCAyLCAtMSwgMTAwMCwgNDUwMCwgMjQgfSwKIAl7ICIxMDQzMUE4
MyIsIDIsIElOVEVSTkFMLCB7IENTMzVMNDFfTEVGVCwgQ1MzNUw0MV9SSUdIVCwgMCwgMCB9LCAw
LCAxLCAtMSwgMTAwMCwgNDUwMCwgMjQgfSwKIAl7ICIxMDQzMUI5MyIsIDIsIElOVEVSTkFMLCB7
IENTMzVMNDFfTEVGVCwgQ1MzNUw0MV9SSUdIVCwgMCwgMCB9LCAxLCAyLCAwLCAxMDAwLCA0NTAw
LCAyNCB9LAogCXsgIjEwNDMxQzlGIiwgMiwgSU5URVJOQUwsIHsgQ1MzNUw0MV9MRUZULCBDUzM1
TDQxX1JJR0hULCAwLCAwIH0sIDEsIDIsIDAsIDEwMDAsIDQ1MDAsIDI0IH0sCkBAIC01MzAsNyAr
NTMxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjczM1bDQxX3Byb3BfbW9kZWwgY3MzNWw0MV9w
cm9wX21vZGVsX3RhYmxlW10gPSB7CiAJeyAiQ1NDMzU1MSIsICIxMDQzMTdGMyIsIGdlbmVyaWNf
ZHNkX2NvbmZpZyB9LAogCXsgIkNTQzM1NTEiLCAiMTA0MzE4NjMiLCBnZW5lcmljX2RzZF9jb25m
aWcgfSwKIAl7ICJDU0MzNTUxIiwgIjEwNDMxOEQzIiwgZ2VuZXJpY19kc2RfY29uZmlnIH0sCi0J
eyAiQ1NDMzU1MSIsICIxMDQzMUE2MyIsIG1pc3Npbmdfc3BlYWtlcl9pZF9ncGlvMiB9LAorCXsg
IkNTQzM1NTEiLCAiMTA0MzFBNjMiLCBnZW5lcmljX2RzZF9jb25maWcgfSwKIAl7ICJDU0MzNTUx
IiwgIjEwNDMxQTgzIiwgZ2VuZXJpY19kc2RfY29uZmlnIH0sCiAJeyAiQ1NDMzU1MSIsICIxMDQz
MUI5MyIsIGdlbmVyaWNfZHNkX2NvbmZpZyB9LAogCXsgIkNTQzM1NTEiLCAiMTA0MzFDOUYiLCBn
ZW5lcmljX2RzZF9jb25maWcgfSwKLS0gCjIuNDMuMAo=
--0000000000007dd328065804467a--
