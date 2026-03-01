Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA768FD0047
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:22:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ED3E6022E;
	Sun,  1 Mar 2026 20:22:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ED3E6022E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772392955;
	bh=FDVyy3Cuboy07Oih4ZXXXxbIfw/gEkA5rbAq/cjyqSQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=EQjou7Gi82v0vac7yb/z59kFxZ+aCQmlFGa4HscBO192f5eVGWIUGOPjdnR9k7LBl
	 Cb5+RGsnsxK9SWNTg2ShXP6aVsb/gspNDmPx7WAQUwvHuCij1HabDKQlEgK2FunXiq
	 9K32GpjMAjSReeRnZeNtiCizIDpROvZu4Dy3dY8w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84252F805F1; Sun,  1 Mar 2026 20:22:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10CB7F805EA;
	Sun,  1 Mar 2026 20:22:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75846F80524; Sun,  1 Mar 2026 20:19:43 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C9CAF8045D
	for <alsa-devel@alsa-project.org>; Sun,  1 Mar 2026 20:19:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C9CAF8045D
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1898cdd7a1519900-webhooks-bot@alsa-project.org>
In-Reply-To: <1898cdd79986d200-webhooks-bot@alsa-project.org>
References: <1898cdd79986d200-webhooks-bot@alsa-project.org>
Subject: Intel/sof-hda-dsp/Hdmi.conf: HDMI devices always registered with high
 priority regardless of availability,
 causing Speaker to be ignored as fallback sink
