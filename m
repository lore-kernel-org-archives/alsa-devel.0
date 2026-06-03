Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB2FCD6E5D
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:17:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F367160236;
	Wed,  3 Jun 2026 03:17:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F367160236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780449470;
	bh=ScEH6NBwRJOcxBHr90ohgctyyghBdyUERveLOiI+BuE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KhYHBymgRpZu8kuw9AvY/y/i/htAzXBDPTVTVAxoILWRvf90LVjLV5IJ4Gms1hHtz
	 BubHin6N0jOKbpVn4Kvw6QV1ZoMhSLkUvhm0/vHBqiUt6AWca9D+uXpItEHdMzfoli
	 a9zETXngUwPqIF6dJPSD9wxz2TF2qHMY6NjU+sE4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3247F805EB; Wed,  3 Jun 2026 03:17:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73F1CF805EA;
	Wed,  3 Jun 2026 03:17:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C685F8045D; Wed,  3 Jun 2026 03:17:03 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B566F8015B
	for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2026 03:16:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B566F8015B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b56d5017f24b00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b56d5017c45200-webhooks-bot@alsa-project.org>
References: <18b56d5017c45200-webhooks-bot@alsa-project.org>
Subject: Issue with alsamixer
Date: Wed,  3 Jun 2026 03:17:03 +0200 (CEST)
Message-ID-Hash: MLQ3QFCXYAGQ4E5WVKW4GMTHYHKYWRNH
X-Message-ID-Hash: MLQ3QFCXYAGQ4E5WVKW4GMTHYHKYWRNH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MLQ3QFCXYAGQ4E5WVKW4GMTHYHKYWRNH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdXRpbHMgaXNzdWUgIzMzMSB3YXMgb3BlbmVkIGZyb20gZmlzaGJv
bDoKCmFsc2EtdXRpbHMgdmVyc2lvbiB0aGUgaXNzdWUgaGFzIGJlZW4gc2VlbiB3aXRoCjEuMi4x
NgoKVXNlZCBkaXN0cmlidXRpb24KYXJjaGxpbnV4CgpMaW51eCBrZXJuZWwgdmVyc2lvbiB1c2Vk
CjcuMC4xMQoKQ1BVIGFyY2hpdGVjdHVyZXMgaXNzdWUgd2FzIHNlZW4gb24KeDg2XzY0CgoKVW5l
eHBlY3RlZCBiZWhhdmlvdXIgeW91IHNhdwpBIHByb21wdCBhcHBlYXJzIHdoZW4gSSBjbG9zZSBh
bHNhbWl4ZXLvvJoKCltXXVswNzo0NjoyNy45NDg3NTJdIHB3LmNvbmYgICAgICB8IFsgICAgICAg
ICAgY29uZi5jOiAgNTE1IHB3X2NvbmZfbG9hZF9jb25mKCldIHNjYW5kaXIgL2V0Yy9waXBld2ly
ZS9jbGllbnQuY29uZi5kIGZhaWxlZDogUGVybWlzc2lvbiBkZW5pZWQKCklzc3VlIFVSTCAgICAg
OiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdXRpbHMvaXNzdWVzLzMzMQpS
ZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXV0aWxz
Cg==
