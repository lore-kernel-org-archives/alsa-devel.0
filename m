From: Robert Lemmen <robertle@semistable.com>
Subject: Re: hda-intel without headphone output
Date: Mon, 25 Jun 2007 10:07:44 +0200
Message-ID: <20070625080744.GA15207@sandbender>
References: <s5h8xamk612.wl%tiwai@suse.de> <20070614182703.GA9443@sandbender>
	<1181874374.12385.203.camel@razman.gruemaster.com>
	<s5hhcp4i711.wl%tiwai@suse.de> <20070619113525.GA4477@sandbender>
	<s5htzt4gof6.wl%tiwai@suse.de> <20070620190240.GA13021@sandbender>
	<s5hejk5a9m0.wl%tiwai@suse.de> <20070621171230.GA2057@sandbender>
	<s5h1wg4jf0u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d80-237-144-212.dds.hosteurope.de (debian.semistable.com
	[80.237.144.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 4311A2436B
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 10:14:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1wg4jf0u.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi takashi,

On Fri, Jun 22, 2007 at 03:27:13PM +0200, Takashi Iwai wrote:
> Do you mean the patch below (posted by Tobin)?
> If this really works for you, I'll merge it happily.
> [...]
> diff -r deaa182aebd8 pci/hda/patch_conexant.c
> --- a/pci/hda/patch_conexant.c	Wed Jun 20 15:46:13 2007 +0200
> +++ b/pci/hda/patch_conexant.c	Thu Jun 21 10:48:49 2007 -0700
> @@ -802,7 +802,7 @@ static struct snd_pci_quirk cxt5045_cfg_
>  	SND_PCI_QUIRK(0x103c, 0x30b5, "HP DV2120", CXT5045_LAPTOP),
>  	SND_PCI_QUIRK(0x103c, 0x30cd, "HP DV Series", CXT5045_LAPTOP),
>  	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_FUJITSU),
> -	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_FUJITSU),
> +	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_LAPTOP),
>  	SND_PCI_QUIRK(0x8086, 0x2111, "Conexant Reference board", CXT5045_LAPTOP),
>  	{}
>  };

exactly, this works perfectly on my machine!

cu  robert

-- 
Robert Lemmen                               http://www.semistable.com 
