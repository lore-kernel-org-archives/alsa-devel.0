Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80CBC3A5A7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:31:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2455722DBF
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="moa1cQxr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBDyIX2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2455722DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E79C16B8;
	Wed,  4 Sep 2019 11:30:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E79C16B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567589485;
	bh=fYaqDv+hxjnoXl8aGnWikvK/YT2KvzYjJNkD5DqScZI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=moa1cQxrr5DwCj29IEwJHMr3OZ6TAIbMWIO8wkwgU/o+V/aZZWKnmiVAV1M4FKr3r
	 E/PPv5sjGAjMAo4MiDOtb1C8fFhzlCJGctGJczsL3a2SIUfoXk9Q6mYnyEuOAdOzKB
	 5Vhpl16+DmIf7ikO3Fwo0CijXOAPjMYOx2kfzqZ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7FCEF803D6;
	Wed,  4 Sep 2019 11:30:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 802AAF803D7; Wed,  4 Sep 2019 11:30:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E3E2F8011E
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 11:30:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E3E2F8011E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OBDyIX2w"
Received: from localhost (unknown [122.182.201.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 79B0A21670;
 Wed,  4 Sep 2019 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567589427;
 bh=5A9Vcn8Wbx2ac8gtPDwlVez5G3AlEtznhc3EeNKZ6O8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OBDyIX2wKFW6B58iWnY1iy0cRV6uBL01HgiPIHX0t6i8G3XRVAAb30f1bh49zpAcB
 wEaxqXnAwVTxGemhdTiP7xFxc02yySQRGiKDK2Kszh7AhQrimP/xcT5M/EVj5yIEo3
 MPYVir2eVWMSrBN66PAli4U3LfSMv5shj73SFFQI=
Date: Wed, 4 Sep 2019 14:59:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20190904092919.GP2672@vkoul-mobl>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190813083550.5877-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org,
 pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 2/5] soundwire: stream: make stream name
 a const pointer
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

On 13-08-19, 09:35, Srinivas Kandagatla wrote:
> Make stream name const pointer

Good catch,  Applied, thanks

-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
