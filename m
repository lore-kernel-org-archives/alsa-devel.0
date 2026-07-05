Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4EFC43602
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:30:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D6B0601E5;
	Tue,  7 Jul 2026 16:30:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D6B0601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783434619;
	bh=70okckZkWCu+57k61cHdXI3TsiOrVjXxPE3ghLkSKRg=;
	h=Date:From:To:Cc:References:Subject:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=D1Lt6hUYD0R04rqjZhohgqF11GB1IW6nzv9qVS+mB2JULlsxil4VIDE5wCfpB4qWJ
	 ThhNqduvq97mfhy10mlBwh6XXEb0Sy2ksT78zC2mEW02J/LVlOgCdX87Ru55/DRL8v
	 sw3vqv+yvsTaDbPvAjgzhMn7kdFNk7hB0Q5tDvAA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C953DF805EF; Tue,  7 Jul 2026 16:29:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F2FEF805EF;
	Tue,  7 Jul 2026 16:29:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3A65F80524; Mon,  6 Jul 2026 01:07:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=34.2.64.18
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783292871;
	b=mZYM8RLL80iyFIqosyd3G7yJ2Z+f4bkE97KUMu+NGizGK2DAmUJbbnVvSW1FsU5wPPoW
	 pyrSdlCRDWmE94uOl9L7fKvFAG/m/O66zCCHexFOUT/ojF+BdtBx6U0oBpXoGWkWttAGs
	 pOONLLDwtNSfMhRqXTPiOBzgKKOtpZSJUi97sk9oLC585CAWfTFnUDjiT7b1FGCtcpepq
	 5HqfY41tsr7wXmygYKUpUqV6r9biEfwSbnlHXE1nE1FVhwB+58FGAag2nr9SELyXH/e+E
	 9BzFCQoqcNHsmlTtPSKA4c5EMXB7K6AmQBwPTyzP4GzLz/M4PwwHhfIqwcwdTDDOa7g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783292871;
	h=DKIM-Signature:Date:From:To:Message-ID:Subject:MIME-Version;
	bh=O4Pb8phFI+4l380myWnPp0NRykDqAtqVZ3nMJZ7uvkc=;
	b=hpPqHW2fELaVJLzAhyfeiOcrhb3ruCFtmy/Cyt17/32e16NkGWO/43SVwblbcfNBMK4k
	 /IU0muL48WVfT95GpiX0V01RWkx36nf7gH6QJnI1tKYlSSTtdCNNriFxgLqapgTHp/RSd
	 1r3lFHUXGKqa1t2J/CdEuSdPtza7A3a8bDEJgxeWEGL2G6PYGmKVDhERGTjzD0cY+UhNk
	 60RR31vsjZRy+fcGL2R80imqFhDfg2f/YSURDey2CrQzvJduD7H4q7ilWpPb0MlWLnvZE
	 IvBZwHMDcIFC4z/paW3Ekf4uftRhbqVOr4QJlPPT3WBBVxGc8vY05ElJoIs8mE436bw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=yahoo.com.br header.i=@yahoo.com.br header.a=rsa-sha256
 header.s=s2048 header.b=b8L78D8k;
	arc=none smtp.remote-ip=34.2.64.18
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F3E1CF8025A
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 01:07:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3E1CF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=yahoo.com.br header.i=@yahoo.com.br header.a=rsa-sha256
 header.s=s2048 header.b=b8L78D8k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s2048;
 t=1783292867; bh=O4Pb8phFI+4l380myWnPp0NRykDqAtqVZ3nMJZ7uvkc=;
 h=Date:From:To:Cc:References:Subject:From:Subject:Reply-To;
 b=b8L78D8kZqb9x6fFavKtaNTQuberh+CIrKINnVML3hSxee9+ZvQ5ERSbwuCMCBLzFc2zz0rPx6eQtuOhCL7+L6rA/abiHojv7y7hYoH8AuGSTmIjweRPlDuqENMOalHLYD3UZrOVwv2vtGD7npusEHj+gh9nTLOMQZYCg46srXVO8wX9flcyEVrxPFSa5+5Nedcb1RurGItkB6q/6V19m7Mcddyh0SDu9kqLewP6M1TANgS3fcGzuYVmfe75jlp9a5XfBtkTzcqo9de8XSNvUbp/pOicX63+ts+uZTlwher48CgpLfNL00X6xt/ujNjlfdze4Xe/ZV8osX/QRa1IBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783292867; bh=zaGBYrHS63+yGK5+q4vlFlC86nlFy5MG8rtnRrMuD1C=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=Qaicfg3t+kcxCkGCAi/j4hurXj3HmrNYCfqj1mV6llCHmp0OdxQOe4rxdZfsquSkbh2K7sVcYMAkpTcIiAYbWXDblNLS3tKzVe60rqX/o1iOj1Fia+dJ0sUhFg17wRKDBgUFWF1PKSYXiEcpUklPFs84WAcpiyYBV3GtlsU3BUGlvA+NTtcFBDLT8oOFAJfvIEdfW04TFurkejttlDIpr+Y4dPJDZ3DMGXG7FbaNEgscPbz2wi8h4YDHi5OwEqwrtEy5L0YKlEKlWDEvpaKm+kFweqHKko65KawdabkX0IeEezLiLzCfJ4WKHfxEwOJcnNHKP2xp4mhMLTeGWq0mhg==
