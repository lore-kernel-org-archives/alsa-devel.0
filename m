Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DD9ECAAD8
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Sep 2022 05:08:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A6CB1F2;
	Tue, 20 Sep 2022 07:07:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A6CB1F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663650514;
	bh=WNlXwAPY8FBdZQqXGzfXldNGu3sjnE8sRYLAPAEeiXQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IN/Yo5WPGJG5nV+Xzbsot6aZAIR2kx61J5ezvUfgVf7lfA/2Jg/nbkI89/fLVO+e4
	 LKhwkC/KHilcA4I5bCVZPILqvip2YCwyc4PaBHD9XmRK5yjVIj0fWcAFdKBQjuUfNL
	 09RdyPjcJyg5ZD8uVdxdIOI4Yl3SafvQhen9sjNE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4980F800F2;
	Tue, 20 Sep 2022 07:07:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D605EF800C9; Tue, 20 Sep 2022 07:07:41 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CB20F800C9
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 07:07:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CB20F800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UfFEJq8a"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 86C6361718;
 Tue, 20 Sep 2022 05:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627D5C433D7;
 Tue, 20 Sep 2022 05:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663650445;
 bh=WNlXwAPY8FBdZQqXGzfXldNGu3sjnE8sRYLAPAEeiXQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UfFEJq8aE0p6AR22uKE8vqWus7qQ6F8NWKWjRp5ETGa2o9pCPR06KNAv1OfIBjiPA
 LhipuBoY25BD5aOBhAsXbUvFZk61gR0RUX47keNytFRhhJ0Nc6BZoIdqk/7tDVG+jo
 1ARqsFBYxsjYiEYkzbpXXN6PQubj7g2rkMbMLjSbN+IVUGgS1QnYHw7JAefAT53JuO
 NlTe4Vb8DcPwYaKQUXUA8DT2sJ3waFfzGhgHQNEP0mHoWOjvoPcMjuw7vtW45H6uAe
 T0DnYjFhy1HJIMxIgnHEI89jWe0EDsn5VAZeFa0yJVMs3YCOSPGQRjTFDRylRaPioh
 kS+03BhNXhh2w==
Date: Tue, 20 Sep 2022 10:37:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] soundwire: cadence: Fix error check in cdns_xfer_msg()
Message-ID: <YylKiGoIt4tkJWxQ@matsya>
References: <20220917154822.690472-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917154822.690472-1-rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

On 17-09-22, 16:48, Richard Fitzgerald wrote:
> _cdns_xfer_msg() returns an sdw_command_response value, not a
> negative error code.

Applied, thanks

-- 
~Vinod
