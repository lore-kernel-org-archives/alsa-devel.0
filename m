Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9673BC77B61
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Apr 2023 02:51:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 728CB152F;
	Sat, 29 Apr 2023 04:50:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 728CB152F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682736694;
	bh=Qyj8bj3Hu9Va9RMPhLYmY2+lNzNF4Md+QDllSvrTEv8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ldP2RLd/tEl6HWcGv1480at+Ed40raSc3n5svZVE4RQOjYDzkm1uehIWoWY3tZvsV
	 4OvlZNi+QEbKtmSLA1yUd7S2itLlaaaVNnyo6fvt7wzdeg4wN1e7X5msC8dN+weldH
	 zBzhL23+LnqP/J6QQ3O8abS5/QKEZIZtCtOGjmpQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 41AD4F8025E;
	Sat, 29 Apr 2023 04:50:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 947AEF8025E; Sat, 29 Apr 2023 04:50:12 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 56F0CF800F8
	for <alsa-devel@alsa-project.org>; Sat, 29 Apr 2023 04:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56F0CF800F8
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1682736604321656227-webhooks-bot@alsa-project.org>
References: <1682736604321656227-webhooks-bot@alsa-project.org>
Subject: Update `test` '-a' and '-o' to '&&' and '||'
Message-Id: <20230429025012.947AEF8025E@alsa1.perex.cz>
Date: Sat, 29 Apr 2023 04:50:12 +0200 (CEST)
Message-ID-Hash: 3LHLDGK2ISKZ5ON56PRMMC2SCIMVMBCU
X-Message-ID-Hash: 3LHLDGK2ISKZ5ON56PRMMC2SCIMVMBCU
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3LHLDGK2ISKZ5ON56PRMMC2SCIMVMBCU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdXRpbHMgcHVsbCByZXF1ZXN0ICMyMDYgd2FzIG9wZW5lZCBmcm9t
IHdpbGV5aHk6CgpsaW5lcyA1MCwgMTAzOiBpbiB0d28gY29tcG91bmQgWydzLCByZXBsYWNlICct
YScgd2l0aCAnXSAmJiBbJw0KICBTQzIxNjYg4oCTIFByZWZlciBgWyBwIF0gJiYgWyBxIF1gIGFz
IGBbIHAgLWEgcSBdYCBpcyBub3Qgd2VsbCBkZWZpbmVkLiANCiAgU0MyMTA3IOKAkyBJbnN0ZWFk
IG9mIGBbIGEgJiYgYiBdYCwgdXNlIGBbIGEgXSAmJiBbIGIgXWAuDQoNCmxpbmUgNDU6IGluIGEg
Y29tcG91bmQgdGVzdCBjb21tYW5kLCBjaGFuZ2UgJy1vJyB0byAnfHwgdGVzdCcNCiAgU0MxMTM5
IOKAkyBVc2UgYHx8YCBpbnN0ZWFkIG9mIGAtb2AgYmV0d2VlbiB0ZXN0IGNvbW1hbmRzLg0KICBT
QzIxMDkg4oCTIEluc3RlYWQgb2YgYFsgYSB8fCBiIF1gLCB1c2UgYFsgYSBdIHx8IFsgYiBdYC4N
Cg0KaHR0cHM6Ly93d3cuc2hlbGxjaGVjay5uZXQvd2lraS9TQ1swLTldezR9CgpSZXF1ZXN0IFVS
TCAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXV0aWxzL3B1bGwvMjA2
ClBhdGNoIFVSTCAgICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdXRp
bHMvcHVsbC8yMDYucGF0Y2gKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNh
LXByb2plY3QvYWxzYS11dGlscwo=
