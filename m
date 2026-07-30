Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4342BC54F54
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:28:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E86E601D4;
	Fri, 31 Jul 2026 09:27:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E86E601D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785482883;
	bh=QfbB0VEXSYBXEeTeGkvL5Gag094ZVzj87aksAm8AC1M=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=OfbU+yE8YzI3EreRSwpP0+SpCsVIJd2zE7bRiH9B1AltIspw2AR7HQtHLeYFoN8J3
	 KKnIW44WQfh9LbUU3FW+4mOSTwum3N2xrK+oQvj0SJB9JAhdIqefYJbhSK3d4EOjL5
	 Lx1S+KlyyZsFEPWNdanyJSqTEteBOLbeWQ1u5pHk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDC00F80698; Fri, 31 Jul 2026 09:26:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F818F80698;
	Fri, 31 Jul 2026 09:26:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3C93F80496; Thu, 30 Jul 2026 13:52:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=84.23.254.151
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785412377;
	b=M9Qy6tjcsmW872OeCzHQ25WR2iQa1zUTLBoH1z0OWo30GfwK7D2bLXD8MHIAT/7SPzvU
	 An//dbSHzGAeMoYtVJIroX8gFI6fEqBnU2uJo2EryHt/IqHEYwd2CsKj/Ukw3boK2PSO/
	 71Hy+sE5wdS8aq9nHj08SztcBMib1OiRlaIQ0dOtsZDSmAOdGQ2dSxiZgsiGUYGH6lQZx
	 hO/wnSqCfiaEY1Jov2ahaGOlxI9NcCmkMArraTvV6Y21dOg1Dhm5F0ul5BrsND2Lg+mb7
	 Oa1Qn/ExD1dYCrDB2dZgI7rH5kqbkt/4SOMCBDYXKMt7+J2Q4AE0eqKcgNwUy4s1i3g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785412377;
	h=DKIM-Signature:MIME-Version:Date:From:To:Subject:Message-ID;
	bh=WCUWdYK2sSqdjxpTCNHk4/XJZvDvtgl6+2XdbJc6o0Y=;
	b=GYJL3B6guG3Z5oyJis6wgWVoilWK6VpMT8dqYoOrjlChLXQtEWJQv8mXfoX3/RrkUltb
	 VXHbSnwcFd0z1rUwljpMGUJnjJJZnpNQDmosURh8e4mxVqWVX9QmzUDvfp7Ag+bHMqdEb
	 qbbqOara5ATEEv3V2l5VnR9h+ffCjhrt7nyQ0eEA/TzMZmrq370vbiXrgrKGBymDr1N+z
	 LkelaDOa1WiyxIW7iWb94V9tBLD5G2DSUGgImLLY4rn8SaAWtLMS/nG/Vo62J6ClFWhex
	 zVvwjUm52u10NZgJdtm8CP2bL5GereRRPxi0KdFxLK1IfBb4xAum9FsNEhCH7Fgn9MQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=berlin.de header.i=@berlin.de header.a=rsa-sha256
 header.s=snbe header.b=VY0QprkO;
	arc=none smtp.remote-ip=84.23.254.151
