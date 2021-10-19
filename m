Return-Path: <SRS0=CVmM=PH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36FCC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Oct 2021 09:24:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7220A6113D
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Oct 2021 09:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7220A6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21B5A16A5;
	Tue, 19 Oct 2021 11:23:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21B5A16A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634635483;
	bh=/xBheIoca7mUgFKdnp8f0RdvBZk8/iZpssqPW4Qq7EU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fbQbBt5eVh/3w0McnHf+DPzXj58FJbc7pNFyb9vYAUOwkfTpfkA/s64hvYq69LDFY
	 bWAqrYiYZfhwpBs7bqyWGSpIrJ2Rqu1C3uPs5WX/+R7BTI/i68TjROLqfRE3p0lqXY
	 jEWzdUGOt7CnT1fix1XhUknKT1GTbdSix8SZzjbM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0C08F80082;
	Tue, 19 Oct 2021 11:23:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58E5EF80256; Tue, 19 Oct 2021 11:23:51 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C1B7F80155
 for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2021 11:23:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C1B7F80155
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="208568227"
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; d="scan'208";a="208568227"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2021 02:23:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; d="scan'208";a="443808685"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2021 02:23:40 -0700
Date: Tue, 19 Oct 2021 12:16:40 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Unify HDAudio-ext bus initialization
In-Reply-To: <20211018192134.353931-1-cezary.rojewski@intel.com>
Message-ID: <alpine.DEB.2.22.394.2110191203390.3554566@eliteleevi.tm.intel.com>
References: <20211018192134.353931-1-cezary.rojewski@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: hdegoede@redhat.com, alsa-devel@alsa-project.org, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com
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

Hey,

On Mon, 18 Oct 2021, Cezary Rojewski wrote:

> HDAudio-extended bus initialization parts are scattered throughout Intel
> ADSP drivers code. Gather them up in snd_hda_ext_bus_init() to provide
> unified initialization point.
[...]
> --- a/sound/hda/ext/hdac_ext_bus.c
> +++ b/sound/hda/ext/hdac_ext_bus.c
[..]
> -int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
> -			const struct hdac_bus_ops *ops,
> -			const struct hdac_ext_bus_ops *ext_ops)
> +int snd_hda_ext_bus_init(struct hda_bus *bus, struct pci_dev *pdev,
> +			 const struct hdac_bus_ops *ops,
> +			 const struct hdac_ext_bus_ops *ext_ops,
> +			 const char *model)
[...]
> -	bus->idx = 0;
> -	bus->cmd_dma_state = true;
> +	base->idx = 0;
> +	base->cmd_dma_state = true;
> +	base->use_posbuf = 1;
> +	base->bdl_pos_adj = 0;
> +	base->sync_write = 1;
> +	bus->pci = pdev;
> +	bus->modelname = model;
> +	bus->mixer_assigned = -1;
> +	mutex_init(&bus->prepare_mutex);

hmm. It's not clear whether we should initialize the regular hdac_bus 
fields in the ext_bus_init(). For plain HDA, these are also initialized
in the caller. E.g. in sound/pci/hda/hda_controller.c.

So if we start cleaning up, should we go further put this in 
snd_hdac_bus_init()? 

Then another is what is the right place for settings like "sync_write = 
1". While this settings applies to all current users of the extended
bus, this is really hw specific setting and not really a property of 
the extended bus, so this feels a bit out-of-place.

Br, Kai
