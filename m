Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54299C3F2CD
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:43:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D452B2166E
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="De16Of8W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1az3IsPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D452B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F3AA85D;
	Wed,  4 Mar 2020 14:42:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F3AA85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583329380;
	bh=f1Y2hYI2F6EVeEKTqa2xdZCYpPUDDIjI7ki27j/xyVg=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=De16Of8WpRvS2RjSFWqXbLG7kDuOS0fr5n8O+8TIV2SCyImSKkD1FHcA2V901NtfE
	 c4evaPmtmfUQZjEOGdRNYD4As5hH5yFlR7BFIPVL3NBlbrB0dYNANIOI28y0ps1k+S
	 wQ+MkO8AHspmRnvYr+/urO7hQU8+TlnWxULRRpeQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93627F801EC;
	Wed,  4 Mar 2020 14:42:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8446BF801ED; Wed,  4 Mar 2020 14:42:07 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC4EFF800D8
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 14:42:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC4EFF800D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1az3IsPQ"
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3588F2146E;
 Wed,  4 Mar 2020 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583329320;
 bh=f1Y2hYI2F6EVeEKTqa2xdZCYpPUDDIjI7ki27j/xyVg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=1az3IsPQVMk+8zuLHZ/l1wDKs2ypB/IzAiW56V8dWq6RBbuUXQsM4d+hOHub8wy7A
 SjIo1r4Vlz6ayqA5fIcg6dKb4Hv5Dc0OGz5bxbz7Iiihrwzcf6+7hvX8gDiQUDeIS0
 zpZ/iWnEu7bcNB+r5KT8aISHkWHDytxxb+VBwYZM=
Date: Wed, 4 Mar 2020 07:41:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 04/10] PCI: Add constant PCI_STATUS_ERROR_BITS
Message-ID: <20200304134159.GA193414@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175dca23-c3b1-e297-ef35-4100f1c96879@gmail.com>
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

On Sat, Feb 29, 2020 at 11:23:44PM +0100, Heiner Kallweit wrote:
> This collection of PCI error bits is used in more than one driver,
> so move it to the PCI core.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> v4:
> - move new constant to include/linux/pci.h
> - improve commit description
> ---
>  drivers/net/ethernet/marvell/skge.h | 7 -------
>  drivers/net/ethernet/marvell/sky2.h | 7 -------
>  include/linux/pci.h                 | 7 +++++++
>  3 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/skge.h b/drivers/net/ethernet/marvell/skge.h
> index e76c03c87..e149bdfe1 100644
> --- a/drivers/net/ethernet/marvell/skge.h
> +++ b/drivers/net/ethernet/marvell/skge.h
> @@ -15,13 +15,6 @@
>  #define  PCI_VPD_ROM_SZ	7L<<14	/* VPD ROM size 0=256, 1=512, ... */
>  #define  PCI_REV_DESC	1<<2	/* Reverse Descriptor bytes */
>  
> -#define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY | \
> -			       PCI_STATUS_SIG_SYSTEM_ERROR | \
> -			       PCI_STATUS_REC_MASTER_ABORT | \
> -			       PCI_STATUS_REC_TARGET_ABORT | \
> -			       PCI_STATUS_SIG_TARGET_ABORT | \
> -			       PCI_STATUS_PARITY)
> -
>  enum csr_regs {
>  	B0_RAP	= 0x0000,
>  	B0_CTST	= 0x0004,
> diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
> index aee87f838..851d8ed34 100644
> --- a/drivers/net/ethernet/marvell/sky2.h
> +++ b/drivers/net/ethernet/marvell/sky2.h
> @@ -252,13 +252,6 @@ enum {
>  };
>  
>  
> -#define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY | \
> -			       PCI_STATUS_SIG_SYSTEM_ERROR | \
> -			       PCI_STATUS_REC_MASTER_ABORT | \
> -			       PCI_STATUS_REC_TARGET_ABORT | \
> -			       PCI_STATUS_SIG_TARGET_ABORT | \
> -			       PCI_STATUS_PARITY)
> -
>  enum csr_regs {
>  	B0_RAP		= 0x0000,
>  	B0_CTST		= 0x0004,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3840a541a..101d71e0a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -42,6 +42,13 @@
>  
>  #include <linux/pci_ids.h>
>  
> +#define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY  | \
> +			       PCI_STATUS_SIG_SYSTEM_ERROR | \
> +			       PCI_STATUS_REC_MASTER_ABORT | \
> +			       PCI_STATUS_REC_TARGET_ABORT | \
> +			       PCI_STATUS_SIG_TARGET_ABORT | \
> +			       PCI_STATUS_PARITY)
> +
>  /*
>   * The PCI interface treats multi-function devices as independent
>   * devices.  The slot/function address of each device is encoded
> -- 
> 2.25.1
> 
> 
