Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414C4ECAAD5
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Sep 2022 14:26:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE4DE74C;
	Fri,  2 Sep 2022 16:25:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE4DE74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662128782;
	bh=frfPpI9hG7FRXshFH6k/oC1J/CB5fdpSElXOCySREWY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NJCAnANy3sIWr++FcYYgjA0YRCEk9fUvuua+kD0jjdyqv+Y8WTK2V5g6eB0uxM7z5
	 XliyqmCoNkNlTa3Tm1WkRYK58SLYdUg8CEfoveqF7xXMLVkLOCaYG4iLn3vz/+VD0r
	 0vxbMeFklMal0/1aV+SS6xJfepHr8SBBCBmahlwM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EC7AF8020D;
	Fri,  2 Sep 2022 16:25:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0806F80154; Fri,  2 Sep 2022 16:25:29 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F3AAF80154
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2022 16:25:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F3AAF80154
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295997705"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; d="scan'208";a="295997705"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2022 07:25:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; d="scan'208";a="681300258"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2022 07:25:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andy.shevchenko@gmail.com>) id 1oU7bY-007QK2-2q;
 Fri, 02 Sep 2022 17:25:08 +0300
Date: Fri, 2 Sep 2022 17:25:08 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v5 2/2] ASoC: SOF: Remove strsplit_u32() and
 tokenize_input()
Message-ID: <YxISRG13SGScC5Fn@smile.fi.intel.com>
References: <20220902133256.789165-1-cezary.rojewski@intel.com>
 <20220902133256.789165-3-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902133256.789165-3-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: andy@kernel.org, alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 intel-poland@eclists.intel.com, pierre-louis.bossart@linux.intel.com,
 willy@infradead.org, tiwai@suse.com, hdegoede@redhat.com, broonie@kernel.org,
 ranjani.sridharan@linux.intel.com, amadeuszx.slawinski@linux.intel.com,
 peter.ujfalusi@linux.intel.com, linux-kernel@vger.kernel.org
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

On Fri, Sep 02, 2022 at 03:32:56PM +0200, Cezary Rojewski wrote:
> Make use of global integer-array parsing helper instead of the internal
> one as both serve same purpose. With that, both strsplit_u32() and
> tokenize_input() become unused so remove them.

More minor comments...

...

> +	ret = parse_int_array_user(from, count, (int **)&array);
>  	if (ret < 0)
>  		return ret;

> +	num_elems = *array;
> +	bytes = sizeof(*array) * num_elems;
> +	if (!num_elems || (bytes % sizeof(*desc))) {

!num_elems is a dup since previous already does this check.

...

> +	ret = parse_int_array_user(from, count, (int **)&array);
>  	if (ret < 0)
>  		return ret;
> +
> +	num_elems = *array;

> +	if (!num_elems) {
>  		ret = -EINVAL;
>  		goto exit;
>  	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


