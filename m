Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201A606A31B
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=KZTDQ6xT;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hIqRzb0D
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14D426022C;
	Tue,  3 Nov 2026 18:47:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14D426022C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793728033;
	bh=/1P7VenxTj8Ms50SIYZh25JmBfbf4CzHTpdj53W9VKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KZTDQ6xTIjyq7R5k9ADoeCFvbmMhBzCod3RbtQwBcluBMMpSyaMYGk164M3m6U1yb
	 GkUGv+yUi5wxSIJH01VRThNsjlWoh2GCw97gi4wDWhUNKvvNFaHf2MztnGPUs8jkbI
	 vjLYzkCzc/kxQXr4I4UKaRp5BdLUGXzCzsTaou0M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4D1EF80600; Tue,  3 Nov 2026 18:46:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16C59F80600;
	Tue,  3 Nov 2026 18:46:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBFCAF804CF; Tue,  3 Nov 2026 18:46:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793727992;
	b=azawOxInn0Kc258IQxHjrkL1Kc/nag55JdQOwSdGJfjPwONZ1H5xDaL+M6Quwd4tayAE
	 l7kMuGVAa+WhrvobRLuHIVmdyLSqvv0DqF/SLu7OzH+pIZsgXU9V+oXMpf24FSLHcNE3y
	 bpTHhV9jFA7w6IRRsA/6hSjjq/FByq6aDyqkiYk1/5BBKEFR+jUoKDpFO02Hb+anrjA5z
	 Ng1fCUM7KGj1WXY+oEuByMFMOetAfcDcbEi8VSxV+KTbGVH7bYlNnWDTENoFRiSYDclq4
	 Osi8IejZ4yl2Y2zWw5Rn2kbUWrTwJFOtTNwKWsBEY26fZji6/pWala/ubrIWlQYnG2g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793727992;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=/1P7VenxTj8Ms50SIYZh25JmBfbf4CzHTpdj53W9VKI=;
	b=LOtdX8BFnyQFPLIju/VCd3bfQDdRcjbSgAGX5fWF4VxENK8XhfZB+Cy02HYjtLPlZTOB
	 uz8LQdbKljFolJR/EQJ/91fVCzono+445v6ndGOxX8DkpYwkHY2qsjtxTSqwMx6JFOohH
	 jStXSiArBE973imXxD8Rp8pvjZSrrUPV7R2dt8SJXaftkoF6mem6ODSDdzrmbiDKajZW7
	 IvNNby3jl/4swfC69r3FtoW4b5vNjoc38urQq0pCedd8JeXBcv9j7AacLT7nHJpQerI/m
	 IkQHRUQ1oqj5lVd4+0GYGPJS97P5slCqrkfKtQDHgMGalo0YaJqqqUN7Ii0kcpWpjqA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hIqRzb0D;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B923F8021D
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 18:46:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B923F8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hIqRzb0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793727991; x=1825263991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/1P7VenxTj8Ms50SIYZh25JmBfbf4CzHTpdj53W9VKI=;
  b=hIqRzb0D5+BuZI0sJsNzw5+O3yVrUwOOakDgETlb8zjIUjeY4n9oVvnY
   k5WR7O0Ue7gm3plDbONVGiy9JhQf4nD78rMQBYyQKRimcF/vXI4PQm8eq
   C4EP2UEKAed+xy597vffHBT6ZsY3aryRyXMD2+kt/DOG9qrT7w3vUXvE8
   da4eUA328JuNlP2bNVQdQc7HN+IVuJyP8eKwvPOa7Tu8mfzJLUGZc2/uX
   uJquvhmfjfCI1qDEhPuXW7xl274gbrcA6jpFXF5CBcxHRHt6J8JM7ap2l
   VJy6buty2ztawLPZT+Ftq+z/eGj+cvsvCve04ulAFvmVZu3lrcCzW2iwR
   g==;
X-CSE-ConnectionGUID: Za9jljDVTciS8EmqRdOPog==
X-CSE-MsgGUID: fkxSZOUyQFq6fKLs6AZZXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2374164"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400";
   d="scan'208";a="2374164"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:39:41 -0800
X-CSE-ConnectionGUID: XUAjOe80Sr6jLtFqm+e+vw==
X-CSE-MsgGUID: 33FvTl2STtmU2hf2GP89ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400";
   d="scan'208";a="6813279"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:39:38 -0800
Date: Tue, 3 Nov 2026 19:39:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com,
	pin-hao.huang@hp.com, Syed.SabaKareem@amd.com
