From: Case van Rij <case@seattle.gii.net>
Subject: Re: Minor bug(s) in hdsp.c (RME HDSP driver)
Date: Sun, 20 Jul 2003 10:47:38 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030720174738.GB9101@seattle.gii.net>
References: <200307191924.15922.torger@ludd.luth.se> <E19dvjH-0001Qh-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E19dvjH-0001Qh-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I for one would love to see the option to have the HDSP 9652 behave the
same way as RME9652.. I ended up with 3 different cards in 3 otherwise
identical systems (Digi9636. Digi9652, and HDSP9652) anything to make
them look more alike would be great.

One problem Ive noticed with the Digi9636 however, and im still waiting
to see it happen on the other systems, is that it stops recording after
a while if I run the following loop:

while true; do 
arecord -D plug:hw:0 -t wav -c 18 -r 22050 -I -f S16_LE `date +%s`.wav; 
done

after a few days it ends up in a loop 
ioctl(4, 0x80044121, 0xbfffee18) = 0 
poll([{fd=4, events=POLLIN|POLLERR|POLLNVAL}], 1, 1000) = 0

killing arecord doesnt fix it, a reboot does. Anything I can do to
figure out what state ended up in ? 

RME Digi9636 (Rev 1.5) with alsa-lib|driver 0.9.4 on kernel 2.4.20smp

Case

On Sat, Jul 19, 2003 at 01:47:54PM -0400, Paul Davis wrote:
> >The function hdsp_set_rate() returns -1 on error, which equals -EPERM. 
> >snd_hdsp_hw_params() returns the return value of hdsp_set_rate() on 
> >failure, thus if hdsp_set_rate() cannot be set, then -EPERM is coming 
> >out of alsa-lib.
> 
> will fix.
> 
> >I also think that the behaviour of hdsp_set_rate() should change. If the 
> >card is set to AutoSync, and there is no input signal, hdsp_set_rate() 
> >will fail on line 888. In this case, I think the proper behaviour would 
> >be to set the card in Master mode with the given rate.
> 
> seems sensible.
> 
> >At the same time I'd like to ask a question. The card I have on my hands 
> >is a HDSP 9652 PCI card. I have noticed that it has some DSP mixer, and 
> >that there are volume control settings in the driver. I want the card 
> >to work just like a good ol' RME9652 (that is no volume control no 
> >mixing, what comes in comes in, what goes out goes out), will it do 
> >that per default, or do I have to raise some volume controls and do 
> >other stuff to deactivate the mixer?
> 
> i nearly added an option to let it run like an rme9652, but didn't. if
> you don't activate the mixer, you get rme9652-like behaviour. i can
> add this, or you can. its very simple.
> 
> --p
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: VM Ware
> With VMware you can run multiple operating systems on a single machine.
> WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
> same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
