From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/5] ALSA: soc-sst-bxt-da7219_max98357a:
 fix obsoleted initializers for array
Date: Wed, 27 Jul 2016 12:38:35 +0900
Message-ID: <57982CBB.90809@sakamocchi.jp>
References: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
 <1469540517-32466-4-git-send-email-o-takashi@sakamocchi.jp>
 <20160727031500.GX9681@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 7DB8E265255
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 05:38:38 +0200 (CEST)
In-Reply-To: <20160727031500.GX9681@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Vinod,

On Jul 27 2016 12:15, Vinod Koul wrote:
> On Tue, Jul 26, 2016 at 10:41:55PM +0900, Takashi Sakamoto wrote:
>> Sparse reports below warnings.
>>
>> bxt_da7219_max98357a.c:250:9: warning: obsolete array initializer, use C99 syntax
>> bxt_da7219_max98357a.c:275:9: warning: obsolete array initializer, use C99 syntax
>> bxt_da7219_max98357a.c:290:9: warning: obsolete array initializer, use C99 syntax
>> bxt_da7219_max98357a.c:304:9: warning: obsolete array initializer, use C99 syntax
>> bxt_da7219_max98357a.c:317:9: warning: obsolete array initializer, use C99 syntax
>>
>> There's no need to use obsoleted way. This commit fixes it.
>
> Thanks for the patch
>
> Acked-by: Vinod Koul <vinod.koul@intel.com>

Thanks for your review.

On Jul 26 2016 22:41, Takashi Sakamoto wrote:
 > Although I got many warnings from Intel SST drivers due to confusions
 > of address spaces (__iomem and __kernel), I still left them as they
 > are, because they require more codes to fix. I hope Intel developers
 > will do additional work for them...

For your information. I'm happy if you and Intel developers are somewhat 
aware of them.

$ cd sound/soc/intel
atom/sst/sst_drv_interface.c:280:19: warning: cast removes address space 
of expression
atom/sst/sst_drv_interface.c:281:17: warning: incorrect type in argument 
2 (different address spaces)
atom/sst/sst_drv_interface.c:281:17:    expected void const volatile 
[noderef] <asn:2>*src
atom/sst/sst_drv_interface.c:281:17:    got void *
atom/sst/sst_drv_interface.c:288:19: warning: cast removes address space 
of expression
atom/sst/sst_drv_interface.c:288:14: warning: incorrect type in 
assignment (different address spaces)
atom/sst/sst_drv_interface.c:288:14:    expected void [noderef] <asn:2>*addr
atom/sst/sst_drv_interface.c:288:14:    got void *
atom/sst/sst_drv_interface.c:375:19: warning: cast removes address space 
of expression
atom/sst/sst_drv_interface.c:376:17: warning: incorrect type in argument 
2 (different address spaces)
atom/sst/sst_drv_interface.c:376:17:    expected void const volatile 
[noderef] <asn:2>*src
atom/sst/sst_drv_interface.c:376:17:    got void *
atom/sst/sst_drv_interface.c:563:19: warning: cast removes address space 
of expression
atom/sst/sst_drv_interface.c:564:25: warning: incorrect type in argument 
2 (different address spaces)
atom/sst/sst_drv_interface.c:564:25:    expected void const volatile 
[noderef] <asn:2>*src
atom/sst/sst_drv_interface.c:564:25:    got void *
atom/sst/sst_loader.c:55:26: warning: incorrect type in argument 1 
(different address spaces)
atom/sst/sst_loader.c:55:26:    expected void [noderef] <asn:2>*to
atom/sst/sst_loader.c:55:26:    got void *dst
atom/sst/sst_loader.c:55:31: warning: incorrect type in argument 2 
(different address spaces)
atom/sst/sst_loader.c:55:31:    expected void const *from
atom/sst/sst_loader.c:55:31:    got void const [noderef] <asn:2>*src
atom/sst/sst_loader.c:220:43: warning: incorrect type in argument 2 
(different address spaces)
atom/sst/sst_loader.c:220:43:    expected void *destn
atom/sst/sst_loader.c:220:43:    got void [noderef] <asn:2>*
common/sst-firmware.c:272:5: warning: symbol 'sst_dma_new' was not 
declared. Should it be static?
common/sst-firmware.c:326:6: warning: symbol 'sst_dma_free' was not 
declared. Should it be static?
common/sst-firmware.c:973:37: warning: incorrect type in argument 1 
(different address spaces)
common/sst-firmware.c:973:37:    expected void [noderef] <asn:2>*dest
common/sst-firmware.c:973:37:    got void *buffer
common/sst-firmware.c:973:61: warning: incorrect type in argument 2 
(different address spaces)
common/sst-firmware.c:973:61:    expected void *src
common/sst-firmware.c:973:61:    got void [noderef] <asn:2>*


Regards

Takashi Sakamoto
