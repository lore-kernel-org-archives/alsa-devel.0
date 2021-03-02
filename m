Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B187CC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 14:13:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CA764F0D
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 14:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CA764F0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E0321716;
	Tue,  2 Mar 2021 15:12:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E0321716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614694421;
	bh=0yIHsrP7Pf1lWzEWCNqE5bm01WkkoH6g1zGHv0P04Mw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PG8qADqu/olMcya2j7Sw389oG3KDGACqKwKe1tRTdOQYkfDoZ0euAvkw1joMbZO0/
	 7v7nwwzq9NkYjBLadZaUKOqNSHdFr64a7WgFPtLmW+7qnT63JVFxHXoBY8cRzZn/jM
	 WkAFlz97K6391ImXuU59+qfzvix1PDRNapd2qNDM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11A1DF80088;
	Tue,  2 Mar 2021 15:12:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7AD56F80269; Tue,  2 Mar 2021 15:12:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76E48F8012D
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 15:12:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76E48F8012D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="f80mvGHt"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8304264F04;
 Tue,  2 Mar 2021 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614694361;
 bh=0yIHsrP7Pf1lWzEWCNqE5bm01WkkoH6g1zGHv0P04Mw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f80mvGHtxHaS0EIn3WabeaCLJpvzq8asVA+tnG0kZv5wJ++AkIH1AQ5DjlIkcZEMH
 GmqLau6Uo0ens3duXmATpIdc2KMqUO/PWtWth4LtHEXXHP57ColTEwiAAHaTmnSaDx
 E73CHHGrg0maHW4dTPW534y3DeB3m9Q9zPQ2TTm47CHItPn91+VerZ7Lgb0ObKjKOO
 +sohav7dxOkc3yqNxCzzJVByBT1F+ZTR2WcyhOPvBc3MbneS863t2amxXlhCeS/swA
 mRVumqP+1kK3v6yZW5T+O4mRZ2hOmW4gyW8PYB97RrhSGhR1g/jr5sZzdGnvn6Iadh
 c2tyF4jzIpWPw==
Date: Tue, 2 Mar 2021 19:42:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 6/7] ALSA: hda: move Intel SoundWire ACPI scan to
 dedicated module
Message-ID: <YD5H1XdfKl10kcpe@vkoul-mobl>
References: <20210302003125.1178419-1-pierre-louis.bossart@linux.intel.com>
 <20210302003125.1178419-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302003125.1178419-7-pierre-louis.bossart@linux.intel.com>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, arnd@arndb.de,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de, broonie@kernel.org,
 Bard Liao <bard.liao@intel.com>
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

On 01-03-21, 18:31, Pierre-Louis Bossart wrote:
> The ACPI scan capabilities is called from the intel-dspconfig as well
> as the SOF/HDaudio drivers. This creates dependencies and randconfig issues
> when HDaudio and SOF/SoundWire are not all configured as modules.
> 
> To simplify Kconfig dependencies between HDAudio, SoundWire, SOF and
> intel-dspconfig, move the ACPI scan helpers to a dedicated
> module. This follows the same idea as NHLT helpers which are already
> handled as a dedicated module.
> 
> The only functional change is that the kernel parameter to filter
> links is now handled by a different module, but that was only provided
> for developers needing work-arounds for early BIOS releases.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Bard Liao <bard.liao@intel.com>
> ---
>  drivers/soundwire/intel.h           |   2 -
>  drivers/soundwire/intel_init.c      | 158 -------------------------

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
