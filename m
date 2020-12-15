Return-Path: <SRS0=TlZm=FT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E5BC4361B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 03:27:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39426223E4
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 03:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39426223E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blennerhassett.gen.nz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2563917AC;
	Tue, 15 Dec 2020 04:26:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2563917AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608002849;
	bh=nISXN7qbXnSxjJGCe3bl2UFATf80YBtLI3ToMf/Ktdk=;
	h=To:From:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HaYCZSd6+wWPPSdxtY62+wPR6yEDu8roWUEcvUj60HLSR1whmxHDIHINMVr+Oj5Q+
	 4omwQ5LG3ff+UY802HoFFdh9blOWqDP1T7aKMhEYa74e0FI2K7EO4eq/bIknO1VeOS
	 BA+RwiabkFddpU1u2jhwe7GuTNGUusz/f6w9zYuM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BEEAFF8028B;
	Tue, 15 Dec 2020 04:25:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B60EFF804AE; Tue, 15 Dec 2020 04:25:49 +0100 (CET)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46233F80259
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2020 04:25:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46233F80259
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <glad-alsa-devel-2@m.gmane-mx.org>)
 id 1kp0y0-0005YA-VV
 for alsa-devel@alsa-project.org; Tue, 15 Dec 2020 04:25:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: alsa-devel@alsa-project.org
From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: [PATCH v2] ASoC: AMD Renoir - add DMI table to avoid the ACP mic
 probe (broken BIOS)
Date: Tue, 15 Dec 2020 16:25:28 +1300
Message-ID: <e1097123-6f22-8921-0415-248958c2a952@blennerhassett.gen.nz>
References: <20201208171200.2737620-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201208171200.2737620-1-perex@perex.cz>
Content-Language: en-GB
Cc: stable@vger.kernel.org
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
Message-ID: <20201215032528.v0_8JlpJuOCTgISwavtDP3vfaZiAU81c9X73_fOd3K4@z>

On 9/12/20 6:12 am, Jaroslav Kysela wrote:
> Users reported that some Lenovo AMD platforms do not have ACP microphone,
> but the BIOS advertises it via ACPI.

Can you briefly explain how to confirm that this specific problem
exists, and what info you would need from me to add a new machine?


I have a Lenovo E14 Gen 2 with AMD that claims to have DMIC but no
evidence of it working.

My workaround so far has been blacklisting the related modules...
blacklist snd-soc-dmic
blacklist snd-acp3x-rn
blacklist snd-acp3x-pdm-dma

alsa-info:
http://alsa-project.org/db/?f=0c4d6f062e6065d47ee944f5953f0aaa328d4b44

--
Eliot


