From: jaspal.kallar.xfree86@spray.se
Subject: Re: Support for powermac G5?
Date: Mon, 21 Jun 2004 19:30:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56L0.0406211910270.12620@linux.local>
References: <Pine.LNX.4.56L0.0406201812430.22212@linux.local>
 <40D70D3E.60203@t-online.de>
Reply-To: jaspal.kallar.xfree86@spray.se
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40D70D3E.60203@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



On Mon, 21 Jun 2004, Reiner Klenk wrote:

> Dont't know anything about soundchips on G5, but on my new Powerbook I 
> had to comment out the chipset identification in pmac.c and set the chip 
> to snapper.
> 
> Reiner


Reiner: I presume your commnets are for the function (pmac.c): 
"static int __init snd_pmac_detect(pmac_t *chip)" 

where you commented out the if-statement (line 927 for me) :

if (device_is_compatible(sound, "snapper")) {
                chip->model = PMAC_SNAPPER;
                // chip->can_byte_swap = 0; /* FIXME: check this */
                chip->num_freqs = 2;
                chip->freq_table = tumbler_freqs;
                chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
}
 
so that it was snapper. A question though. How did you know that you had 
to set the chipset to snapper ? Was this information available somewhere 
in /proc ? For example, (wild guess) is the information in  
/proc/device-tree/ht@0,f2000000/pci@3/mac-io@7/i2s@10000/i2s-a@0/sound/compatible
important ? In my case it gives AOAK2.

Also did you get the same error as me i.e 
"ALSA sound/ppc/pmac.c:1095: pmac: can't request resource 0!"
in /var/log/messages?

Thanks,

Jaspal.


 > 
> jaspal.kallar.xfree86@spray.se wrote:
> > Can anybody say if sound on the powermac G5 is supported ?
> > I have no idea which chipset it is either.
> > 
> > I've tried with kernels 2.6.5, 2.6.6 and 2.6.7
> > 
> > modprobe snd-powermac
> > FATAL: Error inserting snd_powermac 
> > (/lib/modules/2.6.7-r0/kernel/sound/ppc/snd-powermac.ko): No such device
> > 
> > 
> > and in /var/log/messages I get
> > 
> > "Jun 20 18:19:09 linux ALSA sound/ppc/pmac.c:1095: pmac: can't request resource 0!
> >  Jun 20 18:19:09 linux no PMac soundchip found"
> > 
> > 
> > Can anybody give me some pointers into what the problem could be. Btw I 
> > have snd-powermac as a module and not compliled into any of the above kernels.
> > But I have also tried it compliled into the kernel but with same results.
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
> > Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
> > Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
> > REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
> Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
> Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
> REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> 
> 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
