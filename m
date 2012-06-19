From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH V2 13/16] ALSA: HDA: Make hda sound card
 usable for Loongson.
Date: Tue, 19 Jun 2012 11:09:41 +0200
Message-ID: <4FE041D5.8030002@ladisch.de>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
	<1340088624-25550-14-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 89EF024435
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 11:09:44 +0200 (CEST)
In-Reply-To: <1340088624-25550-14-git-send-email-chenhc@lemote.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Huacai Chen <chenhuacai@gmail.com>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>, Ralf Baechle <ralf@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>
List-Id: alsa-devel@alsa-project.org

Huacai Chen wrote:
> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>    doesn't support DMA address above 4GB).
> 2, Modify patch_conexant.c to add Lemote specific code.

Please create separate patches for these two changes.

> +++ b/include/linux/pci_ids.h
> @@ -2906,3 +2906,5 @@
>  #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
>
>  #define PCI_VENDOR_ID_OCZ		0x1b85
> +
> +#define PCI_VENDOR_ID_LEMOTE		0x1c06

AFAICS this symbol is not used in this patch.

> +#ifdef CONFIG_CPU_LOONGSON3
> +	/* Workaround: Loongson 3 doesn't support 64-bit DMA */
> +	gcap &= ~ICH6_GCAP_64OK;
> +#endif

	/* Workaround: Loongson 3 doesn't actually support 64-bit DMA */


Regards,
Clemens
