Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C2BCD98D2
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Jun 2026 14:19:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E429A601FF;
	Sun, 14 Jun 2026 16:19:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E429A601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781446785;
	bh=I+l5T4RyRXQ+PAw5Fetu3PsqaVHLvW/tdwEsJaGAfeg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WfRD7MS4oOwMmj963lhQOE3BVF0QVyyVOe3NmNfhenm24KXEKUpKVqwTxlHPSemiq
	 Ku7aDRjbClj3oBxw9YJ/W0m8eya7uvycwtMzYPnj2MKLzsIOpcVU4gSj3tapcdNBbI
	 F9HgGUkMfwmwyUxivYZHmZW0UFttx/GgfkjJjWq0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A66CEF805FB; Sun, 14 Jun 2026 16:19:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EA5CF805F1;
	Sun, 14 Jun 2026 16:19:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8A1AF804F2; Sun, 14 Jun 2026 16:19:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781446745;
	b=YLQKsAyDS2FLpcHP3X+082/508kagQ26gnFrU49ooFrQB0XFVOWAtbQsxh4U/4Paz3l1
	 TzlsuTzZfCwdM5InE/PaVAyF73PInUjNKYGAiCKnD/loxGr6cz1mdP/4kPk1DK7PlbML4
	 WsNLrwg0+/KYoADxbgvOWfOfvxSwt0IaA3P+fPJF9pH1BtgQRizAapgKv0/ABYvumY5dC
	 3y2Z5fAxsrXTvT11QuxY6HNYZWnHUKzGY14muaorMdl2Xo0rVIMh0olw+4WXnAtl7gBXC
	 e21BHELWvheCHTE9Vhh41Y0U+Y0AWTR7d8/CcF9GnvUFnKNrq2MiSeaqvcjpsC8Xxqg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781446745;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=I+l5T4RyRXQ+PAw5Fetu3PsqaVHLvW/tdwEsJaGAfeg=;
	b=BeG/q6CSj/GHjgmpj6skjCbpX6bvurokxYB8DuEabqRi6QbBy180rJtsk2CRlbS1ikiV
	 IM7V158ZbtZTU/Y01AMrpQQxNEsrYxhgcIcNpUJ+0mBTX5qNt55iBPdXJk2fU/AhqLQ+e
	 y1nE6QgatYuJDu6a4/f/4x4p1dDZBWkfGFIS3T7xxymFzCb46xmSGC2VdyqiHHNsGLWWr
	 7e9sZfiqzXxwXoAY1YImOW0YsS5gSc+3CqAZChzOGcY4r7AVchgK8LN/yW3AskYgyTqq4
	 0kHE7T0nLqc0cSeOtTryU+bss4lz/kWNI+z+z8naLMi0d/at72IeqMdqkzLHSI/OugQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 507A0F8010B
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2026 16:19:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 507A0F8010B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b8f85fee315f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/789@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/789@alsa-project.org>
Subject: USB-Audio: ALC4082 - add MSI MEG X870E GODLIKE (0db0:e5c3)
Date: Sun, 14 Jun 2026 16:19:05 +0200 (CEST)
Message-ID-Hash: LW4GHNDELFNM7NRG5UQSFHL24ZPYZMP4
X-Message-ID-Hash: LW4GHNDELFNM7NRG5UQSFHL24ZPYZMP4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LW4GHNDELFNM7NRG5UQSFHL24ZPYZMP4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3ODkgd2FzIG9wZW5lZCBm
cm9tIFRvbWNhdHQ6CgojIyBTdW1tYXJ5CgpUaGUgTVNJIE1FRyBYODcwRSBHT0RMSUtFIChNUy03
RTQ4KSB1c2VzIHRoZSBSZWFsdGVrIEFMQzQwODIgY29kZWMKcHJlc2VudGVkIGFzIGEgVVNCIEF1
ZGlvIGNsYXNzIGRldmljZSAoVVNCIElEIDBkYjA6ZTVjMykuCgpUd28gZml4ZXM6CgoqKjEuIGB1
Y20yL1VTQi1BdWRpby9VU0ItQXVkaW8uY29uZmAqKiDigJQgYWRkIGBlNWMzYCB0byB0aGUgQUxD
NDA4MApwcm9maWxlIG1hdGNoIHNvIHRoZSBkZXZpY2UgaXMgcmVjb2duaXNlZCBhbmQgcm91dGVk
IHRvIHRoZSBjb3JyZWN0CnByb2ZpbGUuCgoqKjIuIGB1Y20yL1VTQi1BdWRpby9SZWFsdGVrL0FM
QzQwODAtSGlGaS5jb25mYCoqIOKAlCBhZGQgYGU1YzNgIHRvIHRoZQpgc3BkaWZfZGV2MmAgY29u
ZGl0aW9uLiBPbiB0aGlzIGJvYXJkIHRoZSBvcHRpY2FsIFMvUERJRiBvdXRwdXQgaXMgb24KQUxT
QSBzdWItZGV2aWNlIDIgKEludGVyZmFjZSA2LCBFbmRwb2ludCA4IE9VVCwgc3RlcmVvLCB1cCB0
byAxOTIga0h6KQpyYXRoZXIgdGhhbiB0aGUgZGVmYXVsdCBzdWItZGV2aWNlIDMuIFdpdGhvdXQg
dGhpcyBmaXggdGhlCmBpZWM5NTgtc3RlcmVvYCBBQ1AgcHJvZmlsZSBwcm9kdWNlcyB2YWxpZCBT
L1BESUYgZnJhbWluZyDigJQgdGhlCnJlY2VpdmVyIGxvY2tzIG9uIGFuZCBjbGlja3Mg4oCUIGJ1
dCB0aGUgUENNIGF1ZGlvIHBheWxvYWQgaXMgc2lsZW50LgpSb3V0aW5nIHRvIHN1Yi1kZXZpY2Ug
MiBjb25maXJtZWQgd29ya2luZy4KCiMjIEhhcmR3YXJlCgotIEJvYXJkOiBNU0kgTUVHIFg4NzBF
IEdPRExJS0UgKE1TLTdFNDgpCi0gVVNCIGRldmljZTogYDBkYjA6ZTVjMyBNaWNybyBTdGFyIElu
dGVybmF0aW9uYWwgVVNCIEF1ZGlvYAotIEtlcm5lbDogNy4wLjEyIChDYWNoeU9TKSwgQUxTQSBg
c25kLXVzYi1hdWRpb2AKLSBgbHN1c2JgOiBgQnVzIDAwMyBEZXZpY2UgMDA1OiBJRCAwZGIwOmU1
YzMgTWljcm8gU3RhciBJbnRlcm5hdGlvbmFsIFVTQiBBdWRpb2AKCiMjIFZlcmlmaWNhdGlvbgoK
YGBgCiQgYXBsYXkgLWwgfCBncmVwIC1BMSAnY2FyZCA0JwpjYXJkIDQ6IEF1ZGlvIFtVU0IgQXVk
aW9dLCBkZXZpY2UgMDogVVNCIEF1ZGlvIFtVU0IgQXVkaW9dCmNhcmQgNDogQXVkaW8gW1VTQiBB
dWRpb10sIGRldmljZSAxOiBVU0IgQXVkaW8gW1VTQiBBdWRpbyAjMV0KY2FyZCA0OiBBdWRpbyBb
VVNCIEF1ZGlvXSwgZGV2aWNlIDI6IFVTQiBBdWRpbyBbVVNCIEF1ZGlvICMyXSAg4oaQIG9wdGlj
YWwgUy9QRElGCmNhcmQgNDogQXVkaW8gW1VTQiBBdWRpb10sIGRldmljZSAzOiBVU0IgQXVkaW8g
W1VTQiBBdWRpbyAjM10KCiQgcGFwbGF5IC0tZGV2aWNlPWFsc2Ffb3V0cHV0LnVzYi1HZW5lcmlj
X1VTQl9BdWRpby0wMC5wcm8tb3V0cHV0LTIgXAogICAgL3Vzci9zaGFyZS9zb3VuZHMvYWxzYS9G
cm9udF9DZW50ZXIud2F2CiMgQXVkaW8gY29uZmlybWVkIHJlY2VpdmVkIGJ5IGFtcGxpZmllciB2
aWEgb3B0aWNhbCBUT1NMSU5LCmBgYAoKV2l0aG91dCB0aGUgYHNwZGlmX2RldjJgIGZpeCwgYGh3
OkF1ZGlvLDNgIHByb2R1Y2VzIGEgdmFsaWQgUy9QRElGCmNhcnJpZXIgKHJlY2VpdmVyIHJlbGF5
IGNsaWNrcykgYnV0IHNpbGVudCBQQ00uIFdpdGggdGhlIGZpeCwKYGh3OkF1ZGlvLDJgIGRlbGl2
ZXJzIGF1ZGlvIGNvcnJlY3RseS4KClJlcXVlc3QgVVJMICAgOiBodHRwczovL2dpdGh1Yi5jb20v
YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvcHVsbC83ODkKUGF0Y2ggVVJMICAgICA6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxsLzc4OS5wYXRjaApS
ZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1j
b25mCg==
