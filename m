Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A2BC47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 09:03:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738AE6124B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 09:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738AE6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DCF1169C;
	Tue,  8 Jun 2021 11:02:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DCF1169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623143004;
	bh=itUCTtYZn8wJZIKqAkWslyTy2vRNBRn3A+5bHGRHOWU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nBxPPRKJDLw/pEj/CA9paZR+PliVUEbyGmHwNjNNDFQqKG03Hf29onZ4W2q5QtOo7
	 GwCPWxGuAXFVGGtwzUH6YVsT5oF+8WxfC2JVkPXJhconD0kT2uHEVGCLvU/Nb2GZwx
	 1qI+bjzKB0IwoC6k5sJhSgv/dUTq8ZIsw4+vV1Pc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2EFEF801EC;
	Tue,  8 Jun 2021 11:02:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEA83F80218; Tue,  8 Jun 2021 11:02:31 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 648F2F80116
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 11:02:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 648F2F80116
IronPort-SDR: L0cMztNjH/DZk0gonKwRk8iO32ltNMi/06M85DdzpC0Dt2sHowCAnJBwKkD23bBwHGZtdvsOd2
 0O7d+P76xb2Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265956002"
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; d="scan'208";a="265956002"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 02:02:16 -0700
IronPort-SDR: OM9JvYGvh1u5r8MD2gjjIQcvj/JDu7hkXIc3qWWokFI/l0NNpzoUzgJ+BXp3+c6VjU1hrs7S6a
 c5da/pkzwU5A==
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; d="scan'208";a="418831355"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 02:02:14 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1lqXch-000VMf-M9; Tue, 08 Jun 2021 12:02:11 +0300
Date: Tue, 8 Jun 2021 12:02:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: boards: use software node API in Atom
 boards
Message-ID: <YL8yE/HwJHJwkR66@smile.fi.intel.com>
References: <20210607223503.584379-1-pierre-louis.bossart@linux.intel.com>
 <20210607223503.584379-3-pierre-louis.bossart@linux.intel.com>
 <0e8e01f6-d249-cc3e-2020-f6e5c81a4732@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8e01f6-d249-cc3e-2020-f6e5c81a4732@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
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

On Tue, Jun 08, 2021 at 10:18:08AM +0200, Hans de Goede wrote:
> On 6/8/21 12:35 AM, Pierre-Louis Bossart wrote:
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > The function device_add_properties() is going to be removed.
> > Replacing it with software node API equivalents.

...

> > +	device_remove_software_node(priv->codec_dev);
> 
> This is a problem, nothing guarantees codec_dev not going away before
> snd_byt_cht_es8316_mc_remove() runs. Although the only thing which I can come up
> with where this happens is unbinding the i2c-controller driver I still would like
> us to take this scenario into account.
> 
> I think it would be better to use device_create_managed_software_node() to tie
> the lifetime of the swnode to the lifetime of the device, this also removes
> the need for all the goto err cases (and introducing a remove function in
> the bytcr_rt5640.c case).

Which device? If you are telling about codec, the unload-load of the machine
driver won't be successful or will produce a leak / warning / etc.

If you are telling about machine related device, it simply doesn't belong to it.

Am I got all this right?

> This does mean that we could end up calling device_create_managed_software_node()
> on the same device twice, when the machine driver gets unbound + rebound, but
> that is an already existing issue with our current device_add_properties() usage.

Yep.

> We could fix this (in a separate commit since it is an already existing issue)
> by adding a PROPERTY_ENTRY_BOOL("cht_es8316,swnode-created") property to the
> properties and checking for that being set with
> device_property_read_bool(codec, "cht_es8316,swnode-created")

Not sure it's a good idea, this sounds like a hack.

> Or we could move the device_put(codec_dev) to snd_byt_cht_es8316_mc_remove().

This sounds better.

> I've a slight preference for using device_create_managed_software_node() +
> some mechanism to avoid a double adding of the properties, since I would like
> to try and avoid the "goto err" additions.
> 
> Ideally device_create_managed_software_node() would detect the double-add
> itself and it would return -EEXISTS. Heikki, would that be feasible ?

If I got the big picture correct, the SOF needs to switch to use fwnode graphs.

-- 
With Best Regards,
Andy Shevchenko


