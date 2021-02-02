Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3932C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 04:20:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AAB64ED4
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 04:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AAB64ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49FDC16D1;
	Tue,  2 Feb 2021 05:19:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49FDC16D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612239610;
	bh=RDT0bUgRK+Fj0jvAniyFsKdE4wHp6llp9BXuE5SfrCI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZPgYvJrHbr5Rm9UE67D9vJX0xxEKPT9g8/VT9kN9QOrdST3AfJhFdW0fs7x58/7nm
	 yABaL2OrY+6PVs7ZC/52/pC7LPZ5J+aotA5YIOaKExQUxFKUqUzmwLCxcuocjMNy0m
	 E89ZEXPgUNGylHk2wcPzf5FjdmGQiGLZZRSR63TA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86FBEF800E1;
	Tue,  2 Feb 2021 05:19:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 010C6F80171; Tue,  2 Feb 2021 05:19:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F2E3F800E1
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 05:19:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F2E3F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T6EzdWUM"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0EBE64ED7;
 Tue,  2 Feb 2021 04:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612239537;
 bh=RDT0bUgRK+Fj0jvAniyFsKdE4wHp6llp9BXuE5SfrCI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T6EzdWUMpVYMz2ncPSGNpuLf15UmOxwbJDh9x7/03Brv+qYuS54cbhbPriO7m8+f8
 ybKvsKsRcuhfqL7neTnJlCmmCj7YNFmlV+masicOm9bjshbb9AxlQAwUXOL48lv9GP
 oTbg8yp/AFKjpFtpLgWH2zIkETwBPnAyaGMiLkiplGLxjWxJnOxBrXWExzo0F8O2u8
 4cf2dfcXeocMz/R3iQ/i2PQTAKGSr41MVehZZZ5MDUFs7JExttVJhEOmjFmbP1i041
 0PPTqtSOC/XXka1LXfCLUEcbFyIopI/EOBGfEwjuhMOgiA50w33PhnRqUwIneIZ48W
 LafRJAxyVvf+w==
Date: Tue, 2 Feb 2021 09:48:53 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
Message-ID: <20210202041853.GF2771@vkoul-mobl>
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
 <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
 <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
 <20210201101414.GS2771@vkoul-mobl>
 <4b850685-1058-0e18-d3e8-e23e20086235@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b850685-1058-0e18-d3e8-e23e20086235@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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

On 01-02-21, 10:10, Pierre-Louis Bossart wrote:
> On 2/1/21 4:14 AM, Vinod Koul wrote:
> > On 21-01-21, 17:23, Srinivas Kandagatla wrote:
> > > On 21/01/2021 15:12, Pierre-Louis Bossart wrote:
> > > > On 1/21/21 6:03 AM, Srinivas Kandagatla wrote:

> > > I totally agree!
> > > 
> > > If I understand it correctly in Intel case there will be only one Link ID
> > > per bus.
> > 
> > Yes IIUC there would be one link id per bus.
> > 
> > the ida approach gives us unique id for each master,bus I would like to
> > propose using that everywhere
> 
> We have cases where link2 is not used but link0, 1 and 3 are.
> Using the IDA would result in master-0,1,2 being shown, that would throw the
> integrator off. the link_id is related to hardware and can tolerate gaps,
> the IDA is typically always increasing and is across the system, not
> controller specific.
> 
> We can debate forever but both pieces of information are useful, so my
> recommendation is to use both:
> 
> snprintf(name, sizeof(name), "master-%d-%d", bus_id, bus->link_id);

I agree we should use both, but does it really make sense for naming? We
can keep name in ida and expose the link_id as a parameter for
integrators to see in sysfs.

Also, even in intel case you would run into issue if you have two
independent controllers, am not sure if we ever get to see that, but I
think link_id is unique for a controller and not across system, right?

Thanks
-- 
~Vinod
