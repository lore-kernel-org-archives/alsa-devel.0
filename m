Return-Path: <SRS0=6kKU=DL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB37C4363C
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2020 21:18:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FB12078A
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2020 21:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BPQIs4Dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FB12078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dressmaker.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70D5317FF;
	Sun,  4 Oct 2020 23:17:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70D5317FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601846297;
	bh=hNFifxXGS5p+xJxOsW8EqG9noknCLsvzj1Yb/fLLM+0=;
	h=Subject:From:To:References:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BPQIs4Dqf5yPILyckOViz3WTA+D8QiuhW11QXLg2mP9rp08fXHB3p89nIN0jsfd8K
	 TXHr4MI+2aQghoK+vshbxmswL7Xgwe2Va0JvXC+wRfIW0E7FGrEvtHwNCqpWSAzREV
	 zctm7D1RyLwl86hE8AHQhJBkHPm89XvlWZdmChzE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDE7DF80218;
	Sun,  4 Oct 2020 23:17:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A8CDF80246; Sun,  4 Oct 2020 23:17:24 +0200 (CEST)
Received: from mail.earthlovesme.ca (24-65.162.static.aei.ca [216.162.65.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC239F800C9
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2020 23:17:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC239F800C9
Received: from localhost.localdomain (Unknown [10.10.10.3])
 by mail.earthlovesme.ca with ESMTPSA
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128)
 ; Sun, 4 Oct 2020 17:17:14 -0400
Subject: Dead link in wiki under Tutorials
From: info <info@dressmaker.ca>
To: alsa-devel@alsa-project.org
References: <de6ebf17-8f71-c497-28bc-7819338baddb@dressmaker.ca>
Organization: Dressmaker Canada Inc.
Message-ID: <09f11cd1-473b-726e-84c9-3de8b9cf9fe3@dressmaker.ca>
Date: Sun, 4 Oct 2020 17:17:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <de6ebf17-8f71-c497-28bc-7819338baddb@dressmaker.ca>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On the page 
https://www.alsa-project.org/wiki/Tutorials_and_Presentations there are 
dead links.

ALSA 0.9.0 HOWTO <http://www.suse.de/%7Emana/alsa090_howto.html> - Dr 
Matthias Nagorni has writen a comprehensive tutorial for audio 
application developers.
is dead. The article has been removed.

Howto use the ALSA API <http://equalarea.com/paul/alsa-audio.html> - 
Paul Davis has also written a brief explanation.
is dead. His site has been removed from the hosting site.

ALSA Sequencer (draft) 
<http://www.alsa-project.org/%7Efrank/alsa-sequencer/> - Frank van de 
Pol's draft on programming the alsa sequencer.
is dead, 404 error.

Kernel OSS-Emulation 
<http://www.alsa-project.org/%7Eiwai/OSS-Emulation.html> - Takashi Iwai 
has written some notes on how ALSA handles OSS applications.
is dead, 404 error.

It is worth trying to restore them because there are very few resources 
on ALSA programming.

Regards
Alex

