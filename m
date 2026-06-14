Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99A2CD98C5
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Jun 2026 14:28:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFE8C601FF;
	Sun, 14 Jun 2026 16:28:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFE8C601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781447334;
	bh=mJg3NYn1qoh/eYUXq3u4AFWHIfJH/S3j03SctDA9kio=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=roMQsoJA1/LJfLNSCBGM8kj0ROvpbjuJYun/fY9ix3zBPVi8AKGvMU5td6dn/ZWqN
	 dbSOjEpnAvxX4P4gcfqduyFs5RLZGlQlojHvzYn+waFgjF2bUGKWRqJMn48UxWHffd
	 hnHSy+KLMWLpHYxwxmFJ9UyER4B2sgwHZXHakm6Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42C55F805F6; Sun, 14 Jun 2026 16:28:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CF2E0F80600;
	Sun, 14 Jun 2026 16:28:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64167F804F2; Sun, 14 Jun 2026 16:28:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781447295;
	b=B0x8ya+ccaZ+IodwsyVyBlfQccRNRO8FZzXsc5GS3eix2Cxi5nvfgcHj0iislYd5LMbf
	 6M3v9tEUveyk8YH0P4jEgsl2S3eGOnuPE8jgoBVFdZlDJKU8iUTQirUOTK/vSa9R65PBF
	 Vg4VM5to9HebBBdhLCiiqnDjp0BcF9fiWbZrkVzb1iNx+i0fYwpXIrxvPKVuqlPNnWTua
	 XEi0eT/Yp3rNsEeWXlA4Lk6jiBo37m+7zazR83iGTuqHgbkUkEEm8AxJ5k23iPgIFLAy7
	 /6z368scxRb9gT+vIagZvmkvs0e3jv9iwfyT4TE2lzr4t+KlfrWr9d5TkRm2O1F+rJw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781447295;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=mJg3NYn1qoh/eYUXq3u4AFWHIfJH/S3j03SctDA9kio=;
	b=Pdz9x5zEiGYP0Fuv3CaFtoVy7aLZ1DBnAjJ12jK8uOz1H/bWZliZho/BK9T1gRQoVcCo
	 Tpf8IOHznKOk4Z4QQVRRgT+zRefi0/ucJul6JxIscQlXLsta3cLoQQM0Dls0cEVvQbcmi
	 csF1Z1vnT2Y4JuYiNJZsXRMpvGTYrg46rehUBlPmPYBGQRuu2fsXpM81+amIQM+Ga66lV
	 0q6E8/ysagJjlohNjEPl+qnLoLi+YhOhFyCMz61kWcYzwcueK3qKl2VE1qx3KhUDBf5Tk
	 TZT1R1r2t15eMHUa/ICo/jINH4wLcQwgiYU8E/6guMUxpZR8sbvDluIzuhNa8oc+vmg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 602E4F8010B
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2026 16:28:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 602E4F8010B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b8f8e013cfda00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b8f8e013c3d000-webhooks-bot@alsa-project.org>
References: <18b8f8e013c3d000-webhooks-bot@alsa-project.org>
Subject: Internal microphone saturates at 100% volume on ASUS TUF Gaming A15
 (Realtek ALC256)
