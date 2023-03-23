Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A705C76195
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Mar 2023 13:27:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75339EC7;
	Thu, 23 Mar 2023 14:26:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75339EC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679578039;
	bh=OHCiYuOYp1B5CAMnjvillQU99BRFjPMLNzT/SUEw6LY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bX7N2JgvY45LVVjpYrd8rcieKObAfmyQ8uFNcDOkC4dRg+AJKEc+LK4/QEDBfpO/m
	 iCrYHmdK/PG8VVffi4Qw9M4CnoMR673BEyQEE04zjMe/1tToWj3qpORJiodEXAj1E/
	 43xyj8vd3E4lGUqxOhBUFyaWk3jd4M6RV8IhnID8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B1320F8027B;
	Thu, 23 Mar 2023 14:26:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6CA7AF8027B; Thu, 23 Mar 2023 14:26:03 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id A2D86F80093
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2023 14:25:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2D86F80093
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1679577958170970201-webhooks-bot@alsa-project.org>
References: <1679577958170970201-webhooks-bot@alsa-project.org>
Subject: ALC4082 - Asus Crosshair x670E Hero
Message-Id: <20230323132603.6CA7AF8027B@alsa1.perex.cz>
Date: Thu, 23 Mar 2023 14:26:03 +0100 (CET)
Message-ID-Hash: NLH3Z2AZ3JG6M2DRCSAQ3YVGLGJ7ZX7D
X-Message-ID-Hash: NLH3Z2AZ3JG6M2DRCSAQ3YVGLGJ7ZX7D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NLH3Z2AZ3JG6M2DRCSAQ3YVGLGJ7ZX7D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #295 was edited from nitin88:

Hi,

I am using frontend Mic and Output of x670E Hero board.

Issues:
1. The mic volume is too low that I have to literally shout to record something.
2. Attached screenshot of Alsamixer (set everything to high)
![image](https://user-images.githubusercontent.com/4945664/227216525-095810ad-273c-4941-b881-b3b2467cdd86.png)
3. Copied latest master configurations

Was closely following this thread https://github.com/alsa-project/alsa-ucm-conf/issues/229 as this board uses same ALC4082 but from Asrock
I can help you debug/test every possible configuration with this board, any help to fix "sound recording" is appreciated.

Attaching the `alsaucm -c hw:Audio dump text` [dump.txt](https://github.com/alsa-project/alsa-ucm-conf/files/11051278/dump.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/295
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
