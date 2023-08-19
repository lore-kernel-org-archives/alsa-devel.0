Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185C0EE49AA
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Aug 2023 08:06:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AB5C827;
	Sat, 19 Aug 2023 10:05:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AB5C827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692432393;
	bh=cSE4Wisr9qGEguljwlpNzVHYKsAKxk2jZ+tD8VNq+/Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=m/mdNAT09P83eiKscYngGTDh63DcuMN74A1VVM08fl/h26aImtZN1wlfkiPbO5EmM
	 wt7zrYLEK51sooiN+efnHF8oFyJsv3XB9kfKNyBsvOcoBCl+I2yHpfrVdOreVTkJ3p
	 hJZQMFQ7wBYnjIksFR55+ClfdH9trnHVOyGpNKRc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31114F80553; Sat, 19 Aug 2023 10:05:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F104F80549;
	Sat, 19 Aug 2023 10:05:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C6C0F80579; Sat, 19 Aug 2023 10:03:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 687E8F80567
	for <alsa-devel@alsa-project.org>; Sat, 19 Aug 2023 10:03:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 687E8F80567
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1692432217406877995-webhooks-bot@alsa-project.org>
References: <1692432217406877995-webhooks-bot@alsa-project.org>
Subject: ucm2 profile for Universal Audio Volt 2
Message-Id: <20230819080339.0C6C0F80579@alsa1.perex.cz>
Date: Sat, 19 Aug 2023 10:03:39 +0200 (CEST)
Message-ID-Hash: 5H5QU5SFPQZJM5J24GWZ6DDPN2SL4H4X
X-Message-ID-Hash: 5H5QU5SFPQZJM5J24GWZ6DDPN2SL4H4X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5H5QU5SFPQZJM5J24GWZ6DDPN2SL4H4X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #340 was edited from z411:

This adds a profile for the (relatively recent) Universal Audio Volt 2 USB audio interface. It has a Stereo output and 2 mono inputs that are (like most budget interfaces) combined into a stereo input. This profile effectively splits these inputs into two Line inputs. These inputs can be used interchangeably for XLR microphones, Line level signals or Hi-Z instruments.

The only weird thing is that in my machine the Mono Input 2 appears first in order but pretty sure I defined the prorities in the configuration file just fine. Everything works well on my machine.

[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/12385352/alsa-info.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/340
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/340.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
