From: "Yon Mercury" <swirlee@stickist.com>
Subject: Re: Re: Echo driver
Date: Tue, 23 Nov 2004 20:14:06 -0700
Message-ID: <20041124031406.M70915@stickist.com>
References: <20041123004518.M39311@stickist.com> <XFMail.20041123104138.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20041123104138.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano,

Yes, the register dump was taken when the card was in. I tried manually
changing latency timer and pci prefetch but with no success. Running:

setpci -s 00:0f latency_timer=c0
setpci -s 00:0f 80.B=00

Shows changed values in lspci.
But still the driver fails to load when I do a 'modprobe snd-indigoio'. If I
try a '/etc/init.d/pcmcia restart' to restart CardBus services, all the PCI
settings return to their old values and I have to use setpci again.

This is getting to be a bit ridiculous. If this is a CardBus bridge issue,
someone with a different bridge chip should be able to get the Echo card
working, right? Does anyone out there on the list have audio working on a
CardBus system that could test an Echo card? 

Giuliano, have you heard from any of the other Echo Audio users who might have
one of those cards?

If it is a CardBus bridge issue, then we could take it up with the PCMCIA-CS
people. 

On the other hand, is it possible that its an Echo driver issue?

Cheers,
-Mercury


On Tue, 23 Nov 2004 10:41:38 +0100 (CET), Giuliano Pochini wrote
> On 23-Nov-2004 Yon Mercury wrote:
> 
> > OK, here's a comparison of the CardBus registers between Linux and Windows.
> > As you can see, some registers are different-- take 0D for example.
> 
> I guess you got the register dump while the cards was in, didn't you 
> ? Just to be sure :)  I'm asking this because the latency timer 
> should be 0xC0, not 0x40.
> 
> > The question is, what registers are likely to be the ones we have to change?
> 
> Register 0x80 should be 00 (PCI prefetch disabled).
> Register 0x0D should be C0 (latency timer, the driver should be
> able to set it, so don't touch it).
> 
> I don't know about all other registers because I couldn't find
> any documentation. Registers >=0x80 are chip-specific and they
> are explained here: http://pcmcia-cs.sourceforge.net/specs/AP476IIE10.pdf



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
