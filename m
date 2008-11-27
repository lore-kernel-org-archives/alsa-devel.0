From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH] sound/pci/mixart/mixart.c: Add missing snd_card_free
Date: Thu, 27 Nov 2008 14:33:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0811271432350.15160@pc-004.diku.dk>
References: <Pine.LNX.4.64.0811271423040.15160@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755194AbYK0Ndr@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0811271423040.15160@pc-004.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Oops, please ignore this patch.  There is a problem, but the modification 
is not correct.

julia


On Thu, 27 Nov 2008, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> The function snd_mixart_create creates a link between mgr and card that
> allows snd_mixart_free to free card as well.  But if snd_mixart_create
> fails, then the link has not been created and card has to be freed explicitly.
> 
> 
> The semantic match that finds the problem is as follows:
> (http://www.emn.fr/x-info/coccinelle/)
> 
> // <smpl>
> @r exists@
> local idexpression x;
> statement S,S1;
> position p1,p2,p3;
> expression E,E1;
> type T,T1;
> expression *ptr != NULL;
> @@
> 
> (
>  if ((x@p1 = snd_card_new(...)) == NULL) S
> |
>  x@p1 = snd_card_new(...);
> )
>  ... when != snd_card_free(...,(T)x,...)
>      when != if (...) { <+... snd_card_free(...,(T)x,...) ...+> }
>      when != true x == NULL || ...
>      when != x = E
>      when != E = (T)x
>      when any
> (
>  if (x == NULL || ...) S1
> |
>  if@p2 (...) {
>   ... when != snd_card_free(...,(T1)x,...)
>       when != if (...) { <+... snd_card_free(...,(T1)x,...) ...+> }
>       when != x = E1
>       when != E1 = (T1)x
> (
>   return \(0\|<+...x...+>\|ptr\);
> |
>   return@p3 ...;
> )
> }
> )
> 
> @ script:python @
> p1 << r.p1;
> p3 << r.p3;
> @@
> 
> print "* file: %s snd_card_new: %s return: %s" % (p1[0].file,p1[0].line,p3[0].line)
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  sound/pci/mixart/mixart.c           |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
> index ae7601f..1dd90f0 100644
> --- a/sound/pci/mixart/mixart.c
> +++ b/sound/pci/mixart/mixart.c
> @@ -1377,6 +1377,7 @@ static int __devinit snd_mixart_probe(struct pci_dev *pci,
>  		sprintf(card->longname, "%s [PCM #%d]", mgr->longname, i);
>  
>  		if ((err = snd_mixart_create(mgr, card, i)) < 0) {
> +			snd_card_free(card);
>  			snd_mixart_free(mgr);
>  			return err;
>  		}
> 
