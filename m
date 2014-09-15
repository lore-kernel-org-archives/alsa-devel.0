From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] sound: pci: ctxfi: pr_* replaced with
	dev_*
Date: Mon, 15 Sep 2014 07:35:01 -0700
Message-ID: <1410791701.18787.3.camel@joe-AO725>
References: <1410790181-16457-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0210.hostedemail.com
 [216.40.44.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C71C260845
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 16:35:08 +0200 (CEST)
In-Reply-To: <1410790181-16457-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-09-15 at 19:39 +0530, Sudip Mukherjee wrote:
> pr_* macros replaced with dev_* as they are more preffered over pr_*.
[]
> diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
[]
> @@ -1282,8 +1282,8 @@ static int atc_identify_card(struct ct_atc *atc, unsigned int ssid)
>  	p = snd_pci_quirk_lookup_id(vendor_id, device_id, list);
>  	if (p) {
>  		if (p->value < 0) {
> -			pr_err("ctxfi: Device %04x:%04x is black-listed\n",
> -			       vendor_id, device_id);
> +			dev_err(atc->card->dev, "ctxfi: Device %04x:%04x is black-listed\n",
> +				vendor_id, device_id);

You should probably remove the "ctxfi: " from the dev_<level>
uses as the card->dev name is emitted by dev_err

			dev_err(atc->card->dev, "Device %04x:%04x is black-listed\n",
				vendor_id, device_id);


etc...
