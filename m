From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] DDB5477: Remove driver bits of support
Date: Mon, 30 Jul 2007 11:50:21 -0400
Message-ID: <46AE08BD.1080400@garzik.org>
References: <20070730154116.GA25008@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935307AbXG3Pu5@vger.kernel.org>
In-Reply-To: <20070730154116.GA25008@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
List-Id: alsa-devel@alsa-project.org

Ralf Baechle wrote:
> From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  drivers/net/tulip/tulip_core.c |    8 
>  drivers/serial/8250_pci.c      |   20 
>  include/linux/pci_ids.h        |    1 
>  sound/oss/Kconfig              |    8 
>  sound/oss/Makefile             |    1 
>  sound/oss/nec_vrc5477.c        | 2060 -----------------------------------------
>  6 files changed, 2098 deletions(-)

ACK
