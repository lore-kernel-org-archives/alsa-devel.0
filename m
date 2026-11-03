Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8874606EE92
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=V4C3RTpP;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KKnzxBgY
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC1F46021C;
	Mon,  9 Nov 2026 16:00:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC1F46021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236442;
	bh=Y10FOlAcC/oG9QAZv0id6dgMDiBvnnmya5qRSsRSBZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V4C3RTpP+p50mmTywXi7mNzGI6vjfLF/meeTLaX+yjuZ0o/LnFzecjLi53JJjkqH/
	 E/hqtClZb8Y5rJkB7Lr1wFPPfHjjo0zylUnsiVVk8CKzAwwI8XxwFk+x6qdQx/C2tS
	 CZfzpsMnAPMXKtduHnOkJl5nNgjbxPod2T4eF4cI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C155F8064C; Mon,  9 Nov 2026 15:59:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D0FAF80656;
	Mon,  9 Nov 2026 15:59:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A195BF804CF; Tue,  3 Nov 2026 18:23:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.215.58.27
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793726632;
	b=ocgG1GTWY7rP/bRGw9UrefEOJ7T+2s1r0IkY2aB2tMCSJIydzvzzZ9gjOOqQ7mo8s6GB
	 XDQI3XweuzTUMDucGSH0wNKgiZLpKbXDhBXqpaL35sAwX4FBjsaelaqAvkyFpuDdHgLH1
	 8uAdfygLzNZfajubtq2wcZB33SBIK3ZtYeMgsMPXyY2w1oamAxq8KyZ6365kTwKl6qAly
	 /oNuP3Vff61zAETu1aGzhby5uHX9wHIv8fhGrucqNX51v/xDyOjV3Q3N+baXGV8iBImlG
	 E8xEzAAU9r4as2T28P33AOD31RqFWvAxaomIoWqR4+rQPsOqbG+86sPlAt32yDlJcgg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793726632;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=Y10FOlAcC/oG9QAZv0id6dgMDiBvnnmya5qRSsRSBZA=;
	b=JfHyD5RLNvB1obm5ikJPcl5tlg/6O0GqhruchpgOlh2NclW78LqGD1ilixCHw/onc4gG
	 ncSlPEub2DzhX1uTYjU4MhBvJCkphlJ5pqP5XpbRDL2Bg2gb5rsChB3Kndf4mryVVUN8m
	 4V4wo7rO2yJjmQwNCgKK2Xxz5WpTAavEijJET/bsAD6ckdTEC/zVGVh0vDDBuX2PVQ4bJ
	 Pd81FaBA/xJjzaBtZQ7XK6z7L/VnhXPcjXP0KrdFgRfbEn91VSsiRympua3IENb6mpkfI
	 YV2BnQY278MAWPh+OQfvLf09bXn2iplhR3rW2LBcc5PSHfShzV7WtMMyz0Pljhpngkg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=KKnzxBgY;
	arc=none smtp.remote-ip=95.215.58.27
Received: from mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C1BD4F8021D
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 18:23:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1BD4F8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=KKnzxBgY
X-Envelope-To: alsa-devel@alsa-project.org
DKIM-Signature: a=rsa-sha256; bh=Y10FOlAcC/oG9QAZv0id6dgMDiBvnnmya5qRSsRSBZA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793726627; v=1; x=1794331427;
 b=KKnzxBgYuHumL68QcHkG3lOc+Av8ygNAMH580Dyhu2mt8+OL2fGHgoLuiczXr6uREFJA4rtw
 q66pW3JVYpx89obOtQwS8wBnc52/JHzRhGEjMCYvtM+1suDYYq3lZ3P70hApyceRWfdwtLeAvja
 cwl7m8AcfnvDVpzo7sOJFBVY=
X-Envelope-To: alsa-devel@alsa-project.org
Received: by smtp.migadu.com with ESMTPS id 6669ce5724e75a4e;
	Tue, 03 Nov 2026 17:23:47 +0000
X-Mizu-Trace-ID: 6669ce5724e75a4e
X-Migadu-Flow: FLOW_OUT
Message-ID: <bf8b2bd0-2f6c-4c1c-9b14-adef63695ed5@linux.dev>
Date: Tue, 3 Nov 2026 18:07:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: tas2783-sdw: Add basic BPT support
To: Baojun Xu <baojun.xu@ti.com>, broonie@kernel.org
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, shenghao-ding@ti.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, k-yi@ti.com,
 henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com, pin-hao.huang@hp.com,
 Syed.SabaKareem@amd.com, Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20261103133853.1612-1-baojun.xu@ti.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20261103133853.1612-1-baojun.xu@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pierre-louis.bossart@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: KFQZ7VKBKGD6NN2FAQPTX3GG5LZIPAL3
X-Message-ID-Hash: KFQZ7VKBKGD6NN2FAQPTX3GG5LZIPAL3
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:59:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KFQZ7VKBKGD6NN2FAQPTX3GG5LZIPAL3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


> +static int tas2783_fw_download_bpt(struct tas2783_prv *tas_dev,
> +				   const struct firmware *fmw)
> +{
> +	struct sdw_slave *slave = tas_dev->sdw_peripheral;
> +	struct sdw_bpt_section *sections = NULL;
> +	struct sdw_bus *bus = slave->bus;
> +	struct sdw_bpt_msg msg = {0};
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
> +	if (!sections)
> +		return -ENOMEM;
> +
> +	offset = FW_DL_OFFSET;
> +	for (i = 0; i < num_sections && offset < (img_sz - FW_FL_HDR); i++) {
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
Before adding BPT-based optimizations to speed-up firmware download,
it'd be good to address existing problems with firmware download, e.g.
when a firmware contains volume configuration information that bypasses
regmap, see the thread in "ASoC: tas2783-sdw: keep the volume settings
across resets". Using BPT will only make things worse I am afraid,
unless there's a check that this is only used for resources not managed
by regmap?