Received: from cosmopolitan.snafu.de (cosmopolitan.snafu.de [84.23.254.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A3703F800F3
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 13:52:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3703F800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=berlin.de header.i=@berlin.de header.a=rsa-sha256
 header.s=snbe header.b=VY0QprkO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berlin.de;
	s=snbe; h=Content-Type:Message-ID:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bMSH3gG4Eea3HSqwPJMxTDg+6/+1nqok/Z91Nn6UJhU=; b=VY0QprkOb6Ti7WOZgRPVux+v74
	0564FbMt5GFBr11GRQrxocnuOZR+dvl/0wsAJWH1cag7tWeRi8jNzN3qcKcqda1eJp8pKFjqy5SLC
	Aq5ddSrPvSbOt/qr7qzbITctlPYL/GFFRbBVaOAZxBrFz9UGvZEeHJzEa8ptQ01trA35t39n9tfMR
	HGmX1cqmezRftKASnarAy7O3q2vfblUH9kRdiKKzqWN97HxQ7iOdl+cNbinhVpBw1mRgLvR1zrQco
	cpz9kLPRqc52cuROU67nDxjRRRr2ANR6C4rQCd1LpDwal+qgjUv5mwWgYG4IRu1eM3FxwND01gFcn
	cK8E7yFQ==;
X-Trace: 4c7c7468696c6f2e7363687565747a406265726c696e2e64657c3231332e37332e
	38332e39327c317770504a6c2d30303030303030303739332d30726a707c313738
	35343132333733
Received: from cosmopolitan.snafu.de ([10.151.10.49] helo=localhost)
	by cosmopolitan.snafu.de with esmtpa (Exim 4.99.3)
	id 1wpPJl-00000000793-0rjp;
	Thu, 30 Jul 2026 13:52:54 +0200
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 13:52:53 +0200
From: "Thilo Schuetz, Berlin" <thilo.schuetz@berlin.de>
To: alsa-devel@alsa-project.org
Cc: pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 broonie@kernel.org
Subject: Huawei MateBook D15 (BOHB-WAX9-PCB-B2): ES8336 speakers require
 SPEAKERS_EN_GPIO1 quirk
Message-ID: <b2b4cd741dd89c228e853beb3fda6eb6@berlin.de>
X-Sender: thilo.schuetz@berlin.de
User-Agent: Berlin-Mail
X-VISP-ShouldScan: 1
X-VISP-Virus-Check: clean
X-VISP-Spam-Score: -7.1 (-------)
X-VISP-Spam-Report: This message has been scanned on "cosmopolitan.snafu.de"
 to identify if it is considered spam or not.
 Contact the support hotline for details.
 Content analysis details:   (-7.1 points)
  pts rule name              description
 ---- ----------------------
 --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.2 KAM_DMARC_NONE         DKIM has Failed or SPF has failed on the message
 and
                             the domain has no DMARC policy
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
 -5.0 INX_FROM_WL_33         Whitelist
  0.5 FREEMAIL_FROM          Sender email is commonly abused enduser mail
 provider
                             [thilo.schuetz(at)berlin.de]
  0.0 HTML_MESSAGE           BODY: HTML included in message
  0.0 T_JR_FREEMAIL_ANYWHERE No description available.
  0.0 T_JR_BZ_FREE_ANYWHERE  Baza Call: Body or From/ReplyTo headers
                             contains a Freemail Address
X-VISP-Spam-Max-Score: +++++
X-MailFrom: thilo.schuetz@berlin.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: BM7CD3MWQWNVYBJ43FWWB5GYP234WLBH
X-Message-ID-Hash: BM7CD3MWQWNVYBJ43FWWB5GYP234WLBH
X-Mailman-Approved-At: Fri, 31 Jul 2026 07:26:36 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BM7CD3MWQWNVYBJ43FWWB5GYP234WLBH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

RGVhciB0ZWFtLCANCg0KSSB3b3VsZCBsaWtlIHRvIHJlcG9ydCB3aGF0IGFwcGVhcnMgdG8gYmUg
YW4gaW5jb3JyZWN0IHF1aXJrIGFzc2lnbm1lbnQNCmZvciBhIEh1YXdlaSBNYXRlQm9vayBEMTUg
d2l0aCBhbiBFUzgzMzYgY29kZWMuIA0KDQpQbGVhc2Ugbm90ZTogVGhlIG1hY2hpbmUgaGVyZSBp
cyBteSBtb3RoZXIncyBub3RlYm9vayBhbmQgSSBlbmNvdW50ZXJlZA0KdGhlIGVycm9yIHdoaWxl
IHN3aXRjaGluZyBoZXIgZnJvbSBXaW5kb3dzIHRvIERlYmlhbi4gUmVzZWFyY2ggYW5kIHRoZQ0K
Zml4IHdlcmUgZG9uZSB3aXRoIHN1cHBvcnQgb2YgQ2hhdEdQVCwgc28gcGxlYXNlIHRyZWF0IHRo
aXMgYWNjb3JkaW5nbHksDQpldmVuIHRob3VnaCBJJ3ZlIHRyaWVkIHRvIGJlIGNhcmVmdWwgYW5k
IGNvbXBsZXRlIG15c2VsZi4gKEknbSBvbmx5IGENCnVzZXIsIGFmdGVyIGFsbC4pIA0KDQpTeXN0
ZW06IA0KDQogCSogTGFwdG9wOiBIdWF3ZWkgTWF0ZUJvb2sgRDE1DQogCSogRE1JIGJvYXJkIG5h
bWU6IEJPSEItV0FYOS1QQ0ItQjINCiAJKiBEaXN0cmlidXRpb246IERlYmlhbiAxMw0KIAkqIEtl
cm5lbDogNi4xMi45NC1hbWQ2NA0KIAkqIEF1ZGlvIGRyaXZlcjogc25kX3NvY19zb2ZfZXM4MzM2
DQoNClByb2JsZW06DQpXaXRoIHRoZSBkZWZhdWx0IGRyaXZlciBjb25maWd1cmF0aW9uLCB0aGUg
aW50ZXJuYWwgc3BlYWtlcnMgcHJvZHVjZSBubw0Kc291bmQuIEJsdWV0b290aCBhdWRpbyB3b3Jr
cyBub3JtYWxseS4gDQoNClRoZSBkcml2ZXIgcmVwb3J0czoNCg0Kc29mLWVzc3g4MzM2OiBxdWly
ayBtYXNrIDB4MWEwDQoNCkZyb20gdGhlIGN1cnJlbnQgdXBzdHJlYW0gc291cmNlLCB0aGlzIERN
SSBlbnRyeSBzZWxlY3RzOg0KDQpTT0ZfRVM4MzM2X0hFQURQSE9ORV9HUElPIHwNClNPQ19FUzgz
MzZfSEVBRFNFVF9NSUMxDQoNCkludmVzdGlnYXRpb246IA0KDQogCSogVGhlIERTRFQgY29udGFp
bnMgYW4gRVNTWDgzMzYgZGV2aWNlIHdpdGggdHdvIEdQSU8gb3V0cHV0cy4NCiAJKiBObyBIV1NQ
MDAwMSBBQ1BJIGRldmljZSBpcyBwcmVzZW50Lg0KDQoJKiBBbiBJwrJDIHNjYW4gc2hvd3Mgbm8g
ZGV2aWNlcyBhdCBhZGRyZXNzZXMgMHg1OCBvciAweDViLCBzbyB0aGUNCkhXU1AwMDAxLWJhc2Vk
IGFtcGxpZmllciB3b3JrYXJvdW5kIGlzIG5vdCBhcHBsaWNhYmxlIHRvIHRoaXMgaGFyZHdhcmUu
DQooaHR0cHM6Ly9wYXRjaGV3Lm9yZy9saW51eC8yMDI2MDYxNDE2MTAyOC4xMDQwNS0xLXRnYXJh
ZXY2NTMlNDBnbWFpbC5jb20pDQoJKiBQaXBlV2lyZSwgU09GIGZpcm13YXJlIGFuZCB0aGUgRVM4
MzM2IGNvZGVjIHdlcmUgZGV0ZWN0ZWQgYW5kIGxvYWRlZA0KY29ycmVjdGx5Lg0KDQpXb3JrYXJv
dW5kOg0KQWRkaW5nIHRoZSBmb2xsb3dpbmcgbW9kcHJvYmUgb3B0aW9uOg0KDQpvcHRpb25zIHNu
ZF9zb2Nfc29mX2VzODMzNiBxdWlyaz0weDFiMA0KDQphZGRzIHRoZSBTUEVBS0VSU19FTl9HUElP
MSBxdWlyay4gDQoNCkFmdGVyIHJlYm9vdCwgZG1lc2cgcmVwb3J0czoNCg0Kc29mLWVzc3g4MzM2
OiBPdmVycmlkaW5nIHF1aXJrIDB4MWEwID0+IDB4MWIwDQpzb2YtZXNzeDgzMzY6IHF1aXJrIG1h
c2sgMHgxYjANCnNvZi1lc3N4ODMzNjogcXVpcmsgU1NQMA0Kc29mLWVzc3g4MzM2OiBxdWlyayBE
TUlDIGVuYWJsZWQNCnNvZi1lc3N4ODMzNjogU3BlYWtlcnMgR1BJTzEgcXVpcmsgZW5hYmxlZA0K
c29mLWVzc3g4MzM2OiBxdWlyayBoZWFkcGhvbmUgR1BJTyBlbmFibGVkDQpzb2YtZXNzeDgzMzY6
IHF1aXJrIGhlYWRzZXQgYXQgbWljMSBwb3J0IGVuYWJsZWQNCg0KV2l0aCB0aGlzIG92ZXJyaWRl
LCB0aGUgaW50ZXJuYWwgc3BlYWtlcnMgd29yayBpbW1lZGlhdGVseSBhZnRlciBib290DQphbmQg
bm9ybWFsIGF1ZGlvIHBsYXliYWNrIChGaXJlZm94L1lvdVR1YmUpIGZ1bmN0aW9ucyBjb3JyZWN0
bHkuIA0KDQpMaW1pdGF0aW9uczoNClVuZm9ydHVuYXRlbHkgSSBkaWQgbm90IGhhdmUgd2lyZWQg
aGVhZHBob25lcyBhdmFpbGFibGUsIHNvIEkgY291bGQgbm90DQp2ZXJpZnkgaGVhZHBob25lIGph
Y2sgYmVoYXZpb3IgYWZ0ZXIgZW5hYmxpbmcgdGhlIGFkZGl0aW9uYWwgcXVpcmsuIA0KDQpCZWNh
dXNlIHRoaXMgYm9hcmQgYWxyZWFkeSBoYXMgYW4gdXBzdHJlYW0gRE1JIGVudHJ5LCBJIGFtIG5v
dA0Kc3VnZ2VzdGluZyBhIHNwZWNpZmljIHBhdGNoLiBIb3dldmVyLCB0aGUgcmVzdWx0cyBhYm92
ZSBzdWdnZXN0IHRoYXQgYXQNCmxlYXN0IHNvbWUgQk9IQi1XQVg5LVBDQi1CMiBzeXN0ZW1zIHJl
cXVpcmUgdGhlIFNQRUFLRVJTX0VOX0dQSU8xIHF1aXJrDQpmb3IgdGhlIGludGVybmFsIHNwZWFr
ZXJzIHRvIGZ1bmN0aW9uLiANCg0KSWYgYWRkaXRpb25hbCBsb2dzIG9yIHRlc3RzIHdvdWxkIGJl
IGhlbHBmdWwsIEkgd291bGQgYmUgaGFwcHkgdG8NCnByb3ZpZGUgdGhlbS4gVGhpcyBtaWdodCB0
YWtlIGEgbGl0dGxlLCBhcyBJIHdpbGwgbmVlZCB0byB2aXNpdCBteSBtb20NCmZvciB0aGF0IHRo
ZW4uIA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgd29yayBvbiB0aGUgZHJpdmVyLiANCg0KS2luZCBy
ZWdhcmRzLA0KVGhpbG8NCg0KLS0gDQpEaXBsLkluZy4gVGhpbG8gU2NodWV0eg0KR2VvcmctV2ls
aGVsbS1TdHJhc3NlIDIwDQoxMDcxMSBCZXJsaW4NCkdFUk1BTlkNCg0KdGhpbG8uc2NodWV0ekBi
ZXJsaW4uZGUNCis0OSAxNzggMzA2MDIwMCAgKE1vYmlsZSBHZXJtYW55KQ0KKzYzIDkyOSA3MTU1
ODQwICAoTW9iaWxlIFBoaWxpcHBpbmVzKQ==
