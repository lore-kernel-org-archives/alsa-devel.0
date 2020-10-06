Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063CCC41604
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:24:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F0320782
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T9uByTnz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEvAWCYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F0320782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 069D11704;
	Tue,  6 Oct 2020 19:23:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 069D11704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602005064;
	bh=O8037/XQX9BMZhwDeVVw/xrgcB1aBDB18FxCjX2E5Bs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T9uByTnzsjpq3mIguRPZPU+kz/jlcynSprluQHZpLaW0iL3SvAGC8MD2elpIgCc9x
	 ygISDiHSWIVvybQQHErz/BFb7zHOs/uMMdlcMKlIypMnPNQcFjPOnhFIkpi4aJWj77
	 C5M5b+5uZsSS/ceNZGhnCDWaQrKUL9p242XvX2Wg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A091F80127;
	Tue,  6 Oct 2020 19:23:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFE89F8012A; Tue,  6 Oct 2020 19:23:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8A32F80127
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 19:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8A32F80127
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gEvAWCYY"
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4FB0420782;
 Tue,  6 Oct 2020 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602005002;
 bh=O8037/XQX9BMZhwDeVVw/xrgcB1aBDB18FxCjX2E5Bs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gEvAWCYYLyEIbgMzIMDzaE1mi8CXHQt4WiqgEJzlzaS35baukykaJVSXX150gy+kv
 EbaFpf1GvtUgK9iNI9VMmmvhBGYcoQlCkM2ZvTiyIqZaK4/IkigHEgO2YT2XNBervS
 OFpTXKQc7GZgOgtU8WDmPPctfymrriTdmVZgesdg=
Date: Tue, 6 Oct 2020 20:23:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH v2 1/6] Add ancillary bus support
Message-ID: <20201006172317.GN1874917@unreal>
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-2-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005182446.977325-2-david.m.ertman@intel.com>
Cc: alsa-devel@alsa-project.org, parav@mellanox.com, tiwai@suse.de,
 netdev@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, fred.oh@linux.intel.com,
 linux-rdma@vger.kernel.org, dledford@redhat.com, broonie@kernel.org,
 jgg@nvidia.com, gregkh@linuxfoundation.org, kuba@kernel.org,
 dan.j.williams@intel.com, shiraz.saleem@intel.com, davem@davemloft.net,
 kiran.patil@intel.com
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

On Mon, Oct 05, 2020 at 11:24:41AM -0700, Dave Ertman wrote:
> Add support for the Ancillary Bus, ancillary_device and ancillary_driver.
> It enables drivers to create an ancillary_device and bind an
> ancillary_driver to it.
>
> The bus supports probe/remove shutdown and suspend/resume callbacks.
> Each ancillary_device has a unique string based id; driver binds to
> an ancillary_device based on this id through the bus.
>
> Co-developed-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Co-developed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---

<...>

> +/**
> + * __ancillary_driver_register - register a driver for ancillary bus devices
> + * @ancildrv: ancillary_driver structure
> + * @owner: owning module/driver
> + */
> +int __ancillary_driver_register(struct ancillary_driver *ancildrv, struct module *owner)
> +{
> +	if (WARN_ON(!ancildrv->probe) || WARN_ON(!ancildrv->remove) ||
> +	    WARN_ON(!ancildrv->shutdown) || WARN_ON(!ancildrv->id_table))
> +		return -EINVAL;

In our driver ->shutdown is empty, it will be best if ancillary bus will
do "if (->remove) ..->remove()" pattern.

> +
> +	ancildrv->driver.owner = owner;
> +	ancildrv->driver.bus = &ancillary_bus_type;
> +	ancildrv->driver.probe = ancillary_probe_driver;
> +	ancildrv->driver.remove = ancillary_remove_driver;
> +	ancildrv->driver.shutdown = ancillary_shutdown_driver;
> +

I think that this part is wrong, probe/remove/shutdown functions should
come from ancillary_bus_type. You are overwriting private device_driver
callbacks that makes impossible to make container_of of ancillary_driver
to chain operations.

> +	return driver_register(&ancildrv->driver);
> +}
> +EXPORT_SYMBOL_GPL(__ancillary_driver_register);

Thanks
