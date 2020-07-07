Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D40C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:17:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0892075B
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YdS/KYO9";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="a/lZnrJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0892075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F39B74C;
	Tue,  7 Jul 2020 15:16:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F39B74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594127820;
	bh=2X7kKqbmY4ozlqZFeiLexQhx4NaaujJ9318pm4SvO7w=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YdS/KYO9g1YAaX07TtTsfRts0sXlV0gU0SYsXZ5OE+06HnbMa3sKiNpIwZFE70na/
	 A9tHp+++Fe8C13fLEkqY8x+LRMu9SbfDSJn6keUEZqd13ufYzhicku3g16FFDDv4Se
	 VJKCQM+tpZb4wjyL+3TvdWwwIVSp/XuzbrOzHeAw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94397F8011F;
	Tue,  7 Jul 2020 15:16:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD193F80216; Tue,  7 Jul 2020 15:16:08 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A086F8011F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 15:15:57 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id DFD46A003F;
 Tue,  7 Jul 2020 15:15:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz DFD46A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1594127756; bh=jvXX+Z+H3ma2whjwT6/muyEXMqhH9keZl59m0q7Mi9w=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=a/lZnrJQMPqhv9blHX9z2/o9W12q/t/CunFIuJlJ+X9p2wwi2pbS397Ws1fAj+LYj
 1BCWi7rUW8dNYblODI01bLyNWeouQDPRK5hE6euBZZ8W1NE9GZ3HM4HFjPMg52Dm0p
 X+9ybg6IwBtZ8SgWmR2ULUPDS6BqqCnBwvwtxAds=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  7 Jul 2020 15:15:53 +0200 (CEST)
Subject: Re: [RFT] ALSA control service programs for Digidesign Digi 002/003
 family and Tascam FireWire series
To: alsa-devel@alsa-project.org, sbahling@suse.com,
 ffado-devel@lists.sourceforge.net
References: <20200707125651.GA200100@workstation>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <a322006e-bd58-4dba-f590-855be17a2cdb@perex.cz>
Date: Tue, 7 Jul 2020 15:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707125651.GA200100@workstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 07. 07. 20 v 14:56 Takashi Sakamoto napsal(a):


> They have command line options. For all models of Digi 002/003 family, the
> executable has an option for the numerical ID of sound card.
> 
> ```
> Usage:
>    snd-firewire-digi00x-ctl-service CARD_ID
> 
>    where:
>      CARD_ID: The numerical ID of sound card.
> ```

It's better to handle both card number and the card id string. In the latter 
case, the user may create independent environment and use udev or 
modprobe.conf configurations to address the devices. The card number may 
change when the plug-and-play devices are randomly connected / disconnected.

snd_card_new() - third argument.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