Date: Sun,  1 Mar 2026 20:19:43 +0100 (CET)
Message-ID-Hash: 523OOPVZOEKDSLEI2P4QEFBTGTF4BLWZ
X-Message-ID-Hash: 523OOPVZOEKDSLEI2P4QEFBTGTF4BLWZ
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/523OOPVZOEKDSLEI2P4QEFBTGTF4BLWZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzcxMSB3YXMgb3BlbmVkIGZyb20gYWJl
bGljOgoKIyMgRGVzY3JpcHRpb24KCkluIGB1Y20yL0ludGVsL3NvZi1oZGEtZHNwL0hkbWkuY29u
ZmAsIGFsbCB0aHJlZSBIRE1JIHBvcnRzIGFyZSByZWdpc3RlcmVkCnVuY29uZGl0aW9uYWxseSB1
c2luZyBgQ29uZGl0aW9uIHsgVHlwZSBBbHdheXNUcnVlIH1gIHdpdGggcHJpb3JpdGllcyA1MDAs
IDYwMAphbmQgNzAwLiBUaGUgbGFwdG9wIFNwZWFrZXIgaGFzIHByaW9yaXR5IDEwMCAoZnJvbSBg
SERBL0hpRmktYW5hbG9nLmNvbmZgKS4KClRoaXMgY2F1c2VzIFBpcGVXaXJlL1dpcmVQbHVtYmVy
IHRvIGFsd2F5cyBzZWxlY3QgSERNSTEgYXMgdGhlIGZhbGxiYWNrIHNpbmsKd2hlbiB0aGUgZGVm
YXVsdCBzaW5rIGJlY29tZXMgdW5hdmFpbGFibGUgKGUuZy4gQmx1ZXRvb3RoIHNwZWFrZXIgc3Vz
cGVuZHMpLApldmVuIHdoZW4gbm8gbW9uaXRvciBpcyBjb25uZWN0ZWQuIEF1ZGlvIGlzIHNpbGVu
dGx5IHJvdXRlZCB0byBIRE1JMSAoUlVOTklORwpzdGF0ZSB3aXRoIG5vIG91dHB1dCkgaW5zdGVh
ZCBvZiB0aGUgbGFwdG9wIFNwZWFrZXIuCgojIyBIYXJkd2FyZQoKLSBMYXB0b3A6IEh1YXdlaSBS
TEVGRy1YWCBNMTAxMAotIEF1ZGlvOiBJbnRlbCBSYXB0b3IgTGFrZS1QL1UvSCBjQVZTIChzb2Yt
aGRhLWRzcCkKLSBPUzogRmVkb3JhIDQzCi0gUGlwZVdpcmU6IDEuNC4xMAotIFdpcmVQbHVtYmVy
OiAwLjUuMTMKCiMjIFN0ZXBzIHRvIHJlcHJvZHVjZQoKMS4gQ29ubmVjdCBhIEJsdWV0b290aCBh
dWRpbyBkZXZpY2UKMi4gUGxheSBhdWRpbyDigJQgaXQgcm91dGVzIGNvcnJlY3RseSB0byBCbHVl
dG9vdGgKMy4gRGlzY29ubmVjdCBvciBzdXNwZW5kIHRoZSBCbHVldG9vdGggZGV2aWNlCjQuIEF1
ZGlvIGlzIHJvdXRlZCB0byBIRE1JMSBzaW5rIGluc3RlYWQgb2YgdGhlIGxhcHRvcCBTcGVha2Vy
CgojIyBPYnNlcnZlZCBiZWhhdmlvcgoKYHBhY3RsIGxpc3Qgc2hvcnQgc2lua3NgIHNob3dzIEhE
TUkxIGFzIFJVTk5JTkcgd2hpbGUgU3BlYWtlciBpcyBTVVNQRU5ERUQuCldpcmVQbHVtYmVyIHNl
bGVjdHMgSERNSTEgYXMgZmFsbGJhY2sgYmVjYXVzZSBpdHMgcHJpb3JpdHkgKDUwMCkgaXMgaGln
aGVyCnRoYW4gU3BlYWtlciAoMTAwKSwgZXZlbiB0aG91Z2ggbm8gbW9uaXRvciBpcyBjb25uZWN0
ZWQgYW5kIEhETUkgcG9ydHMgYXJlCnJlcG9ydGVkIGFzICJub3QgYXZhaWxhYmxlIi4KCiMjIEV4
cGVjdGVkIGJlaGF2aW9yCgpXaGVuIEhETUkgcG9ydHMgYXJlIG5vdCBhdmFpbGFibGUgKG5vIG1v
bml0b3IgY29ubmVjdGVkKSwgdGhlIFNwZWFrZXIgc2hvdWxkCmJlIHNlbGVjdGVkIGFzIHRoZSBm
YWxsYmFjayBzaW5rLgoKIyMgUmVsZXZhbnQgY29uZmlnCgpgdWNtMi9JbnRlbC9zb2YtaGRhLWRz
cC9IZG1pLmNvbmZgOgpgYGAKSWYuaGRtaTEgewogICAgICAgIENvbmRpdGlvbiB7IFR5cGUgQWx3
YXlzVHJ1ZSB9ICAgIyA8LS0gbm8gYXZhaWxhYmlsaXR5IGNoZWNrCiAgICAgICAgVHJ1ZS5NYWNy
by5oZG1pMS5IRE1JIHsKICAgICAgICAgICAgICAgIE51bWJlciAxCiAgICAgICAgICAgICAgICBE
ZXZpY2UgMwogICAgICAgICAgICAgICAgUHJpb3JpdHkgNTAwICAgICAgICAgICAgIyBoaWdoZXIg
dGhhbiBTcGVha2VyICgxMDApCiAgICAgICAgfQp9CgpJZi5oZG1pMiB7CiAgICAgICAgQ29uZGl0
aW9uIHsgVHlwZSBBbHdheXNUcnVlIH0KICAgICAgICBUcnVlLk1hY3JvLmhkbWkxLkhETUkgewog
ICAgICAgICAgICAgICAgTnVtYmVyIDIKICAgICAgICAgICAgICAgIERldmljZSA0CiAgICAgICAg
ICAgICAgICBQcmlvcml0eSA2MDAKICAgICAgICB9Cn0KCklmLmhkbWkzIHsKICAgICAgICBDb25k
aXRpb24geyBUeXBlIEFsd2F5c1RydWUgfQogICAgICAgIFRydWUuTWFjcm8uaGRtaTEuSERNSSB7
CiAgICAgICAgICAgICAgICBOdW1iZXIgMwogICAgICAgICAgICAgICAgRGV2aWNlIDUKICAgICAg
ICAgICAgICAgIFByaW9yaXR5IDcwMAogICAgICAgIH0KfQpgYGAKCmB1Y20yL0hEQS9IaUZpLWFu
YWxvZy5jb25mYCAocmVsZXZhbnQgZXhjZXJwdCk6CmBgYApWYWx1ZSB7CiAgICAgICAgUGxheWJh
Y2tQcmlvcml0eSAxMDAgICAgIyBTcGVha2VyIHByaW9yaXR5IOKAlCBsb3dlciB0aGFuIGFsbCBI
RE1JIHBvcnRzCiAgICAgICAgLi4uCn0KYGBgCgojIyBTdWdnZXN0ZWQgZml4CgpBZGQgYXZhaWxh
YmlsaXR5IGRldGVjdGlvbiBmb3IgSERNSSBwb3J0cyBiZWZvcmUgYXNzaWduaW5nIGhpZ2ggcHJp
b3JpdHksCm9yIGxvd2VyIEhETUkgcHJpb3JpdHkgd2hlbiB0aGUgcG9ydCBpcyBub3QgYXZhaWxh
YmxlLCBzaW1pbGFyIHRvIGhvdwpIZWFkcGhvbmVzIHVzZSBgSmFja0NvbnRyb2xgIGZvciBhdmFp
bGFiaWxpdHkgZGV0ZWN0aW9uLgoKSXNzdWUgVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9h
bHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9pc3N1ZXMvNzExClJlcG9zaXRvcnkgVVJMOiBodHRw
czovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
