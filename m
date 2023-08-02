Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4684FC04A6A
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Aug 2023 15:53:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D7B783A;
	Wed,  2 Aug 2023 17:53:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D7B783A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690991634;
	bh=Lh3fXJXqzrKLmGTtOEbU1xywH6lZiOQQJpCFx/d1gvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FjwU8IxG+BE9Q3mUMPzvP/6p/alF17K/lCR/RMvoSl8M/+ngu/YhQY14abKjJGR9i
	 q513aCicJxwtNNvxNj2B1U0VVXelh64ub98yck7qzhurBcMfsx+rjJO07JNFvxpjsU
	 KQow4sk7hVxUBHGDYbhjy/z9P4LGX7F0DxCKthKE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F069FF80149; Wed,  2 Aug 2023 17:52:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A5EEF8025A;
	Wed,  2 Aug 2023 17:52:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85DB7F8025A; Wed,  2 Aug 2023 17:52:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 415ABF8016D
	for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2023 17:52:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 415ABF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uAOBGOUv
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E7B9B61A18;
	Wed,  2 Aug 2023 15:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2221EC433C7;
	Wed,  2 Aug 2023 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690991548;
	bh=Lh3fXJXqzrKLmGTtOEbU1xywH6lZiOQQJpCFx/d1gvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uAOBGOUvwnounY7GbixgmnvoYyynqBjkp+oXEtxp4bzZFd+gOIgR5UgFqbfYcxNum
	 byfVG5Vgavg15TBoyccVQ+054Tdbg4PgAcFdvGwKQcvZAKPQzrL9XTvGP5BlZf+M/u
	 VyIMMzhY52i8NSyj6mWlsBfxLQEfgpvY+yLIpO1R9yQzWjgR+DQNBGEavethomzsya
	 DDd3gHI0rdmOtjVxaJrd3lLBTmC0gOKDBnZS0lWYUXMyjbD41Zcb33ZKT/LHW7lJrN
	 4cUmJD7mPuaZRsonc5tVjm/LnoALbHc+8w9xa3hR+BPBHwOrfz+IN7bkNV5hLzTLPY
	 ZVhJvrvSwF8bQ==
Date: Wed, 2 Aug 2023 10:52:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/5] PCI: add ArrowLake-S PCI ID for Intel HDAudio
 subsystem.
Message-ID: <20230802155226.GA59821@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802150105.24604-2-pierre-louis.bossart@linux.intel.com>
Message-ID-Hash: WYIACBSKTQ6M4NVIECIKM2O5MCK27BVG
X-Message-ID-Hash: WYIACBSKTQ6M4NVIECIKM2O5MCK27BVG
X-MailFrom: helgaas@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WYIACBSKTQ6M4NVIECIKM2O5MCK27BVG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Aug 02, 2023 at 10:01:01AM -0500, Pierre-Louis Bossart wrote:
> Add part ID to common include file

Please drop period at end of subject and add one at the end of the
commit log.

Also mention the drivers that will use this new #define; looks like
hda_intel.c and ...

Well, actually, I only see that one use, which means we probably
shouldn't add this #define to pci_ids.h, per the comment at the top of
the file.  If there's only one use, use the hex ID in the driver (or
add a #define in the driver itself).

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 3066660cd39b..a6411aa4c331 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3058,6 +3058,7 @@
>  #define PCI_DEVICE_ID_INTEL_HDA_RPL_S	0x7a50
>  #define PCI_DEVICE_ID_INTEL_HDA_ADL_S	0x7ad0
>  #define PCI_DEVICE_ID_INTEL_HDA_MTL	0x7e28
> +#define PCI_DEVICE_ID_INTEL_HDA_ARL_S	0x7f50
>  #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
>  #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
>  #define PCI_DEVICE_ID_INTEL_HDA_POULSBO	0x811b
> -- 
> 2.39.2
> 
