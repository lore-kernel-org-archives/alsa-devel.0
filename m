From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ALSA: via82xx: Use common error handling
 code in snd_via82xx_create()
Date: Tue, 22 Aug 2017 23:16:12 +0300
Message-ID: <20170822201400.lw3bcjlvx4lzlq5d@mwanda>
References: <2332472c-61d2-8c21-bf46-5c80745d6380@users.sourceforge.net>
 <20170822190757.76e5edh5t6tgvzpu@mwanda>
 <d9b9dc7e-9c00-3f1d-f6f8-a2e67110c449@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 50ACA266998
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:17:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d9b9dc7e-9c00-3f1d-f6f8-a2e67110c449@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 22, 2017 at 10:05:37PM +0200, SF Markus Elfring wrote:
> >> @@ -1121,30 +1121,27 @@ static int snd_via82xx_create(struct snd_card *card,
> >>  
> >>  	if ((err = pci_request_regions(pci, card->driver)) < 0) {
> >>  		kfree(chip);
> >> -		pci_disable_device(pci);
> >> -		return err;
> >> +		goto disable_device;

Ah, you're right.  It's not leaking.  I thought you deleted the
kfree(chip);...

regards,
dan carpenter
