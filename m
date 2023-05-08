Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8026C77B7F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 May 2023 07:35:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9373812AB;
	Mon,  8 May 2023 09:34:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9373812AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683531298;
	bh=Ewso4HhzAJsqbCT6d20i437Q1SAxJH/VSuHeEApsxno=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uYniCjzC2xxlx020z4/B16Qjfa9wScjagYKc50dq0hN+P4wcWN5DyZOLVjN6Nm/Nk
	 2MhOQ1hu8uAF9xRrwCNAgrUixuxTPlDcLTLGv68Iz34ettM383R0jUSJ7lYiX4d+8z
	 ZObKn7KBMAdRv5VyuJGqqKBewYX+CYD4+55Ucye8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A02FF8032D;
	Mon,  8 May 2023 09:33:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23D60F8032D; Mon,  8 May 2023 09:33:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21540F8014C
	for <alsa-devel@alsa-project.org>; Mon,  8 May 2023 09:33:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21540F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ksQ/haKd
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 08AD861038;
	Mon,  8 May 2023 07:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93C0C433D2;
	Mon,  8 May 2023 07:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683531213;
	bh=Ewso4HhzAJsqbCT6d20i437Q1SAxJH/VSuHeEApsxno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksQ/haKdEaXlVJf5aV4SAe7/h6YRzUWHQCOmPabBVhnPsYgPWDktr8vLtVV48Egem
	 4N/QFzD9aUhobzl9LNc/vuuaRS62YMRs5epnu3teAICr7Up3NVXpKZxx2L27potgiZ
	 Wg3tYcGgfte+jBAzGZwsHkxInQUbJUZjngdOn5h14yVWOg9TKsX+cI8YvopmOlakH0
	 CmqtfQ+xEMvl2CsAQeXz4C45wXoAuO/ejo1jo3DhfToz5M0PPsTxn2zA1Mchuqb91q
	 OeamyywMW7+YLJopIGyCSfqBnp/ZzP0JDMUYNpJpJzGGHr4Cu3tjqjbcxeCOGZMZNB
	 s60WuEqbbPFaA==
Date: Mon, 8 May 2023 13:03:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] soundwire: bus: Don't filter slave alerts
Message-ID: <ZFilyckgWJlHiBiU@matsya>
References: <20230418140650.297279-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418140650.297279-1-ckeepax@opensource.cirrus.com>
Message-ID-Hash: GUF4S724AMA4FPXVHGFKW3IGVCW47WL2
X-Message-ID-Hash: GUF4S724AMA4FPXVHGFKW3IGVCW47WL2
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GUF4S724AMA4FPXVHGFKW3IGVCW47WL2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 18-04-23, 15:06, Charles Keepax wrote:
> It makes sense to have only a single point responsible for ensuring
> that all currently pending IRQs are handled. The current code in
> sdw_handle_slave_alerts confusingly splits this process in two.  This
> code will loop until the asserted IRQs are cleared but it will only
> handle IRQs that were already asserted when it was called. This
> means the caller must also loop (either manually, or through its IRQ
> mechanism) until the IRQs are all handled. It makes sense to either do
> all the looping in sdw_handle_slave_alerts or do no looping there and
> let the host controller repeatedly call it until things are handled.
> 
> There are realistically two sensible host controllers, those that
> will generate an IRQ when the alert status changes and those
> that will generate an IRQ continuously whilst the alert status
> is high. The current code will work fine for the second of those
> systems but not the first with out additional looping in the host
> controller.  Removing the code that filters out new IRQs whilst
> the handler is running enables both types of host controller to be
> supported and simplifies the code. The code will still only loop up to
> SDW_READ_INTR_CLEAR_RETRY times, so it shouldn't be possible for it to
> get completely stuck handling IRQs forever, and if you are generating
> IRQs faster than you can handle them you likely have bigger problems
> anyway.
> 
> This fixes an issue on the Cadence SoundWire IP, which only generates
> IRQs on an alert status change, where an alert which arrives whilst
> another alert is being handled will never be handled and will block
> all future alerts from being handled.

Applied, thanks

-- 
~Vinod
