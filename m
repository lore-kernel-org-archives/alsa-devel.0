Return-Path: <SRS0=Ovzg=4N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57268C35E0E
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:58:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3687222C2
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Lxa85jZr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="saTPPq1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3687222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F413166C;
	Tue, 25 Feb 2020 21:57:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F413166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582664305;
	bh=Rypr7ZcCh3/KMa7zUtTWHxN5tpwd6oUsx8Lx4vdqwMk=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Lxa85jZrH8N+Deds+jx54jBMnvPqjJdQTb8s6qT53BT4i/CFYx/5XXAKDukZUbg6p
	 vSlZwuxzlNGj+DjiU7G16KtHjE/ONEUua3WgOIIO+ggNWy0AV1fOrtpbjAI37aGJcF
	 a5BKu2z8GpURDlbz0MOE52lV0Vbml/FQKVvzhXmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84770F8013E;
	Tue, 25 Feb 2020 21:57:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91605F80142; Tue, 25 Feb 2020 21:57:32 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B7D7F800AD
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2020 21:57:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B7D7F800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="saTPPq1I"
Received: from localhost (mobile-166-175-186-165.mycingular.net
 [166.175.186.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7ACF22176D;
 Tue, 25 Feb 2020 20:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582664247;
 bh=Rypr7ZcCh3/KMa7zUtTWHxN5tpwd6oUsx8Lx4vdqwMk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=saTPPq1IDMzPUuwqxy3ZuO7f+3vh/70NVZ0l1VhP3hk7OqaweW93ZLKtzBrT18SjH
 10l061LcAZN51AIZTBJ6w9HmtBuH4sTJDFIkV/1Bn0DyWQHP9+QrwNae+mdvAqGZoL
 Fu6UaLjJ2+1p1nAM411ujb0LsepAurPQ6kmQm+k8=
Date: Tue, 25 Feb 2020 14:57:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 2/8] PCI: add pci_status_get_and_clear_errors
Message-ID: <20200225205725.GA197467@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45054c7d-cc48-2be0-11fa-4c3ffce8fdd7@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: alsa-devel@alsa-project.org,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 David Miller <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mirko Lindner <mlindner@marvell.com>
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

On Tue, Feb 25, 2020 at 03:04:23PM +0100, Heiner Kallweit wrote:
> Few drivers use the following code sequence:

This reads like "Not very many drivers".  I think "Several drivers"
would capture the sense of this better.

> 1. Read PCI_STATUS
> 2. Mask out non-error bits
> 3. Action based on error bits set
> 4. Write back set error bits to clear them
> 
> As this is a repeated pattern, add a helper to the PCI core.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/pci.c   | 23 +++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d828ca835..c16b0ba2a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -173,6 +173,29 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_max_busnr);
>  
> +/**
> + * pci_status_get_and_clear_errors - return and clear error bits in PCI_STATUS
> + * @pdev: the PCI device
> + *
> + * Returns error bits set in PCI_STATUS and clears them.
> + */
> +int pci_status_get_and_clear_errors(struct pci_dev *pdev)
> +{
> +	u16 status;
> +	int ret;
> +
> +	ret = pci_read_config_word(pdev, PCI_STATUS, &status);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return -EIO;
> +
> +	status &= PCI_STATUS_ERROR_BITS;
> +	if (status)
> +		pci_write_config_word(pdev, PCI_STATUS, status);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(pci_status_get_and_clear_errors);
> +
>  #ifdef CONFIG_HAS_IOMEM
>  void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3840a541a..7a75aae04 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1203,6 +1203,7 @@ int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
>  void pci_ignore_hotplug(struct pci_dev *dev);
>  struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
> +int pci_status_get_and_clear_errors(struct pci_dev *pdev);
>  
>  int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
>  		irq_handler_t handler, irq_handler_t thread_fn, void *dev_id,
> -- 
> 2.25.1
> 
> 
> 
> 