X-YMail-OSG: ksEf5oMVM1npxuUIxvXjAclSOFTPTSfdZ1BvCppkCQ6qddiTYkgoRlY5FQGCvPX
 pTXHZQ5ARh9LKM8_V07IcrKdFGYG9Y_i0MC.ve4Dg5r9SfXbHrT_Tneu3gs6DIfq5OAaM5PU.LNH
 7Wla78fYy8o2wjs.Luj7KBSds8FHaVgnrfC.4ROApMiSghkDTEUfeR0.H6.fr72wiLNCIxDsAvgi
 yWm6Mlq9.3Fd44FJRYORO4akqCHFXGUWeazXxKZdORBXM6_DFlYNiymTZgiR9fe5Ww8Ouc8_Xt9M
 PE0_KvWEsa_hViJKs47r9kvHbgDHF5xhV4jQgfZAGcsVlRMpaYIjbddnnESo7lsUl9WgFRC63foG
 aIvxsoPqMWm.lgPRcIk07iKriWoDdZrvaSVTTwqlyPt7Q_SjSXaarhahaoFzMUusMfRg7TXIHRum
 9_YZB1KuQKasCIyihZ_zibI9IwUcsi2EuelEzBKAHw0nm0e5J4UxlqvNO_nffIFOdu8qewl1FBOW
 FrgNpo7GC6wprb_Y_oIqFetLqzWudCYvH7D1GQcmwbJsu0SyO0HRF1wFjUByh6EbazbYJSnrWeko
 Ryk2Xa_j8QNmjdGtGfMglm5TytsRRfnJ0LJT8rcMdWrnZRrOcLOToTBdFdoHTlmfqJlaxh7Bk2XG
 T0hAMi5RO66c50iooJ.E_1lnuBUubd_lFYeGp4r8qB5y3x57sbXS0ldlKX8TmbfGVs_w4HJelcfh
 Awl4Ufnf4Qo3hvSCWIOxipZF6jTZ.xZiTc4Z_o9085w7xUUt7qJDKE6yhKXWoT93B.lK4DTUayVc
 5iaFDmYWceDrbWIc9s2U8Ul0e.jVzeqpxJiUyjFt6.kjoQfhbxNYdcweRvrSbjf0iUN63fPF_T_H
 IUewLOnwTD9DToTBfIfDgq05EC47xolBwvMm5MUR2xwfVenjMoHqbi8H06oWkKRh4sK9po85KGtT
 7.wgqD4Mhh2a0yp6g_hOdW3hGs_yZLv7PngcAeWJmt8lsXJ1CyCiLvM4gFtkWMtbNAgro7jBje6r
 ZyTYPf6G36FesVdykfnbJ.HJY.OUaJJj2AqcOTjNS0mDo4.tReAJSW_iz0VHEAsE2mlHchKcdWgn
 2mW5u3zV3gne2FKEzWc6lDypR85z9FyjDL7CaYPGs4oti0jSiuQFHtRF0IDphjYEQnaDfIjvT5G5
 kFbQcROt3JvZBFVleBTewgGWFCX8wFD0AZ03Ly1gMsx15_kvrzjmUTmEv5IWFii7wj4hGdAVarxD
 M0H7spqYx1bO0brrOOe7F..0HgeVy_nJkj07uMTi4ikOzdMoi7rFMqOVw5sFPUI3FBxP3p.t3e3r
 .IXVZGLatvOaNZSsM_kNpfBmdUPYTnN6QCOCFxJuRCaHosWI.RZGNMTijil2VgaUlKveVkqIAQIP
 kR2urgsWCjcETuh.FAnHX0QiuD4kTNnGrJBJq371XuhW_PK_LlEZg.46VMfhyHYCGD5JACyAJBuM
 UtDUgPxezc5lg8Wj6N7an4OjVL.RzXEOpBv7AzAvgDPi_ebGpS2Es9sHQyyqp8dC.lLlnI6qb1gv
 VH3r8LLhYbF_Z1HnC_4kpCyC2_pJmx0gOFtd7E_tIdLJZWh_KJE2LFSHLyPGd6kIRvDVbkGiEUip
 gfe5zFQdBqwDgfc6FK1_TaEXWKRtSGji4cwa0oXsC.s8thLkq0A7xaMvHS2rRjmbmEhphyJOtEwH
 cUBKyoNZ2IjzoTB2ShNQ6AnEyjEyNvZRD.BEoZgQ88UlUiTolAf9G6sI67TV.plOkpId_CboaC.g
 MjtK75_VGzLTb3BQyIxLay_DUb7TIcwf_8x1PvDnHne3dDsHxjrnbxED7DpLP6d1pllBEB.khqLO
 06LlfYE1BS.tw7vGdun0D5j1GpoGyXcsVL6QLB31v9CSGftVXB2XbncWKLhfRrCgjtZyJRt.0kZu
 AFhyYQsu93d07oTNDOmeF_uCbcPgi9IiqVtjKeeDGeYO2koMZlm59Va.4sC8P9w9bFbDirAoyS3t
 E12.RID1t.hihWiSjNeEUyfU9rodfttpUDFJ0ZHaAWk_Bk9o4o.Hhb03LZSXfcCfBB4tQ0r8EbwX
 IIUSrrNja_CrWAj8NFc7KpC3BuvTZjwgsAvw8XtxM_8vM29I5r1Br5szeaGDAimEdOJGkPQ--
