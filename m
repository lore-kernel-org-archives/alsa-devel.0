Return-Path: <SRS0=MTqT=XE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADA9C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:42:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D21218AF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lCL/L1H/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xUsN32R3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D21218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B29D115F8;
	Mon,  9 Sep 2019 13:41:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B29D115F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568029362;
	bh=znjk1+KB+9rTIR6v2hn2+1osaANXwPlH9GQx61KDGts=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lCL/L1H/Qlt7Cufv9dlAhWvl7qC/wA7y+6mM57BqgljNwuRGC9TtmWcfxf1NWicpU
	 BBlBCiQgWABgKsI5+IGXHwcDnSzI3fEEcADJGqrlGbEkG81i5jm87fYYTIkwB3wO4H
	 MXI55SF4WgfkvjZsy2K5ZQ9kYNwx6xw5NwuO3oVs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11588F800A9;
	Mon,  9 Sep 2019 13:41:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F694F80323; Mon,  9 Sep 2019 13:41:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49978F800A9
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2019 13:41:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49978F800A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xUsN32R3"
Received: from localhost (unknown [148.69.85.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 582BA218AF;
 Mon,  9 Sep 2019 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568029292;
 bh=UIBpQL4IyoiRivShLSPvpPLy/w0INLuoSj765Ms5he4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xUsN32R35u2UBRj2lHEcA9H44gsX3xq+T5JpQmqDZWfJa1FKtItfngp9xYD5JwbTx
 xrTzIzCNrmEsodCvE2TC1jZyOwtkUb0qNP8keMHS8wjJkqKG+aRjDmBg1y7di6ZbHG
 vjxrtpyNpkPBkeyHRqWC/dCmpSrudREk4MBNKyFI=
Date: Mon, 9 Sep 2019 06:41:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Message-ID: <20190909114129.GT103977@google.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190827134756.10807-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-pci@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 1/2] PCI: Add a helper to check Power
 Resource Requirements _PR3 existence
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Maybe:

  PCI: Add pci_pr3_present() to check for Power Resources for D3hot

On Tue, Aug 27, 2019 at 09:47:55PM +0800, Kai-Heng Feng wrote:
> A driver may want to know the existence of _PR3, to choose different
> runtime suspend behavior. A user will be add in next patch.

Maybe include something like this in the commit lot?

  Add pci_pr3_present() to check whether the platform supplies _PR3 to
  tell us which power resources the device depends on when in D3hot.

> This is mostly the same as nouveau_pr3_present().
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci.c   | 20 ++++++++++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1b27b5af3d55..776af15b92c2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5856,6 +5856,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	return 0;
>  }
>  
> +bool pci_pr3_present(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> +	struct acpi_device *parent_adev;
> +
> +	if (acpi_disabled)
> +		return false;
> +
> +	if (!parent_pdev)
> +		return false;
> +
> +	parent_adev = ACPI_COMPANION(&parent_pdev->dev);
> +	if (!parent_adev)
> +		return false;
> +
> +	return parent_adev->power.flags.power_resources &&
> +		acpi_has_method(parent_adev->handle, "_PR3");

I think this is generally OK, but it doesn't actually check whether
*pdev* has a _PR3; it checks whether pdev's *parent* does.  So does
that mean this is dependent on the GPU topology, i.e., does it assume
that there is an upstream bridge and that power for everything under
that bridge can be managed together?

I'm wondering whether the "parent_pdev = pci_upstream_bridge()" part
should be in the caller rather than in pci_pr3_present()?

I can't connect any of the dots from _PR3 through to
"need_eld_notify_link" (whatever "eld" is :)) and the uses of
hda_intel.need_eld_notify_link (and needs_eld_notify_link()).

But that's beyond the scope of *this* patch and it makes sense that
you do want to discover the _PR3 existence, so I'm fine with this once
we figure out the pdev vs parent question.

> +}
> +EXPORT_SYMBOL_GPL(pci_pr3_present);
> +
>  /**
>   * pci_add_dma_alias - Add a DMA devfn alias for a device
>   * @dev: the PCI device for which alias is added
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 82e4cd1b7ac3..9b6f7b67fac9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2348,9 +2348,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
>  
>  void
>  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
> +bool pci_pr3_present(struct pci_dev *pdev);
>  #else
>  static inline struct irq_domain *
>  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
> +static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
>  #endif
>  
>  #ifdef CONFIG_EEH
> -- 
> 2.17.1
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
