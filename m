Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AEEC5B572
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 18:36:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42E86601FC;
	Wed, 12 Aug 2026 20:36:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42E86601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786559802;
	bh=yJI4Z3zcYFraN7FmrE81Eh56WKO0KjexTCa+icLEYk8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rMMv2jA/GvUa1ItK3w3fTZ/K5ageFarEANYsVjFX7Swis60ehL1weFBXsJA5QAK5s
	 jKGTN4m849tY2BXS8unQ+GmYjJ1g1kyXIQRwc9GAKzNsI4OMh6DegGSOEAffT6yDw9
	 BPlpLHjr1N8OKNdpAhK3OnBY5nZ9Nl2fWgo8E30I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB572F805F5; Wed, 12 Aug 2026 20:36:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BC56F8010B;
	Wed, 12 Aug 2026 20:36:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7553DF804CF; Wed, 12 Aug 2026 20:35:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786559757;
	b=QHblLafp+RWcjRKGrL2MATMzIz/Ck1F93IxHoCKtjyAyNWcp6mstBMFwpzyxNiPVlbbe
	 NPTXkH/jog4g4EsLTwU7NkvqNQz09BpiWzVjJxNUd9SrR7ExqtHtb78kO0LRA6YOAz4ID
	 WUqvGYEPXuNAmahZ7uRiajD4LQTlYljRHUf8hVKqOpBFGDR0/zfZ4RnQ/qb81ghjDZ8MW
	 AB/Wc4LmtXY7np5z8Bl+LfX0AllDPiOUL6bvFCxzTYQ+0mQO085BGUMk+L5OTW9QeWR5w
	 RbHXPCdwgS6Q78GfFiSy5DlKDzzDO6Zr+ramm9fVze0/IVm/b5K1NgwveibHsMzQLUA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786559757;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=yJI4Z3zcYFraN7FmrE81Eh56WKO0KjexTCa+icLEYk8=;
	b=Cf8ceil08+Z7fTxVLraK4F5jnJ2HsHjUTi6PPhdM/+kdafkKVH5ydGBTiQp0w3EKnw92
	 hkqrcCwYMxt5Q/SNAznIRq80E5synVsk9aNn98B2XaTxr2krayukIf7iNGFOt5a44nLwm
	 lK0uOQcagKVt+OFo+B2sYKVzpn1FcFcRaeqY7hn3Vv27X1MwBQ9XcOdGVWAUynA91ah1d
	 2n/FoO/68NCXJEYxMBUcaPEI5q6hHrWxK1vtwUJlHoqzO1tgL9OfqZhe05nsexrc7TfzB
	 BrB8Sdvpyec7OE01YN6iUFu+fD639VQbxIqDQfFOOs70GmACO9cfEi3y0adZVNiylcA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 975D0F8010B
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2026 20:35:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 975D0F8010B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cb22a1f01c4100-webhooks-bot@alsa-project.org>
In-Reply-To: <18cb22a1efeab100-webhooks-bot@alsa-project.org>
References: <18cb22a1efeab100-webhooks-bot@alsa-project.org>
Subject: ALC4080 0b05:1999 (ASUS ROG Strix Z590-A Gaming WiFi): front
 Headphones output works but is disabled by HeadphonesName ""
