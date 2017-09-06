From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/3] ALSA: ymfpci: Use common error
 handling code in snd_card_ymfpci_probe()
Date: Thu, 7 Sep 2017 00:51:20 +0300
Message-ID: <20170906215120.m7ifun3doq5famva@mwanda>
References: <dafe6d86-1bfd-41a8-e189-bde7ae30dea9@users.sourceforge.net>
 <c3b3d66c-1fb1-8bb9-cf00-674fd4e20afb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id CC9972673FE
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 23:51:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <c3b3d66c-1fb1-8bb9-cf00-674fd4e20afb@users.sourceforge.net>
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
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 06, 2017 at 09:46:52PM +0200, SF Markus Elfring wrote:
> @@ -336,21 +331,24 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
>  			legacy_ctrl &= ~YMFPCI_LEGACY_FMEN;
>  			pci_write_config_word(pci, PCIR_DSXG_LEGACY, legacy_ctrl);
>  		} else if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
> -			snd_card_free(card);
                        ^^^^^^^^^^^^^^^^^^^
>  			dev_err(card->dev, "cannot create opl3 hwdep\n");
                                ^^^^^^^^^
> -			return err;
> +			goto free_card;

Heh.  I was worried that some of these re-orderings would introduce bugs
but actually this one fixes a use after free.

regards,
dan carpenter
