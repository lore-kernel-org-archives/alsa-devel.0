Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2AEC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:45:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA87A2075E
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jsU88nXI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnbo60x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA87A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38F4916FD;
	Wed, 26 Aug 2020 11:44:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38F4916FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598435130;
	bh=rEb2MjfXopgqQeFyttJe5xNt6mctXJvZcBIyl2JNJFI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jsU88nXIyNOWv+wDfxqD/PiLS+emlEgDaYAO50AtKvNDmUfrUv9yqI+twYimVpCi6
	 rgHoF8nZkeyBcSCIGxg/XwabXTEf1RxrkOeViJLKY+7A9nQ0ivuU7ULKKFptU3wTHi
	 Q6PJO6hGPpK+RBW5qGpy+7qsElg+7BrzalkrAdIM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AAA9F8016F;
	Wed, 26 Aug 2020 11:44:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD490F801D9; Wed, 26 Aug 2020 11:44:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6FB1F80143
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 11:44:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6FB1F80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pnbo60x+"
Received: from localhost (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C8102071E;
 Wed, 26 Aug 2020 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598435065;
 bh=rEb2MjfXopgqQeFyttJe5xNt6mctXJvZcBIyl2JNJFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pnbo60x+x4RKK8IUE3UDFFHizRC5B1LAzK+MU9u5cUbaPc5HZLc43w2cIeBiOU6Nn
 MAl8LV3NHMddNmyG179zjvTCJbp8LT+b15OcWBqzh1k22QTP/1C4YZboaEu839QvYq
 UN0Z4qfDKPTiHjK9w7l8jTrBVYInbXcVlz7fBzXo=
Date: Wed, 26 Aug 2020 15:14:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 05/11] soundwire: bus: update multi-link definition with
 hw sync details
Message-ID: <20200826094420.GA2639@vkoul-mobl>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-6-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818024120.20721-6-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On 18-08-20, 10:41, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Hardware-based synchronization is typically required when the
> bus->multi_link flag is set.
> 
> On Intel platforms, when the Cadence IP is configured in 'Multi Master
> Mode', the hardware synchronization is required even when a stream
> only uses a single segment. The existing code only deal with hardware
> synchronization when a stream uses more than one segment so to remain
> backwards compatible we add a configuration threshold. For Intel cases
> this threshold will be set to one, other platforms may be able to use
> the SSP-based sync in those cases.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  include/linux/soundwire/sdw.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 76052f12c9f7..9adbe4fd7980 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -827,6 +827,11 @@ struct sdw_master_ops {
>   * @multi_link: Store bus property that indicates if multi links
>   * are supported. This flag is populated by drivers after reading
>   * appropriate firmware (ACPI/DT).
> + * @hw_sync_min_links: Number of links used by a stream above which
> + * hardware-based synchronization is required. This value is only
> + * meaningful if multi_link is set. If set to 1, hardware-based
> + * synchronization will be used even if a stream only uses a single
> + * SoundWire segment.

Soundwire spec does not say anything about multi-link so this is left to
implementer. Assuming that value of 1 would mean hw based sync will
be used even for single stream does not make sense in generic terms.
Maybe yes for Intel but may not be true for everyone?

We already use m_rt_count in code for this, so the question is why is
that not sufficient?

>   */
>  struct sdw_bus {
>  	struct device *dev;
> @@ -850,6 +855,7 @@ struct sdw_bus {
>  	unsigned int clk_stop_timeout;
>  	u32 bank_switch_timeout;
>  	bool multi_link;
> +	int hw_sync_min_links;
>  };
>  
>  int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
> -- 
> 2.17.1

-- 
~Vinod
