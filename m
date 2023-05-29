Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C85C77B7A
	for <alsa-devel@archiver.kernel.org>; Mon, 29 May 2023 05:27:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D6D43E;
	Mon, 29 May 2023 07:26:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D6D43E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685338034;
	bh=sh4pubmyXVQLpGpgSZtDf5EnBuwgelN/Cctaod7zKn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IBQRoy743KoySjrJh/qRqVAobW8X5GtDSO5zc3d8iruUD+KqIvuWgJrvzcAX8IVf4
	 1HNmbzZEZFtUk3j5W3g6GnxnbWnu/r/pwpE9ValdQ7USd814NhOc/U/d2CHTnlJVeX
	 6rRvxB+cmdSL6gX18IpGPD8JoUFSolHrqlTnLTZs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7921DF80542; Mon, 29 May 2023 07:25:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D4ECF80549;
	Mon, 29 May 2023 07:25:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15709F8042F; Mon, 29 May 2023 07:17:52 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6734BF80086
	for <alsa-devel@alsa-project.org>; Mon, 29 May 2023 07:17:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6734BF80086
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=eDX6G8p5
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9E2D462192;
	Mon, 29 May 2023 05:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7509FC433EF;
	Mon, 29 May 2023 05:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685337467;
	bh=sh4pubmyXVQLpGpgSZtDf5EnBuwgelN/Cctaod7zKn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDX6G8p5IMAxh9JNKJUTvjXXlZdDtt9rXD8EDRgXuys/cs4Ps6eSzdiqeWbzIDw8h
	 J2wwDJiZmHoMohiLRGsX9OuSSDLgQYZbLjs1rTWlRb8InhXoKoA7aFyrniVCssJ3IN
	 2d10V1UIL4FH+9iza8dG6brjwUR2uSeG6zJVYV04/0oZkj4p80tCl8VbqeVSPDWSrU
	 fvncktEUxQe22ek/0bS13uaxLs920Z8S5IQSdmPRGSPaNm4YqvLdDM4umg4B6Zvr6/
	 O/31nfQ4ii0wUx8WkmyeLrUa95vUn6osd+PacSLXXBSl8B0rqDjaWvQHXUZTWFar/W
	 KVGR0aSpB9Xmg==
Date: Mon, 29 May 2023 10:47:42 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/3] soundwire: improve bus reset
Message-ID: <ZHQ1dmvFgifSU6X5@matsya>
References: <20230518024119.164160-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518024119.164160-1-yung-chuan.liao@linux.intel.com>
Message-ID-Hash: IKMNLNG7CDETUROBPPHG47XSFXLQVN3L
X-Message-ID-Hash: IKMNLNG7CDETUROBPPHG47XSFXLQVN3L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IKMNLNG7CDETUROBPPHG47XSFXLQVN3L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 18-05-23, 10:41, Bard Liao wrote:
> Improve bus reset sequence by updating programing sequence.

Applied, thanks

-- 
~Vinod
