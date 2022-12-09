Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A0FC4332F
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Dec 2022 16:36:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF2F61730;
	Fri,  9 Dec 2022 17:35:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF2F61730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670603777;
	bh=YnwTC7QjlohGu1tGo3UNpnLTrNgnd5ZUZJZQWy+aIog=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZO8qXnYBoKCw3MnySLBEoFVCuAbXazpeYW8FlvWbaIENkjwN8xHoHvhb8TY2V7o+V
	 vqiCbIQVrNGqpb+SwtYxU9qcCORtPe6AzwVDhLM/5NgxUj1euS9plzpf5rJus2ywFw
	 VbUZeV1Bm1nFesbZPjrEoxqJd+MLo4w8U6zrO2c4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD2D4F8022B;
	Fri,  9 Dec 2022 17:35:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9173DF8022D; Fri,  9 Dec 2022 17:35:25 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1D9A5F80115
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2022 17:35:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D9A5F80115
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1670603723617804050-webhooks-bot@alsa-project.org>
References: <1670603723617804050-webhooks-bot@alsa-project.org>
Subject: alsa-project.org is down
Message-Id: <20221209163525.9173DF8022D@alsa1.perex.cz>
Date: Fri,  9 Dec 2022 17:35:25 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #287 was opened from afq984:

```
curl -i https://alsa-project.org
HTTP/2 404 
server: nginx/1.14.1
date: Fri, 09 Dec 2022 16:34:22 GMT
content-type: text/html; charset=UTF-8
x-powered-by: PHP/7.4.30

No input file specified.
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/287
Repository URL: https://github.com/alsa-project/alsa-lib
