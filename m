Return-Path: <SRS0=cpJH=YO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027B2CA9EAF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:13:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D2220B7C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mjWlcDZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D2220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8AFA839;
	Mon, 21 Oct 2019 15:12:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8AFA839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571663629;
	bh=0C8HlX4gI7yRNRjxoUj7yi6EmrnT9g5FF+0Yq4oUrY0=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mjWlcDZITb5/khyKOrF3/ErDxsQFe8sBTVz/f0HNd0hcEsQ1AaH2A8om3kzbs4Lz/
	 CTIy294ckftI5JI5SWRLkvVyWNlCN9citoUtJ722d+mf4veo2X0pAa9HWJw5pdRnrt
	 ftxnNqXymkyFu7ghRNrn8uMoh/ekOWgkUOFV3aOQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 382BBF80321;
	Mon, 21 Oct 2019 15:12:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40FBDF80368; Mon, 21 Oct 2019 15:12:57 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 148CEF800C0
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 15:12:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 148CEF800C0
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id 65F8728A8BD
To: Mark Brown <broonie@kernel.org>
References: <20191019070254.23870-1-tzungbi@google.com>
 <20191019143504.1.I5388b69a7a9c551078fed216a77440cee6dedf49@changeid>
 <659a3d1f-a8e1-268d-5e95-b328aeed601b@collabora.com>
 <20191021114303.GC4691@sirena.co.uk>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a4e1530a-b706-2a73-e0b3-ad56cf9085bc@collabora.com>
Date: Mon, 21 Oct 2019 15:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021114303.GC4691@sirena.co.uk>
Content-Language: en-GB
Cc: gwendal@google.com, drinkcat@google.com, alsa-devel@alsa-project.org,
 cychiang@google.com, devicetree@vger.kernel.org,
 Tzung-Bi Shih <tzungbi@google.com>, robh+dt@kernel.org, bleung@google.com,
 dgreid@google.com
Subject: Re: [alsa-devel] [PATCH v5 1/4] ASoC: cros_ec_codec: support WoV
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

On 21/10/19 13:43, Mark Brown wrote:
> On Mon, Oct 21, 2019 at 01:26:04PM +0200, Enric Balletbo i Serra wrote:
> 
>> Mark, once applied, could we get an immutable branch from you containing the
>> following already applied patches + this series? We need as we have patches that
>> could conflict on platform/chrome.
> 
> Ugh.  You should have mentioned this before the patches were applied,
> they're on the development branch that has everything in it like I
> normally do which I don't want to rebase (and I think I did a merge up
> of the fixes branch since then anyway).  Hopefully Linus will be able to
> figure out any conflicts that occur.
> 

Ok, I was off the latest two weeks so I didn't catch it :-(. I'll try to figure
out the better way to avoid conflicts knowing that these are already queued.

Thanks,
 Enric.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
