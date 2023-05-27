Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FD4C77B7E
	for <alsa-devel@archiver.kernel.org>; Sat, 27 May 2023 10:41:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05668200;
	Sat, 27 May 2023 12:41:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05668200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685184113;
	bh=JNsRIsRjL/8M1yvZ7uGK5oXUYuFpKrOFRM3AqzsXLYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i40jSIEXh4tyj+h7Za46lv2Y521SmQfYJQp+6hyvuNMkycbPUg2sU15IzDtDa4FXK
	 BLW8w1bOt0nj+gsQjS7RuB7TskPfJt0HhIzBwIF1TDvEWCmtuatLXln7bInB6PxNYn
	 zii7dwsy1DIITgFQqFbeqYbXnsiz37hRXjY+xEsU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A6E1F80553; Sat, 27 May 2023 12:40:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2978BF8026A;
	Sat, 27 May 2023 12:40:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DE95F80249; Sat, 27 May 2023 12:38:13 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 306C2F80053
	for <alsa-devel@alsa-project.org>; Sat, 27 May 2023 12:38:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 306C2F80053
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=W5miuFCM
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F324560C6D;
	Sat, 27 May 2023 10:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EE6C433D2;
	Sat, 27 May 2023 10:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685183888;
	bh=JNsRIsRjL/8M1yvZ7uGK5oXUYuFpKrOFRM3AqzsXLYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5miuFCM+/3je+DB5zjAJcaNeWueZc60AAV1IKmvNtbTbjaYJmGl0irXHeF9CV40L
	 UBDPdzjzJTenGyR2CEgdLZXIu/f9JV2oxtdstDpaLZc2h4F9Ij0aq/IZtUqCrniCJK
	 7pbkIEhwG8ZBS4BNjloK6qwvoSoBwcn/QVAxt8bvqGOVwNqkJl9gY3NmxN8jaz9ACn
	 Z9pt66qg+nxdseTn7YIQPcA3MKlOony+SbVU1u/cHHWsT/1UpMDzKEkXoYLzTdG747
	 qZWEWD75V2lYnloxdAfMz3Dxb5kf0ixNHlLsCm+KQkNC8qiWhIIQiYKrFaqvwnHjFY
	 DRSULoWRSWjnA==
Date: Sat, 27 May 2023 16:08:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: dmi-quirks: add new mapping for HP Spectre
 x360
Message-ID: <ZHHdjJ+XyZzVYzX2@matsya>
References: <20230515074859.3097-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515074859.3097-1-yung-chuan.liao@linux.intel.com>
Message-ID-Hash: YWMLVBKQPYXNBLSR2AWJILFRPHYZ3HUN
X-Message-ID-Hash: YWMLVBKQPYXNBLSR2AWJILFRPHYZ3HUN
X-MailFrom: vkoul@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YWMLVBKQPYXNBLSR2AWJILFRPHYZ3HUN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 15-05-23, 15:48, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> A BIOS/DMI update seems to have broken some devices, let's add a new
> mapping.

Applied, thanks

-- 
~Vinod
