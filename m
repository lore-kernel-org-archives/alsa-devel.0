Return-Path: <SRS0=Ovzg=4N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E87FC35E0E
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:51:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174172176D
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="edatWRId";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmyBTjgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174172176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 556AC1670;
	Tue, 25 Feb 2020 21:50:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 556AC1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582663906;
	bh=Q3oe1jxf23yBLBrYYE0k+LTqlIPd2rBAHhHvbGkjQlo=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=edatWRIdlev7o/NpSUlhlEsvGrKdN5cEQDJ6u8eYa0/DUnt29lpxANq1TGR0D8KHr
	 Kcs+8cvCI0pb6V7psC2JiDTX+7dtVqyLJrnZSnp81yFUTrxPCnHGVB4YZacsK8GBh3
	 WdrrfdzFqeEJjj9wJD1JuLEW1JU0IffyRITT4f5c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5258F800AD;
	Tue, 25 Feb 2020 21:50:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 935C2F80142; Tue, 25 Feb 2020 21:50:54 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBBA1F800AD
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2020 21:50:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBBA1F800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tmyBTjgn"
Received: from localhost (mobile-166-175-186-165.mycingular.net
 [166.175.186.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A8A6520675;
 Tue, 25 Feb 2020 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582663849;
 bh=Q3oe1jxf23yBLBrYYE0k+LTqlIPd2rBAHhHvbGkjQlo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=tmyBTjgnONnSCV+zBj0HV0B4XxFIdMnoFPCfUcc6+p3zeJfkCYynmcFx5XzEJJeWx
 2d1rVmeeWj9K9LOxXYsW1QaAv+IAA0OJi9Ty4i1N04Tj1urzCMLDNqSSSDW79mAhXy
 Bb/oqu2up4Ig0LQ6MNqF38n633K3DyjjSlyYGaRk=
Date: Tue, 25 Feb 2020 14:50:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 1/8] PCI: add constant PCI_STATUS_ERROR_BITS
Message-ID: <20200225205047.GA194679@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73dd692e-bbce-35f5-88e9-417fb0f7229e@gmail.com>
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

On Tue, Feb 25, 2020 at 03:03:44PM +0100, Heiner Kallweit wrote:

Run "git log --oneline drivers/pci" and make yours match.  In
particular, capitalize the first word ("Add").  Same for the other PCI
patches.  I don't know the drivers/net convention, but please find and
follow that as well.

> This constant is used (with different names) in more than one driver,
> so move it to the PCI core.

The driver constants in *this* patch at least use the same name.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/marvell/skge.h | 6 ------
>  drivers/net/ethernet/marvell/sky2.h | 6 ------
>  include/uapi/linux/pci_regs.h       | 7 +++++++
>  3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/skge.h b/drivers/net/ethernet/marvell/skge.h
> index 6fa7b6a34..e149bdfe1 100644
> --- a/drivers/net/ethernet/marvell/skge.h
> +++ b/drivers/net/ethernet/marvell/skge.h
> @@ -15,12 +15,6 @@
>  #define  PCI_VPD_ROM_SZ	7L<<14	/* VPD ROM size 0=256, 1=512, ... */
>  #define  PCI_REV_DESC	1<<2	/* Reverse Descriptor bytes */
>  
> -#define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY | \
> -			       PCI_STATUS_SIG_SYSTEM_ERROR | \
> -			       PCI_STATUS_REC_MASTER_ABORT | \
> -			       PCI_STATUS_REC_TARGET_ABORT | \
> -			       PCI_STATUS_PARITY)
> -
>  enum csr_regs {
>  	B0_RAP	= 0x0000,
>  	B0_CTST	= 0x0004,
> diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
> index b02b65230..851d8ed34 100644
> --- a/drivers/net/ethernet/marvell/sky2.h
> +++ b/drivers/net/ethernet/marvell/sky2.h
> @@ -252,12 +252,6 @@ enum {
>  };
>  
>  
> -#define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY | \
> -			       PCI_STATUS_SIG_SYSTEM_ERROR | \
> -			       PCI_STATUS_REC_MASTER_ABORT | \
> -			       PCI_STATUS_REC_TARGET_ABORT | \
> -			       PCI_STATUS_PARITY)
> -
>  enum csr_regs {
>  	B0_RAP		= 0x0000,
>  	B0_CTST		= 0x0004,
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 543769048..9b84a1278 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -68,6 +68,13 @@
>  #define  PCI_STATUS_SIG_SYSTEM_ERROR	0x4000 /* Set when we drive SERR */
>  #define  PCI_STATUS_DETECTED_PARITY	0x8000 /* Set on parity error */
>  
> +#define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY  | \
> +			       PCI_STATUS_SIG_SYSTEM_ERROR | \
> +			       PCI_STATUS_REC_MASTER_ABORT | \
> +			       PCI_STATUS_REC_TARGET_ABORT | \
> +			       PCI_STATUS_SIG_TARGET_ABORT | \
> +			       PCI_STATUS_PARITY)

This actually *adds* PCI_STATUS_SIG_TARGET_ABORT, which is not in the
driver definitions.  At the very least that should be mentioned in the
commit log.

Ideally the addition would be in its own patch so it's obvious and
bisectable, but I see the problem -- the subsequent patches
consolidate things that aren't really quite the same.  One alternative
would be to have preliminary patches that change the drivers
individually so they all use this new mask, then do the consolidation
afterwards.

There is pitifully little documentation about the use of include/uapi,
but AFAICT that is for the user API, and this isn't part of that.  I
think this #define could go in include/linux/pci.h instead.

> +
>  #define PCI_CLASS_REVISION	0x08	/* High 24 bits are class, low 8 revision */
>  #define PCI_REVISION_ID		0x08	/* Revision ID */
>  #define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
> -- 
> 2.25.1
> 
> 
> 
> 
