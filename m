From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.11-mm1: sound <-> GAMEPORT problems
Date: Mon, 7 Mar 2005 22:52:06 +0100
Message-ID: <20050307215206.GH3170@stusta.de>
References: <20050304033215.1ffa8fec.akpm@osdl.org> <200503070941.59365.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 7AA601D2
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2005 22:52:08 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <200503070941.59365.petkov@uni-muenster.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Borislav Petkov <petkov@uni-muenster.de>, perex@suse.cz, vojtech@suse.cz
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2005 at 09:41:59AM +0100, Borislav Petkov wrote:
> On Friday 04 March 2005 12:32, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
> >-mm1/
> >
> <snip>
> 
> Hi,
> 
> the ymfpci sound driver wouldn't compile without gameport support selected 
> since the sound card has a gameport on it:
> 
> Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> 
> --- sound/pci/ymfpci/ymfpci.c.orig 2005-03-07 09:07:10.000000000 +0100
> +++ sound/pci/ymfpci/ymfpci.c 2005-03-07 09:08:02.000000000 +0100
> @@ -332,7 +332,9 @@ static int __devinit snd_card_ymfpci_pro
>    }
>   }
>  
> +#ifdef SUPPORT_JOYSTICK
>   snd_ymfpci_create_gameport(chip, dev, legacy_ctrl, legacy_ctrl2);
> +#endif /* SUPPORT_JOYSTICK */
>  
>   if ((err = snd_card_register(card)) < 0) {
>    snd_card_free(card);


Nice catch (but I had to apply the patch manually due to some 
whitespace damage).


After a quick look, it seems there are a dozen other sound drivers (most 
OSS but also ALSA) with similar problems.

There are two possibilities:
1. continue to #ifdef all GAMEPORT support in sound drivers
2. remove all #ifdef's for GAMEPORT and let drivers that can use the
   gameport (including the sound drivers) simply select GAMEPORT
   As far as I can see, in this case GAMEPORT does no longer have to be
   user-visible?


I can send patches for both, but I'd prefer the second solution.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
