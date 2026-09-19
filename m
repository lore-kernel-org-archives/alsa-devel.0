Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F413C982D8
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Sep 2026 05:12:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BFB36020D;
	Sat, 19 Sep 2026 07:11:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BFB36020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789794721;
	bh=ikrummqE6rDSEl7icHP7mTNtGRrOvFraXwP5OoJClyc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UpI+76P2CSKrP1O7ocbrRpKXRORSVlpI77zFA6v65JFeIA5+lNPgWROj0VK/cf+sC
	 4HtVlbCvnzYPBtkKS7mKijGpR8x8YoxMmong4wPxnh7dvrgfMZjxB0WukeMYa4DP9Z
	 /8/Xz0OX/iLtzEg1tTGBNNCiVsZ7bFqefo3/CeRY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70A5DF805F6; Sat, 19 Sep 2026 07:11:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E95F3F805FB;
	Sat, 19 Sep 2026 07:11:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26538F80557; Sat, 19 Sep 2026 07:11:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789794677;
	b=UfwSeuxjbfHNN4BvZ30wFDP6fBE8rOFMwlERO6AcyYhYH/Uwwv5Bl9DevrK25o5Hmmkv
	 I3JL5/g2tjhlL16FoqyxrWLUNYkFTlBnNR/YClGMJD1THXaSHKM9J2vPrlWZerGGfxSrB
	 CQ8YQcpRZIsI/lzfn6Y3fRSuTR32NlNOgIGsXBDHk6BkkbjWeJfGqbMXSW5296GF+abaj
	 iXtdJBg7y4PUsrsk9gNWGaD7HXV57V1eu1XYpZdB453RshxnrScM+n9r88YWUTHKltj8J
	 l3ogFDAhIW3pQC+0NlmPiiRR4WGXs4kiPdT99bvhmeVu+mWQfUeu3T03/eIAB5S3sqg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789794677;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ikrummqE6rDSEl7icHP7mTNtGRrOvFraXwP5OoJClyc=;
	b=WTjrDtrxaXeVmAV7QQtauMSF/zG5FjfBgouOhADVzMu1fSSG1g+VxpmPm/tK8gerHeZq
	 qYAXhAnS9yFIpdNGnOFDQoDOFjn/gLXSLfO4BoY8F8kIhebB0r+351+jCcvS/+RnJLHDg
	 AuLNFgtxOGPG7TGM9wYrAjOYfMU4CZFBRapDhdkEb5kjJXbuXI3T2LIjQ/efCa9AUiMeX
	 KrBd06IWrS5JA8/f66kk8XGiWVsxKXtEK6LmZY56uZAbtdgIbPxwl1L71QKZ+xqsaQLdi
	 HYFiSiJKKcE0PaLw0Esu9Cr0sxbsm+iTuz4KiiMSTA5KAuceVXFE48p37z+Ko0lrD4Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 594FEF80088
	for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2026 07:11:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 594FEF80088
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d6a0c66248ae00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/527@alsa-project.org>
References: <alsa-project/alsa-lib/pr/527@alsa-project.org>
Subject: 
 =?utf-8?q?alsa-lib=3A_security_hardening_=E2=80=94_UCM=2C_conf_parser=2C_topology=2C_PCM_plugins_=286_findings=29?=
