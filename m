Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F5BC7619A
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Apr 2023 07:46:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BBE4E90;
	Wed,  5 Apr 2023 09:45:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BBE4E90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680680796;
	bh=e60gjponf8wDATP0u5aT4qjTpzNg2xFfilxVy6u3Dwo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sIVWytXNMqbwz8k/JEboKOPHYF1BmLCv0QNAuWO1PqD75ot0r+sANI0hrZ5RA7ZQD
	 N86VhdoYWGJBFsdWGViMaBq9mR9HUcJlpJ7u3r4xhm3zb63eFUrb6K98pr89MBK82b
	 lpgC0EsOE1KpJHVQ13JWmn46h0TOq+FYfvV0A/OE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EB951F8024C;
	Wed,  5 Apr 2023 09:45:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A467F8024C; Wed,  5 Apr 2023 09:45:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DAA8DF80054
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2023 09:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAA8DF80054
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1680680718592668533-webhooks-bot@alsa-project.org>
References: <1680680718592668533-webhooks-bot@alsa-project.org>
Subject: http://www.alsa-project.org/alsa-info.sh doesnt exist
Message-Id: <20230405074520.9A467F8024C@alsa1.perex.cz>
Date: Wed,  5 Apr 2023 09:45:20 +0200 (CEST)
Message-ID-Hash: 3CBXTX5PRVIGB4Q6ERVWY2P5MCOAZH67
X-Message-ID-Hash: 3CBXTX5PRVIGB4Q6ERVWY2P5MCOAZH67
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3CBXTX5PRVIGB4Q6ERVWY2P5MCOAZH67/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #199 was edited from petke:

http://www.alsa-project.org/alsa-info.sh doesnt exist. http status code 404

Looks like alsa-info.sh tries to auto update itself, but as that url doesnt exist. It overwrites itself with empty file.


Edir: If i disabled the auto updating by editing script to 

```
REMOTE_VERSION=$SCRIPT_VERSION
```

Then i can run it.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/199
Repository URL: https://github.com/alsa-project/alsa-utils
