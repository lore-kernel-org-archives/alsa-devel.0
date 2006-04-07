From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Trying again with cross compile
Date: Fri, 07 Apr 2006 19:07:01 +0100
Message-ID: <1144433221.9653.51.camel@localhost.localdomain>
References: <1144413234.9653.16.camel@localhost.localdomain>
	 <s5hslopy2vx.wl%tiwai@suse.de>
	 <1144419331.9653.22.camel@localhost.localdomain>
	 <s5hpsjttq2w.wl%tiwai@suse.de>
	 <1144420643.9653.25.camel@localhost.localdomain>
	 <s5hmzextpl7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzextpl7.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-04-07 at 16:41 +0200, Takashi Iwai wrote:

> Maybe not yet?  The fix is simple as below.
> 
> 
> Takashi
> 
> 
> diff -r fd751f7a6395 -r 6cddb34dad21 include/core.h
> --- a/include/core.h	Thu Apr  6 15:23:55 2006 +0200
> +++ b/include/core.h	Thu Apr  6 15:26:05 2006 +0200
> @@ -176,7 +176,7 @@ int snd_power_wait(struct snd_card *card
>  
>  #define snd_power_lock(card)		do { (void)(card); } while (0)
>  #define snd_power_unlock(card)		do { (void)(card); } while (0)
> -static inline int snd_power_wait(struct snd_card *card, unsigned int state, struct file *file) { return 0; }
> +static inline int snd_power_wait(struct snd_card *card, unsigned int state) { return 0; }
>  #define snd_power_get_state(card)	SNDRV_CTL_POWER_D0
>  #define snd_power_change_state(card, state)	do { (void)(card); } while (0)
>  
> 

I've patched and everything seems to be fine expect that the build gets
wedged on hpi6000

I've even tried leaving if for over an hour - to no avail

Here's what make reports with debugging on if that helps anyone...

   Successfully remade target file
`/home/adrian/alsa-driver/pci/asihpi/hpi4000.o'.
    Considering target file
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.o'.
     File `/home/adrian/alsa-driver/pci/asihpi/hpi6000.o' does not
exist.
     Looking for an implicit rule for
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.o'.
     Trying pattern rule with stem `hpi6000.o'.
     Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.o_shipped'.
     Trying pattern rule with stem `hpi6000'.
     Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.c'.
     Trying rule prerequisite `FORCE'.
     Found an implicit rule for
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.o'.
      Considering target file
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.c'.
       Looking for an implicit rule for
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.c'.
       Trying pattern rule with stem `hpi6000.c'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.c_shipped'.
       Trying pattern rule with stem `hpi6000'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.y'.
       Trying pattern rule with stem `hpi6000'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.l'.
       Trying pattern rule with stem `hpi6000'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.w'.
       Trying pattern rule with stem `hpi6000'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.w'.
       Trying pattern rule with stem `hpi6000.c'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.c,v'.
       Trying pattern rule with stem `hpi6000.c'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/RCS/hpi6000.c,v'.
       Trying pattern rule with stem `hpi6000.c'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/RCS/hpi6000.c'.
       Trying pattern rule with stem `hpi6000.c'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/s.hpi6000.c'.
       Trying pattern rule with stem `hpi6000.c'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/SCCS/s.hpi6000.c'.
       Trying pattern rule with stem `hpi6000'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.y'.
       Looking for a rule with intermediate file
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.y'.
        Avoiding implicit rule recursion.
        Trying pattern rule with stem `hpi6000.y'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.y_shipped'.
        Trying pattern rule with stem `hpi6000.y'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.y,v'.
        Trying pattern rule with stem `hpi6000.y'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/RCS/hpi6000.y,v'.
        Trying pattern rule with stem `hpi6000.y'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/RCS/hpi6000.y'.
        Trying pattern rule with stem `hpi6000.y'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/s.hpi6000.y'.
        Trying pattern rule with stem `hpi6000.y'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/SCCS/s.hpi6000.y'.
       Trying pattern rule with stem `hpi6000'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.l'.
       Looking for a rule with intermediate file
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.l'.
        Avoiding implicit rule recursion.
        Trying pattern rule with stem `hpi6000.l'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.l_shipped'.
        Trying pattern rule with stem `hpi6000.l'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.l,v'.
        Trying pattern rule with stem `hpi6000.l'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/RCS/hpi6000.l,v'.
        Trying pattern rule with stem `hpi6000.l'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/RCS/hpi6000.l'.
        Trying pattern rule with stem `hpi6000.l'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/s.hpi6000.l'.
        Trying pattern rule with stem `hpi6000.l'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/SCCS/s.hpi6000.l'.
       Trying pattern rule with stem `hpi6000'.
       Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.w'.
       Looking for a rule with intermediate file
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.w'.
        Avoiding implicit rule recursion.
        Trying pattern rule with stem `hpi6000.w'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.w_shipped'.
        Trying pattern rule with stem `hpi6000.w'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.w,v'.
        Trying pattern rule with stem `hpi6000.w'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/RCS/hpi6000.w,v'.
        Trying pattern rule with stem `hpi6000.w'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/RCS/hpi6000.w'.
        Trying pattern rule with stem `hpi6000.w'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/s.hpi6000.w'.
        Trying pattern rule with stem `hpi6000.w'.
        Trying implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/SCCS/s.hpi6000.w'.
       Trying pattern rule with stem `hpi6000'.
       Rejecting impossible implicit prerequisite
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.w'.
       No implicit rule found for
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.c'.
       Finished prerequisites of target file
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.c'.
      No need to remake target
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.c'.
      Pruning file `FORCE'.
     Finished prerequisites of target file
`/home/adrian/alsa-driver/pci/asihpi/hpi6000.o'.
    Must remake target `/home/adrian/alsa-driver/pci/asihpi/hpi6000.o'.
Putting child 0x080e9bd8 (/home/adrian/alsa-driver/pci/asihpi/hpi6000.o)
PID 19527 on the chain.
Live child 0x080e9bd8 (/home/adrian/alsa-driver/pci/asihpi/hpi6000.o)
PID 19527
  CC [M]  /home/adrian/alsa-driver/pci/asihpi/hpi6000.o



It sticks here for ever - though top reports cc1 is still active



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
