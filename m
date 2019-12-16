Return-Path: <SRS0=bmHO=2G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C6C2D0C3
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:54:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C06206EC
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FYtRFBdu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="InUpgdik";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="InUpgdik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C06206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9121E84F;
	Mon, 16 Dec 2019 17:53:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9121E84F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576515285;
	bh=enebr5DJcXPUkP0eA8FXLQzwtu5vUzO8yFiYchkOgOQ=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FYtRFBdu3nURzmf0WBgFIxw5RXMjvoW+Qa7ORjdBljUcOjYeOSR2IpqpJ3EnPKfnP
	 cdpQ9+ubK/m3zHfMYLLUol/nsegjYwiBqVJxoS7fEs48heO7zhJXZ6TjzfNQyQssLZ
	 jYnHOvwTsb9/MEBsIk8nbRnyOPJLOZTHUXa3C9pA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0497AF8022C;
	Mon, 16 Dec 2019 17:53:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67FD3F80255; Mon, 16 Dec 2019 17:53:53 +0100 (CET)
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95520F800B2
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2019 17:53:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95520F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="InUpgdik"; 
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="InUpgdik"
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id DE9014E2006;
 Mon, 16 Dec 2019 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1576515227; bh=PDG4xILM0ggz//+/yPEhO7+YPyNm+jyBiOoMiKrGSH8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=InUpgdik2rw3RH9CAtDXLPzGZbi+Mj1zDS30acc3jowFAyTe3WnxZqWlBIz3jqTKP
 AQX4vJEMDoswjIXvOI5uwt+LRYip/IvOHB+5wb1gzX2ObciSlG/vu7EdXXQPwmOlv0
 A+8EBtIqugoP69y/EA4r5qWpBrUVXMydcOU6Mjuo=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5XS3_Gd8CFnQ; Mon, 16 Dec 2019 16:53:47 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
 by node.akkea.ca (Postfix) with ESMTPSA id 725604E2003;
 Mon, 16 Dec 2019 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1576515227; bh=PDG4xILM0ggz//+/yPEhO7+YPyNm+jyBiOoMiKrGSH8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=InUpgdik2rw3RH9CAtDXLPzGZbi+Mj1zDS30acc3jowFAyTe3WnxZqWlBIz3jqTKP
 AQX4vJEMDoswjIXvOI5uwt+LRYip/IvOHB+5wb1gzX2ObciSlG/vu7EdXXQPwmOlv0
 A+8EBtIqugoP69y/EA4r5qWpBrUVXMydcOU6Mjuo=
MIME-Version: 1.0
Date: Mon, 16 Dec 2019 08:53:47 -0800
From: Angus Ainslie <angus@akkea.ca>
To: Mark Brown <broonie@kernel.org>
In-Reply-To: <20191216122258.GC4161@sirena.org.uk>
References: <20191214235550.31257-1-angus@akkea.ca>
 <20191216122258.GC4161@sirena.org.uk>
Message-ID: <3b7f47120df1d63747788bf9de16392c@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, kernel@puri.sm,
 linux-kernel-owner@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 0/2] Add the broadmobi BM818
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2019-12-16 04:22, Mark Brown wrote:
> On Sat, Dec 14, 2019 at 03:55:48PM -0800, Angus Ainslie (Purism) wrote:
> 
>> Angus Ainslie (Purism) (2):
>>   sound: codecs: gtm601: add Broadmobi bm818 sound profile
>>   dt-bindings: sound: gtm601: add the broadmobi interface
> 
> As I said in reply to v1:
> 
> | These subject styles don't even agree with each other :( - please
> | try to be consistent with the style for the subsystem (the latter
> | one matches, the first one doesn't).

Sorry I missed fixing that. I will re-submit.

Do you have any comments on the code changes I made in v2 ?

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