Date: Sat, 19 Sep 2026 07:11:19 +0200 (CEST)
Message-ID-Hash: BZANYAJZ7AHTR3ZT3AKXAIDT4LLLIEU7
X-Message-ID-Hash: BZANYAJZ7AHTR3ZT3AKXAIDT4LLLIEU7
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BZANYAJZ7AHTR3ZT3AKXAIDT4LLLIEU7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTI3IHdhcyBvcGVuZWQgZnJvbSBI
YXJzaFJhalNpbmdoYW5pYToKClRoaXMgUFIgYWRkcmVzc2VzICoqc2l4IGluZGVwZW5kZW50bHkt
dHJpZ2dlcmVkIHNlY3VyaXR5IGhhcmRlbmluZyBpc3N1ZXMqKiBmb3VuZCBkdXJpbmcgYSBzb3Vy
Y2UgYXVkaXQgb2YgY29tbWl0IGBmODRjZDRjYCwgYWxsIHZlcmlmaWVkIHdpdGggcHJvb2Ytb2Yt
Y29uY2VwdCBwcm9ncmFtcy4KCkEzIChgc2hlbGxgL2BzeXN0ZW0oKWApIGFuZCBBNiAoUENNIGZp
bGUgYHBvcGVuYCkgYXJlIGludGVudGlvbmFsIGZlYXR1cmVzIGFuZCBhcmUgbm90IHBhdGNoZWQg
aGVyZSDigJQgaGFyZGVuaW5nIHN1Z2dlc3Rpb25zIG5vdGVkIGlubGluZSBmb3IgbWFpbnRhaW5l
ciBjb25zaWRlcmF0aW9uLgoKLS0tCgojIyMgQTEg4oCUIFVDTSBgc3lzd2AgcGF0aCB0cmF2ZXJz
YWwgKENXRS0yMikgwrcgYHNyYy91Y20vbWFpbi5jYApgZXhlY3V0ZV9zeXN3KClgIGNvbmNhdGVu
YXRlcyB0aGUgc3lzZnMgcm9vdCB3aXRoIGEgY2FsbGVyLXN1cHBsaWVkIHN0cmluZyB2aWEgYHNu
cHJpbnRmKClgIHdpdGggbm8gYC4uYCByZWplY3Rpb24gb3IgYHJlYWxwYXRoKClgIGNvbmZpbmVt
ZW50LiBBIFVDTSBwYXRoIGxpa2UgYC4uLy4uL2V0Yy9jcm9uLmQveDp2YWx1ZWAgd3JpdGVzIHRv
IGFuIGFyYml0cmFyeSBmaWxlc3lzdGVtIGxvY2F0aW9uLiAqKkZpeDoqKiBgcmVhbHBhdGgoKWAg
Y29uZmluZW1lbnQg4oCUIHJlamVjdCBpZiByZXNvbHZlZCBwYXRoIGRvZXMgbm90IHJlbWFpbiB3
aXRoaW4gdGhlIHN5c2ZzIHJvb3QuCgojIyMgQTIg4oCUIFVDTSBgY2ZnLXNhdmVgIHVucmVzdHJp
Y3RlZCBwYXRoIChDV0UtNzMpIMK3IGBzcmMvdWNtL21haW4uY2AKYGV4ZWN1dGVfY2Znc2F2ZSgp
YCBjYWxscyBgc25kX291dHB1dF9zdGRpb19vcGVuKCZvdXQsIGZpbGUsICJ3KyIpYCB3aXRoIGEg
cmF3IGNhbGxlci1zdXBwbGllZCBgZmlsZWAgYW5kIG5vIHJlc3RyaWN0aW9uLiBBbnkgd3JpdGFi
bGUgcGF0aCAoZS5nLiBgfi8uc3NoL2F1dGhvcml6ZWRfa2V5c2ApIGlzIHJlYWNoYWJsZS4gKipG
aXg6KiogYHJlYWxwYXRoKClgIGNoZWNrIOKAlCBjb25maW5lIHRvIGBYREdfUlVOVElNRV9ESVJg
IChmYWxsYmFjayBgL3RtcGApLgoKIyMjIEE0IOKAlCBDb25maWcgcGFyc2VyIGFic29sdXRlIGlu
Y2x1ZGUgdHJhdmVyc2FsIChDV0UtMjIpIMK3IGBzcmMvY29uZi5jYApgaW5wdXRfc3RkaW9fb3Bl
bigpYCBpbW1lZGlhdGVseSBvcGVucyBhbnkgYWJzb2x1dGUgcGF0aCAoYGZpbGVbMF09PScvJ2Ap
IHdpdGhvdXQgY2hlY2tpbmcgZm9yIGAuLmAgY29tcG9uZW50cy4gQSBwbGFudGVkIGNvbmZpZyB3
aXRoIGA8Ly4uLy4uL2V0Yy9zaGFkb3c+YCBjYW4gcmVhZCBhcmJpdHJhcnkgZmlsZXMuICoqRml4
OioqIHJlamVjdCBwYXRocyBjb250YWluaW5nIGAvLi4vYC4KCiMjIyBBNSDigJQgVG9wb2xvZ3kg
Y29udHJvbCBgdWludDMyX3RgIGludGVnZXIgb3ZlcmZsb3cgKENXRS0xOTApIMK3IGBzcmMvdG9w
b2xvZ3kvY3RsLmNgCmBzaXplMiA9IHgtPnNpemUgKyB4LT5wcml2LnNpemVgIGlzIGNvbXB1dGVk
IGluIDMyLWJpdCB1bnNpZ25lZCBhcml0aG1ldGljIGJlZm9yZSBiZWluZyB3aWRlbmVkIHRvIGBz
aXplX3RgLiBPbiBhIDY0LWJpdCBob3N0LCBgMHhGRkZGRkZGMCArIDB4MjAgPSAweDEwYCAod3Jh
cHMpLCBieXBhc3NpbmcgdGhlIHN1YnNlcXVlbnQgYHNpemUyID4gc2l6ZWAgZ3VhcmQuIFRocmVl
IHNpdGVzOiBgdHBsZ19kZWNvZGVfY29udHJvbF9taXhlcmAsIGB0cGxnX2RlY29kZV9jb250cm9s
X2VudW1gLCBgdHBsZ19kZWNvZGVfY29udHJvbF9ieXRlc2AgKGRpc3RpbmN0IGZyb20gQ1ZFLTIw
MjYtMjUwNjggd2hpY2ggd2FzIGB0cGxnX2RlY29kZV9jb250cm9sX21peGVyMWApLiAqKkZpeDoq
KiBwcmUtY2hlY2sgZm9yIG92ZXJmbG93LCB0aGVuIGAoc2l6ZV90KXgtPnNpemUgKyAoc2l6ZV90
KXgtPnByaXYuc2l6ZWAuCgojIyMgQTcg4oCUIFBDTSBgcm91dGVgIHBsdWdpbiB1bmJvdW5kZWQg
YHR0YWJsZWAgYWxsb2NhdGlvbiAoQ1dFLTc3MCkgwrcgYHNyYy9wY20vcGNtX3JvdXRlLmNgCmBj
c2l6ZWAvYHNzaXplYCBncm93IGZyb20gY29uZmlnLXN1cHBsaWVkIGNoYW5uZWwgaW5kaWNlcyB3
aXRoIG5vIHVwcGVyIGJvdW5kIGJlZm9yZSBgbWFsbG9jKGNzaXplICogc3NpemUgKiBzaXplb2Yo
ZW50cnkpKWAuIEluZGV4IGAxMDczNzQxODIzYCDihpIgYG1hbGxvYyg4IEdCKWAuICoqRml4Oioq
IGNhcCBib3RoIGF0IDEwMjQgKGNvbnNpc3RlbnQgd2l0aCBgZG1peGAsIGBzb2Z0dm9sYCwgb3Ro
ZXIgUENNIHBsdWdpbnMpLgoKIyMjIEE4IOKAlCBQQ00gYG11bHRpYCBzcGFyc2UgYmluZGluZ3Mg
T09CIGFzc2VydCAoQ1dFLTYxNykgwrcgYHNyYy9wY20vcGNtX211bHRpLmNgClNwYXJzZSBiaW5k
aW5nIG1hcHMgbGVhdmUgYHNpZHhzW2ldID09IC0xYCBmb3IgZ2FwIGluZGljZXMuIGBhc3NlcnQo
c2NoYW5uZWxzW2ldIDwgc2NoYW5uZWxzX2NvdW50W3NpZHhzW2ldXSlgIHRoZW4gZGVyZWZlcmVu
Y2VzIGBzY2hhbm5lbHNfY291bnRbLTFdYCDihpIgU0lHQUJSVCAoZGVidWcpIC8gT09CIHJlYWQg
KE5ERUJVRykuICoqRml4OioqIHJlcGxhY2UgYm90aCBgYXNzZXJ0KClgcyB3aXRoIGV4cGxpY2l0
IGAtRUlOVkFMYCByZXR1cm5zIHdpdGggYm91bmRzIGFuZCBzaWduIGNoZWNrcy4KCi0tLQoKKipW
ZXJpZmllZDoqKiBhbGwgc2l4IFBvQyBwcm9ncmFtcyBjb25maXJtZWQgb24gYGxpYmFzb3VuZDIg
MS4yLjE0YCAvIGBnY2MgMTQuMmAsIGNvbW1pdCBgZjg0Y2Q0Y2AuCgoqKlNpZ25lZC1vZmYtYnk6
KiogSGFyc2ggUmFqIFNpbmdoYW5pYSA8cmFqLmhhcnNocmF1dEBnbWFpbC5jb20+CgpSZXF1ZXN0
IFVSTCAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxpYi9wdWxsLzUy
NwpQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxp
Yi9wdWxsLzUyNy5wYXRjaApSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2Et
cHJvamVjdC9hbHNhLWxpYgo=