Date: Sun, 14 Jun 2026 16:28:16 +0200 (CEST)
Message-ID-Hash: GCA5TBY2X6FDMDYPF6ZQTHMFFSLXCIIT
X-Message-ID-Hash: GCA5TBY2X6FDMDYPF6ZQTHMFFSLXCIIT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GCA5TBY2X6FDMDYPF6ZQTHMFFSLXCIIT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzc5MCB3YXMgb3BlbmVkIGZyb20gR2lv
c3N1ZToKCiMjIyBTdW1tYXJ5CgpUaGUgaW50ZXJuYWwgbWljcm9waG9uZSBvZiB0aGUgQVNVUyBU
VUYgR2FtaW5nIEExNSAoRkE1MDZRTSkgc2F0dXJhdGVzL2Rpc3RvcnRzIHdoZW4gdGhlIHN5c3Rl
bSBjYXB0dXJlIHZvbHVtZSBpcyBzZXQgYWJvdmUgfjUwJS4gVGhlIEFMU0EgaGFyZHdhcmUgdm9s
dW1lIHJhbmdlIGlzIDDigJM2MyBzdGVwcywgd2hlcmUgc3RlcCA2MyBjb3JyZXNwb25kcyB0byBh
cHByb3hpbWF0ZWx5ICszMCBkQi4gQXQgc3RlcCAzMSAofjAgZEIgLyB+NDklIHBoeXNpY2FsIGdh
aW4pIHRoZSBtaWNyb3Bob25lIHNvdW5kcyBjbGVhbi4KCkN1cnJlbnRseSwgdGhlIGRlZmF1bHQg
cHJvZmlsZSBleHBvc2VzIHRoZSBmdWxsIDDigJM2MyBzdGVwIHJhbmdlIHRvIHRoZSBVSSB2b2x1
bWUgc2xpZGVyLCBzbyAxMDAlIHN5c3RlbSB2b2x1bWUgbWFwcyB0byArMzAgZEIgcGh5c2ljYWwg
Z2FpbiwgY2xpcHBpbmcgdGhlIGJ1aWx0LWluIG1pY3JvcGhvbmUgY2Fwc3VsZS4KCkkgYW0gb3Bl
bmluZyB0aGlzIGlzc3VlIHRvIHJlcXVlc3QgYW4gdXBzdHJlYW0gZml4IChzdWNoIGFzIGEgVUNN
IHByb2ZpbGUgb3IgaGFyZHdhcmUgcXVpcmspIGZvciB0aGlzIGxhcHRvcCBtb2RlbCwgc28gdGhl
IGxpbWl0YXRpb24gaXMgYXBwbGllZCBjb3JyZWN0bHkgYXQgdGhlIEFMU0EgbGV2ZWwgZm9yIGFs
bCBMaW51eCBkaXN0cmlidXRpb25zLgoKIyMjIEVudmlyb25tZW50CgotICoqSGFyZHdhcmU6Kiog
QVNVUyBUVUYgR2FtaW5nIEExNSAoRkE1MDZRTSkKLSAqKkF1ZGlvIGNvZGVjOioqIFJlYWx0ZWsg
QUxDMjU2IChgSERBOjEwZWMwMjU2LDEwNDMxNjgyLDAwMTAwMDAyYCkKLSAqKkRpc3RyaWJ1dGlv
bjoqKiBDYWNoeU9TIC8gQXJjaCBMaW51eCBiYXNlCi0gKipLZXJuZWw6KiogNi4xMS1jYWNoeW9z
IChvciBzcGVjaWZ5IGV4YWN0IHZlcnNpb24pCi0gKipQaXBlV2lyZToqKiAxLjAuMCAob3Igc3Bl
Y2lmeSBleGFjdCB2ZXJzaW9uKQotICoqRGVza3RvcDoqKiBLREUgUGxhc21hIDYsIFdheWxhbmQK
CiMjIyBTdGVwcyB0byByZXByb2R1Y2UKCjEuIEJvb3QgdGhlIGxhcHRvcCBvbiBhIGZyZXNoIExp
bnV4IHNlc3Npb24uCjIuIE9wZW4gYW55IGFwcGxpY2F0aW9uIHRoYXQgdXNlcyB0aGUgaW50ZXJu
YWwgbWljcm9waG9uZSAoRGlzY29yZCwgV2ViUlRDLCBBdWRhY2l0eSwgZXRjLikuCjMuIFNldCB0
aGUgbWljcm9waG9uZSB2b2x1bWUgdG8gMTAwJSBpbiB0aGUgc3lzdGVtIG1peGVyLgo0LiBSZWNv
cmQgb3IgbW9uaXRvciB0aGUgbWljcm9waG9uZS4KCiMjIyBFeHBlY3RlZCBiZWhhdmlvcgoKQXQg
MTAwJSBVSSBzeXN0ZW0gdm9sdW1lLCB0aGUgbWljcm9waG9uZSBzaG91bGQgcmVhY2ggYSBjbGVh
biwgbm9uLXNhdHVyYXRpbmcgZ2FpbiBsZXZlbCBzdWl0YWJsZSBmb3IgdGhlIGJ1aWx0LWluIG1p
YyBjYXBzdWxlIChoYXJkd2FyZSBzdGVwIDMxIC8gMCBkQikuCgojIyMgQWN0dWFsIGJlaGF2aW9y
CgpUaGUgYXVkaW8gaXMgaGVhdmlseSBkaXN0b3J0ZWQvY2xpcHBlZCBkdWUgdG8gZXhjZXNzaXZl
IGhhcmR3YXJlIGdhaW4uIExvd2VyaW5nIHRoZSBzeXN0ZW0gdm9sdW1lIHRvIGFyb3VuZCA1MCUg
bWFrZXMgaXQgc291bmQgY2xlYW4uCgojIyMgQUxTQSBoYXJkd2FyZSBkZXRhaWxzCgpgYGBiYXNo
CiQgYW1peGVyIC1jIDIgc2dldCBDYXB0dXJlClNpbXBsZSBtaXhlciBjb250cm9sICdDYXB0dXJl
JywwCiAgQ2FwYWJpbGl0aWVzOiBjdm9sdW1lIGNzd2l0Y2gKICBDYXB0dXJlIGNoYW5uZWxzOiBG
cm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IENhcHR1cmUgMCAtIDYzCiAgRnJvbnQg
TGVmdDogQ2FwdHVyZSA2MyBbMTAwJV0gWzMwLjAwZEJdIFtvbl0KICBGcm9udCBSaWdodDogQ2Fw
dHVyZSA2MyBbMTAwJV0gWzMwLjAwZEJdIFtvbl0KYGBgCgotIFN0ZXAgMCDiiYggLTk2IGRCIChl
ZmZlY3RpdmVseSBtdXRlZCkKLSBTdGVwIDMxIOKJiCAwIGRCIC8gfjQ5JSBwaHlzaWNhbCBnYWlu
IChjbGVhbiBsZXZlbCkKLSBTdGVwIDYzIOKJiCArMzAgZEIgLyAxMDAlIHBoeXNpY2FsIGdhaW4g
KHNhdHVyYXRlcykKCiMjIyBVc2VyLXNwYWNlIFdvcmthcm91bmQgdXNlZAoKSSBtYW5hZ2VkIHRv
IHNvbHZlIHRoaXMgbG9jYWxseSB1c2luZyBQaXBlV2lyZS9QdWxzZUF1ZGlvIEFMU0EgQ2FyZCBQ
cm9maWxlcywgYnV0IEkgdW5kZXJzdGFuZCB0aGlzIHNob3VsZCBpZGVhbGx5IGJlIGhhbmRsZWQg
YnkgQUxTQSBVQ00gb3Iga2VybmVsIHF1aXJrczoKCjEuIEN1c3RvbSBBTFNBIENhcmQgUHJvZmls
ZSBpbiBgL2V0Yy9hbHNhLWNhcmQtcHJvZmlsZS9taXhlci9wcm9maWxlLXNldHMvZGVmYXVsdC5j
b25mYDoKYGBgaW5pCltEZWNpYmVsRml4IENhcHR1cmVdCmRiLXZhbHVlcyA9IDA6LTk2LjAwICAz
MTowLjAwCmBgYAoKMi4gV2lyZVBsdW1iZXIgcnVsZSBpbiBgfi8uY29uZmlnL3dpcmVwbHVtYmVy
L3dpcmVwbHVtYmVyLmNvbmYuZC9taWMtaWdub3JlLWRiLmNvbmZgOgpgYGBsdWEKbW9uaXRvci5h
bHNhLnJ1bGVzID0gWwogIHsKICAgIG1hdGNoZXMgPSBbCiAgICAgIHsKICAgICAgICBkZXZpY2Uu
bmFtZSA9ICJhbHNhX2NhcmQucGNpLTAwMDBfMDZfMDAuNiIKICAgICAgfQogICAgXQogICAgYWN0
aW9ucyA9IHsKICAgICAgdXBkYXRlLXByb3BzID0gewogICAgICAgIGFwaS5hbHNhLmlnbm9yZS1k
QiA9IHRydWUKICAgICAgfQogICAgfQogIH0KXQpgYGAKClJlc3VsdCBhZnRlciB0aGlzIHdvcmth
cm91bmQ6CjEwMCUgVUkgdm9sdW1lIG1hcHMgdG8gc3RlcCAzMS82MyAofjQ5JSBwaHlzaWNhbCBo
YXJkd2FyZSBnYWluKS4gVGhlIG1pY3JvcGhvbmUgaXMgY29tcGxldGVseSBjbGVhbiBhbmQgdGhl
IHdob2xlIFVJIHNsaWRlciByZW1haW5zIHVzYWJsZS4KCiMjIyBTdWdnZXN0ZWQgZml4CgpJbXBs
ZW1lbnQgYSBVQ00yIHByb2ZpbGUgb3IgaGFyZHdhcmUgZGF0YWJhc2UgcXVpcmsgZm9yIHRoZSBB
U1VTIFRVRiBHYW1pbmcgQTE1IChgSERBOjEwZWMwMjU2LDEwNDMxNjgyLDAwMTAwMDAyYCkgdGhh
dCBjb3JyZWN0bHkgbGltaXRzIHRoZSBgQ2FwdHVyZWAgbWF4aW11bSB0byAwIGRCLCBzbyB1cHBl
ciBsYXllcnMgKFdpcmVQbHVtYmVyL1B1bHNlQXVkaW8pIG1hcCAxMDAlIHZvbHVtZSBzYWZlbHku
CgojIyMgQWRkaXRpb25hbCBpbmZvcm1hdGlvbgoKSSBhbSB3aWxsaW5nIHRvIHRlc3QgYW55IFVD
TSBjb25maWd1cmF0aW9ucyBvciBmaXhlcy4gTXkgYGFsc2EtaW5mby5zaGAgb3V0cHV0IGlzOiBo
dHRwczovL2Fsc2EtcHJvamVjdC5vcmcvZGIvP2Y9ZGM4ZWZhZTQyOTMyNWVhZDcxMDMzODFlZTM0
ODg0YzVmOWQ3MzVlNQoKSXNzdWUgVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXBy
b2plY3QvYWxzYS11Y20tY29uZi9pc3N1ZXMvNzkwClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dp
dGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