X-Sonic-MF: <miguelmnapoli@yahoo.com.br>
X-Sonic-ID: 18806bf5-68ab-4c9e-9bf3-591e0a69dcc3
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Sun, 5 Jul 2026 23:07:47 +0000
Date: Sun, 5 Jul 2026 23:07:46 +0000 (UTC)
From: =?UTF-8?Q?Miguel_M=C3=A1rio_N=C3=A1poli?= <miguelmnapoli@yahoo.com.br>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.com" <tiwai@suse.com>
Message-ID: <916698070.3732567.1783292866624@mail.yahoo.com>
References: <916698070.3732567.1783292866624.ref@mail.yahoo.com>
Subject: [BUG] snd-usb-audio: incorrect PCM volume scaling on Edifier R19U
 USB speaker (0001:0201)
MIME-Version: 1.0
X-Mailer: WebService/1.1.26086 YMailCLDNovation
X-MailFrom: miguelmnapoli@yahoo.com.br
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IMIDHETHT4MUW66LFZIFXYSRASTD3HBQ
X-Message-ID-Hash: IMIDHETHT4MUW66LFZIFXYSRASTD3HBQ
X-Mailman-Approved-At: Tue, 07 Jul 2026 14:29:38 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IMIDHETHT4MUW66LFZIFXYSRASTD3HBQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQpJJ2QgbGlrZSB0byByZXBvcnQgYW4gaXNzdWUgd2l0aCBVU0IgYXVkaW8gdm9sdW1l
IHNjYWxpbmcgb24gYSBjaGVhcFVTQi1wb3dlcmVkIHNwZWFrZXIgc2V0LCBpbiBjYXNlIGl0J3Mg
dXNlZnVsIGZvciBhIG1peGVyIHF1aXJrIGZpeC4NCkRldmljZTogRWRpZmllciBSMTlVIFVTQiBz
cGVha2VycyAoTVZTSUxJQ09OLklOQy4gY29udHJvbGxlciBjaGlwKWxzdXNiOiBCdXMgMDAxIERl
dmljZSAwMTA6IElEIDAwMDE6MDIwMSBGcnkncyBFbGVjdHJvbmljcyBFRElGSUVSIFIxOVXCoCAo
Tm90ZTogaWRWZW5kb3IgMDAwMSBpcyBhbiB1bm9mZmljaWFsL3JldXNlZCBJRCAoIkZyeSdzIEVs
ZWN0cm9uaWNzIsKgIHBsYWNlaG9sZGVyKSwgc28gaXQgbWF5IGJlIHNoYXJlZCBieSB1bnJlbGF0
ZWQgZGV2aWNlcyBmcm9tIG90aGVywqAgdmVuZG9ycyAtLSBwbGVhc2UgdGFrZSB0aGF0IGludG8g
YWNjb3VudCBpZiBjb25zaWRlcmluZyBhIHF1aXJrwqAgYmFzZWQgb24gVklEL1BJRCBtYXRjaGlu
ZyBhbG9uZS4pDQpTeXN0ZW06IFpvcmluIE9TIDE4IChVYnVudHUtYmFzZWQpLCBmcmVzaCBpbnN0
YWxsICg8IDEgd2VlayBvbGQpS2VybmVsOiA2LjE3LjAtMzUtZ2VuZXJpY1BpcGVXaXJlOiAxLjAu
NQ0KUHJvYmxlbSBkZXNjcmlwdGlvbjpPbiBjb25uZWN0aW9uLCB0aGUga2VybmVsIGxvZ3MgYSB3
YXJuaW5nIGFib3V0IGFuIHVudXN1YWxseSBsYXJnZXZvbHVtZSByYW5nZSBmb3IgdGhpcyBkZXZp
Y2UncyBQQ00gY29udHJvbDoNCsKgIHVzYiAxLTI6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZl
bmRvcj0wMDAxLCBpZFByb2R1Y3Q9MDIwMSwgYmNkRGV2aWNlPTAuMTDCoCB1c2IgMS0yOiBQcm9k
dWN0OiBFRElGSUVSIFIxOVXCoCB1c2IgMS0yOiBNYW51ZmFjdHVyZXI6IE1WU0lMSUNPTi5JTkMu
wqAgdXNiIDEtMjogV2FybmluZyEgVW5saWtlbHkgYmlnIHZvbHVtZSByYW5nZSAoPTk5OSksIGN2
YWwtPnJlcyBpcyBwcm9iYWJseSB3cm9uZy7CoCB1c2IgMS0yOiBbOV0gRlUgW1BDTSBQbGF5YmFj
ayBWb2x1bWVdIGNoID0gMiwgdmFsID0gMC85OTkvMQ0KQXMgYSByZXN1bHQsIHVzZXJzcGFjZSB2
b2x1bWUgY29udHJvbHMgKHRlc3RlZCB2aWEgUGlwZVdpcmUvV2lyZVBsdW1iZXJhbmQgR05PTUUg
U291bmQgU2V0dGluZ3MpIGRpc3BsYXkgYSBub3JtYWwtbG9va2luZyB2b2x1bWUgcGVyY2VudGFn
ZShlLmcuIDY5JSksIHdoaWxlIHRoZSBhY3R1YWwgdW5kZXJseWluZyBBTFNBIG1peGVyIHZhbHVl
IHN0YXlzIGF0IDAscHJvZHVjaW5nIG5vIGF1ZGlibGUgb3V0cHV0IGF0IGFsbCAtLSB3aXRoIG5v
IG11dGUgaW5kaWNhdG9yIGFueXdoZXJlaW4gdGhlIFVJLg0KQ29uZmlybWVkIHZpYSBhbWl4ZXIg
d2hpbGUgUGlwZVdpcmUgcmVwb3J0ZWQgfjY5JToNCsKgIFNpbXBsZSBtaXhlciBjb250cm9sICdQ
Q00nLDDCoCDCoCBDYXBhYmlsaXRpZXM6IHB2b2x1bWUgcHN3aXRjaCBwc3dpdGNoLWpvaW5lZMKg
IMKgIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHTCoCDCoCBMaW1p
dHM6IFBsYXliYWNrIDAgLSA5OTnCoCDCoCBGcm9udCBMZWZ0OiBQbGF5YmFjayAwIFswJV0gWzAu
MDBkQl0gW29uXcKgIMKgIEZyb250IFJpZ2h0OiBQbGF5YmFjayAwIFswJV0gWzAuMDBkQl0gW29u
XQ0KTWFudWFsbHkgZm9yY2luZyB0aGUgcmF3IEFMU0EgY29udHJvbCByZXNvbHZlcyBpdCBpbW1l
ZGlhdGVseToNCsKgIGFtaXhlciAtYyA8Y2FyZD4gc3NldCBQQ00gOTk5DQpBZnRlciB0aGlzLCBh
dWRpbyBwbGF5cyBjb3JyZWN0bHkgYW5kIHRoZSB2b2x1bWUgcmVzcG9uZHMgbm9ybWFsbHkgdG9m
dXJ0aGVyIGFkanVzdG1lbnRzLCBjb25maXJtaW5nIHRoZSBoYXJkd2FyZS9EQUMgcGF0aCBpdHNl
bGYgaXMgZmluZSAtLXRoaXMgbG9va3MgbGlrZSBhIHJlc29sdXRpb24vc3RlcCAoY3ZhbC0+cmVz
KSBtaXNjYWxjdWxhdGlvbiBmb3IgdGhpc2RldmljZSdzIDAtOTk5IHJhbmdlLCBzaW1pbGFyIHRv
IHBhc3QgcXVpcmsgZml4ZXMgZm9yIG90aGVyIFVTQiBhdWRpb2NoaXBzIHdpdGggbm9uLXN0YW5k
YXJkIHZvbHVtZSByYW5nZXMgKGUuZy4gdGhlIExvZ2l0ZWNoIGMyNzAgd2ViY2FtZml4IGluIHNv
dW5kL3VzYi9taXhlci5jLCB2b2x1bWVfY29udHJvbF9xdWlya3MoKSkuDQpUaGlzIHdhcyBub3Qg
YW4gaXNzdWUgb24gYSBwcmV2aW91cyBVYnVudHUgaW5zdGFsbGF0aW9uIHdpdGggYW4gb2xkZXJr
ZXJuZWwvUGlwZVdpcmUgc3RhY2sgb24gdGhlIHNhbWUgaGFyZHdhcmUsIHN1Z2dlc3RpbmcgdGhp
cyBtYXkgYmUgYXJlZ3Jlc3Npb24gaW4gaG93IGEgbmV3ZXIga2VybmVsIG9yIFBpcGVXaXJlIGhh
bmRsZXMgdGhpcyBzcGVjaWZpY3JhbmdlLCBvciBzaW1wbHkgYSBkZXZpY2UgdGhhdCB3YXMgbmV2
ZXIgY292ZXJlZCBieSBhbiBleGlzdGluZyBxdWlyay4NCkN1cnJlbnQgd29ya2Fyb3VuZCBpbiB1
c2UgKHVzZXJzcGFjZSwgbm90IGEgcmVhbCBmaXgpOkEgdWRldiBydWxlIHRyaWdnZXJzIGBhbWl4
ZXIgLWMgPGNhcmQ+IHNzZXQgUENNIDk5OWAgd2hlbmV2ZXIgdGhlZGV2aWNlIGlzIGNvbm5lY3Rl
ZCAobWF0Y2hlZCBieSBpZFZlbmRvcj0wMDAxL2lkUHJvZHVjdD0wMjAxKSwgZm9yY2luZ3RoZSBB
TFNBIGNvbnRyb2wgdG8gbWF4aW11bSBzbyBQaXBlV2lyZSdzIG93biB2b2x1bWUgc2xpZGVyIGNh
biB0aGVuYXR0ZW51YXRlIGNvcnJlY3RseSBmcm9tIHRoZXJlLg0KSGFwcHkgdG8gdGVzdCBhIHBh
dGNoIG9yIHByb3ZpZGUgbW9yZSBsb2dzL291dHB1dCBpZiBuZWVkZWQuDQpUaGFua3MsTWlndWVs
IE1hcmlvIE5hcG9saUNyaWNpdW1hL0JyYXppbA0K
