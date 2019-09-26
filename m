Return-Path: <SRS0=yO1c=XV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B319C4360C
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:37:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC7D206E0
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UtG75n2h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcG3VjJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC7D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97C7A1711;
	Thu, 26 Sep 2019 20:37:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97C7A1711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569523074;
	bh=zNM95T3WJkrIgE0tHnT4fv8AIZvP7IxQmvmGcP3CVfo=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=UtG75n2hdEScVBJLhqVQktFseOV8kcya0ZojB8DOraYTHKcrIXTCaS8PZQu/5QPCv
	 F9ahgskS7Eg6t56jrRDFmocHrSfKK61eFCl4xzD4J0N4DWbCmNPy3e8PUwRiPbNBQ/
	 zSWquaFPDq8eWR0GMBzr4Mm8tN0PuYI74OwApnEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C88DF802BD;
	Thu, 26 Sep 2019 20:37:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C5A5F803F4; Thu, 26 Sep 2019 20:37:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 736E6F80140
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2019 20:37:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 736E6F80140
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZcG3VjJr"
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37046206E0;
 Thu, 26 Sep 2019 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569523017;
 bh=xjjJ++Pq6pOD0Z6Bdeb/NVVwlH+p3eI+ZRk1UkqiyYo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=ZcG3VjJrl3BAKIBfQjtCDBTWUYTWLaJXI7+Y00RIpzUCYRYonx4XTADUBDABzUZZ7
 gjTsHFXMiRyxUrIWm0oqpbpbQM1PPwiQSp21NUcXQdRFDrwMIIPaIhASUlwMCZmoVT
 KkVeQ62odeM+2uCiQIPN5atEcU1CJPJy1HRJHwBs=
Date: Thu, 26 Sep 2019 13:36:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Message-ID: <20190926183654.GA171415@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190925114353.25600-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-pci@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v5 1/2] PCI: Add pci_pr3_present() helper
 to check Power Resource for D3hot
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

On Wed, Sep 25, 2019 at 07:43:53PM +0800, Kai-Heng Feng wrote:
> Add pci_pr3_present() to check whether the platform supplies _PR3 to
> tell us which power resources the device depends on when in D3hot. This
> information is useful to let drivers choose different runtime suspend
> behavior. A user will be add in next patch.
> 
> This is mostly the same as nouveau_pr3_present().
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume Takashi will merge this along with the ALSA patch.

> ---
> v5:
> - Add wording suggestion from Bjorn.
> v4:
> - Let caller to find its upstream port device.
> 
>  drivers/pci/pci.c   | 16 ++++++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7982af9a5d8..d03f624d8928 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5856,6 +5856,22 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	return 0;
>  }
>  
> +bool pci_pr3_present(struct pci_dev *pdev)
> +{
> +	struct acpi_device *adev;
> +
> +	if (acpi_disabled)
> +		return false;
> +
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
> +		return false;
> +
> +	return adev->power.flags.power_resources &&
> +		acpi_has_method(adev->handle, "_PR3");
> +}
> +EXPORT_SYMBOL_GPL(pci_pr3_present);
> +
>  /**
>   * pci_add_dma_alias - Add a DMA devfn alias for a device
>   * @dev: the PCI device for which alias is added
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f9088c89a534..1d15c5d49cdd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2310,9 +2310,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
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