Subject: Re: [PATCH v1] ASoC: tas2783-sdw: Add basic BPT support
Message-ID: <auocWKMYhLlqGF8S@ashevche-desk.local>
References: <20261103133853.1612-1-baojun.xu@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103133853.1612-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
Message-ID-Hash: JUJNKEEEZLTJJJQN2NRJPA3JLBOAP2ZJ
X-Message-ID-Hash: JUJNKEEEZLTJJJQN2NRJPA3JLBOAP2ZJ
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JUJNKEEEZLTJJJQN2NRJPA3JLBOAP2ZJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, Nov 03, 2026 at 09:38:53PM +0800, Baojun Xu wrote:
> Add for BPT supported.

...

> +enum {
> +	SDW_MSG_FLAG_READ = 0,
> +	SDW_MSG_FLAG_WRITE,

Is it going to HW? If not, drop duplicate assignment. Otherwise assign *all* of
the enum to make code robust against modifications.

> +};

...

> +static int tas2783_fw_download_bpt(struct tas2783_prv *tas_dev,
> +				   const struct firmware *fmw)
> +{
> +	struct sdw_slave *slave = tas_dev->sdw_peripheral;
> +	struct sdw_bpt_section *sections = NULL;
> +	struct sdw_bus *bus = slave->bus;
> +	struct sdw_bpt_msg msg = {0};

'0' is not required.

> +	struct tas_fw_file file;
> +	struct tas_fw_hdr hdr;
> +	size_t offset = FW_DL_OFFSET;
> +	size_t img_sz = fmw->size;
> +	const u8 *buf = fmw->data;
> +	int num_sections = 0;
> +	int i, ret;
> +
> +	if (img_sz < FW_DL_OFFSET)
> +		return -EINVAL;
> +
> +	tas_fw_read_hdr(buf, &hdr);
> +	if (hdr.size != img_sz)
> +		return -EINVAL;
> +
> +	while (offset < (img_sz - FW_FL_HDR)) {
> +		size_t adv = (size_t)tas_fw_get_next_file(&buf[offset], &file);
> +
> +		/*
> +		 * Reject a section whose payload runs past the image. Compare
> +		 * file.length (not adv) against the space left after this
> +		 * section's header, so the check is immune to the size_t wrap
> +		 * in tas_fw_get_next_file() on 32-bit kernels.
> +		 */
> +		if (file.length > img_sz - offset - FW_FL_HDR) {
> +			dev_err(tas_dev->dev,
> +				"Firmware section at offset %zu exceeded.\n",
> +				offset);
> +			return -EINVAL;
> +		}
> +		if (num_sections >= TAS2783_MAX_FW_SECTIONS) {
> +			dev_err(tas_dev->dev,
> +				"BPT fw has too many sections (max %d)\n",
> +				TAS2783_MAX_FW_SECTIONS);
> +			return -EINVAL;
> +		}
> +		offset += adv;
> +		num_sections++;
> +	}
> +
> +	if (num_sections == 0)
> +		return -EINVAL;
> +
> +	sections = kcalloc(num_sections, sizeof(*sections), GFP_KERNEL);

__free() ?

> +	if (!sections)
> +		return -ENOMEM;
> +
> +	offset = FW_DL_OFFSET;
> +	for (i = 0; i < num_sections && offset < (img_sz - FW_FL_HDR); i++) {

	for (int i = 0; i < num_sections && offset < (img_sz - FW_FL_HDR); i++) {

> +		size_t adv = (size_t)tas_fw_get_next_file(&buf[offset], &file);
> +
> +		sections[i].addr = file.dest_addr;
> +		sections[i].len = file.length;
> +		sections[i].buf = file.fw_data;
> +		offset += adv;
> +
> +		dev_dbg(tas_dev->dev, "BPT section %d: addr=0x%x len=%d",
> +			i, file.dest_addr, file.length);
> +	}
> +
> +	msg.sec = sections;
> +	msg.sections = num_sections;
> +	msg.dev_num = slave->dev_num;
> +	msg.flags = SDW_MSG_FLAG_WRITE;
> +
> +	dev_dbg(tas_dev->dev, "BPT starting: %d sections, dev_num=%d",
> +		num_sections, slave->dev_num);
> +
> +	ret = sdw_bpt_send_sync(bus, slave, &msg);

> +

Drop blank line.

> +	if (ret < 0)
> +		dev_err(tas_dev->dev, "BPT firmware download failed: %d", ret);
> +	else
> +		dev_dbg(tas_dev->dev,
> +			 "BPT firmware download complete: %d sections",
> +			 num_sections);
> +
> +	kfree(sections);
> +	return ret;
> +}

...

>  static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
>  {
>  	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
> +	uint val;

What is this? Use unsigned int or u32 or other better fit.

>  	s32 ret;
>  
>  	if (tas_dev->hw_init)
>  		return 0;

-- 
With Best Regards,
Andy Shevchenko