Date: Wed, 12 Aug 2026 20:35:58 +0200 (CEST)
Message-ID-Hash: HPVBW7M3VVI5J2LQD6IYD7VHX76P2MP7
X-Message-ID-Hash: HPVBW7M3VVI5J2LQD6IYD7VHX76P2MP7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HPVBW7M3VVI5J2LQD6IYD7VHX76P2MP7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzgzMCB3YXMgb3BlbmVkIGZyb20gc3Rl
cGhlbnNlZGdlOgoKIyMjIFN1bW1hcnkKCk9uIHRoZSAqKkFTVVMgUk9HIFN0cml4IFo1OTAtQSBH
YW1pbmcgV2lGaSoqIChBTEM0MDgwLW92ZXItVVNCLCBgMGIwNToxOTk5YCkgaW4gYSBzdGFuZGFy
ZCBkZXNrdG9wIGNhc2UsIHRoZSBmcm9udC1wYW5lbCBoZWFkcGhvbmUgb3V0cHV0IGlzIGZ1bGx5
IGZ1bmN0aW9uYWwg4oCUIGJ1dCB0aGUgVUNNIHByb2ZpbGUgZGVsaWJlcmF0ZWx5IGhpZGVzIGl0
IHZpYSBgSGVhZHBob25lc05hbWUgIiJgIGluIHRoZSBgSWYuYXN1cy1yb2ctc3RyaXhgIGJsb2Nr
IG9mIGB1Y20yL1VTQi1BdWRpby9SZWFsdGVrL0FMQzQwODAtSGlGaS5jb25mYC4gUmVtb3Zpbmcg
dGhhdCBsaW5lIG1ha2VzIHRoZSBmcm9udCBoZWFkcGhvbmVzIHdvcmsgb3V0IG9mIHRoZSBib3gs
IHdpdGggd29ya2luZyBqYWNrIGRldGVjdGlvbi4KCiMjIyBFbnZpcm9ubWVudAoKLSBNb3RoZXJi
b2FyZDogQVNVUyBST0cgU1RSSVggWjU5MC1BIEdBTUlORyBXSUZJIChCSU9TIDEyMDIpLCBzdGFu
ZGFyZCBjYXNlIHdpdGggZnJvbnQtcGFuZWwgSEQtYXVkaW8gaGVhZGVyIHdpcmVkIHRvIGEgY29t
Ym8gaGVhZHNldCBqYWNrCi0gVVNCIGRldmljZTogYDBiMDU6MTk5OSBBU1VTVGVrIENvbXB1dGVy
LCBJbmMuIFVTQiBBdWRpb2AgKEFMQzQwODApCi0gYWxzYS1saWIgLyBhbHNhLXVjbS1jb25mIDEu
Mi4xNi4xIChGZWRvcmEgNDQpLCBQaXBlV2lyZS9XaXJlUGx1bWJlcgoKIyMjIEV2aWRlbmNlIHRo
ZSBoYXJkd2FyZSB3b3JrcwoKVGhlIGNvZGVjIGV4cG9zZXMgYSBmcm9udC1oZWFkcGhvbmUgcGxh
eWJhY2sgcGF0aCBvbiBQQ00gZGV2aWNlIDEgd2l0aCBhIGZ1bmN0aW9uYWwgamFjayBzZW5zb3I6
CgpgYGAKJCBhbWl4ZXIgLWMgMiBjb250cm9scyB8IGdyZXAgLWkgamFjawpudW1pZD0zMixpZmFj
ZT1DQVJELG5hbWU9J0hlYWRwaG9uZSAtIE91dHB1dCBKYWNrJwouLi4KYGBgCgpXaXRoIGhlYWRw
aG9uZXMgcGx1Z2dlZCBpbnRvIHRoZSBmcm9udCBqYWNrLCB0aGUgc2Vuc29yIHJlcG9ydHMgY29y
cmVjdGx5OgoKYGBgCiQgYW1peGVyIC1jIDIgY2dldCBudW1pZD0zMgogIDogdmFsdWVzPW9uICAg
ICAgICAjIG9mZiB3aGVuIHVucGx1Z2dlZCDigJQgZGV0ZWN0aW9uIHdvcmtzCmBgYAoKQW5kIGF1
ZGlvIHBsYXlzIG91dCBvZiB0aGUgZnJvbnQgamFjazoKCmBgYAokIGFtaXhlciAtYyAyIGNzZXQg
Im5hbWU9J1BDTSBQbGF5YmFjayBTd2l0Y2gnLGluZGV4PTEiIG9uCiQgc3BlYWtlci10ZXN0IC1E
IHBsdWdodzoyLDEgLWMgMiAtdCBzaW5lIC1mIDQ0MCAtbCAyICAgIyBhdWRpYmxlIG9uIGZyb250
IGhlYWRwaG9uZXMKYGBgCgpBZnRlciBkZWxldGluZyB0aGUgYEhlYWRwaG9uZXNOYW1lICIiYCBs
aW5lIGZyb20gdGhlIGBJZi5hc3VzLXJvZy1zdHJpeGAgYmxvY2ssIFBpcGVXaXJlIGV4cG9zZXMg
YSAiRnJvbnQgSGVhZHBob25lcyIgc2luayBhbG9uZ3NpZGUgIlNwZWFrZXJzIjsgYm90aCByb3V0
ZSBjb3JyZWN0bHksIGFuZCBwb3J0IGF2YWlsYWJpbGl0eSBmb2xsb3dzIHRoZSBqYWNrIHNlbnNv
cnMgYXMgZXhwZWN0ZWQuCgojIyMgV2h5IHRoZSBxdWlyayBleGlzdHMgKEkgdGhpbmspCgpUaGUg
YmxvY2sgd2FzIGFkZGVkIGluIGQ3NzFkZjAzICgiQWRkOiAwYjA1OjE5OTkgQVNVUyBST0cgU3Ry
aXggWjU5MC1BIEdhbWluZyBXaUZpIiwgZnJvbSBQUiAjMjQ3KSwgd2hvc2UgY29tbWl0IG1lc3Nh
Z2Ugbm90ZXMgdGhlIGJvYXJkICJpcyByZWNvZ25pemVkIGFzIGEgdGhlbGlvLW1pcmEtYjEgYnkg
c3lzdGVtNzYiLiBUaGUgU3lzdGVtNzYgVGhlbGlvIGNoYXNzaXMgaGFzIG5vIGZyb250LXBhbmVs
IGF1ZGlvIHdpcmVkLCB3aGljaCB3b3VsZCBleHBsYWluIHdoeSB0aGUgb3JpZ2luYWwgc3VibWl0
dGVyIGJsYW5rZWQgdGhlIEhlYWRwaG9uZXMgZGV2aWNlIOKAlCBvbiB0aGVpciBtYWNoaW5lIHRo
ZSBqYWNrIHBoeXNpY2FsbHkgZG9lc24ndCBleGlzdC4KCkJ1dCB0aGF0J3MgYSBjaGFzc2lzIHBy
b3BlcnR5LCBub3QgYSBib2FyZC9jb2RlYyBwcm9wZXJ0eS4gT24gYSBUaGVsaW8sIHRoZSBgSGVh
ZHBob25lIC0gT3V0cHV0IEphY2tgIGNvbnRyb2wgc2ltcGx5IHN0YXlzIGBvZmZgLCBzbyB3aXRo
IHRoZSBIZWFkcGhvbmVzIGRldmljZSBlbmFibGVkIHRoZSBwb3J0IHdvdWxkIGp1c3Qgc2hvdyBh
cyB1bmF2YWlsYWJsZSDigJQgamFjayBkZXRlY3Rpb24gYWxyZWFkeSBoYW5kbGVzIHRoZSB1bndp
cmVkIGNhc2UgZ3JhY2VmdWxseS4KCiMjIyBTdWdnZXN0ZWQgZml4CgpSZW1vdmUgYEhlYWRwaG9u
ZXNOYW1lICIiYCBmcm9tIHRoZSBgSWYuYXN1cy1yb2ctc3RyaXhgIChgMGIwNToxOTk5YCkgYmxv
Y2s6CgpgYGBkaWZmCiBJZi5hc3VzLXJvZy1zdHJpeCB7CiAJQ29uZGl0aW9uIHsKIAkJVHlwZSBS
ZWdleE1hdGNoCiAJCVN0cmluZyAiJHtDYXJkQ29tcG9uZW50c30iCiAJCVJlZ2V4ICJVU0IoMGIw
NToxOTk5KSIKIAl9CiAJVHJ1ZS5EZWZpbmUgewogCQlMaW5lMVBDTSAiMyIKLQkJSGVhZHBob25l
c05hbWUgIiIKIAl9CiB9CmBgYAoKSSdtIHJ1bm5pbmcgd2l0aCBleGFjdGx5IHRoaXMgY2hhbmdl
IGxvY2FsbHkgYW5kIGV2ZXJ5dGhpbmcgKGZyb250IGhlYWRwaG9uZXMsIHJlYXIgc3BlYWtlcnMs
IGphY2sgZGV0ZWN0aW9uLCBwcm9maWxlIHN3aXRjaGluZykgYmVoYXZlcyBjb3JyZWN0bHkuIEhh
cHB5IHRvIHByb3ZpZGUgYGFsc2EtaW5mb2Agb3V0cHV0IG9yIHRlc3QgcGF0Y2hlcy4KCklzc3Vl
IFVSTCAgICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYv
aXNzdWVzLzgzMApSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVj
dC9hbHNhLXVjbS1jb25mCg==
