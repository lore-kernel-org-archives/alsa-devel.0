From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus=distortion -- the
 sagacontinues (cardbus driver=culprit?) MORE UPDATE
Date: Mon, 5 Apr 2004 01:14:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040405011421.1279aa5a@laptop>
References: <20040404114902.2c1664cc@laptop>
	<200404041453.i34ErSJX004745@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200404041453.i34ErSJX004745@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: linux-pcmcia@lists.infradead.org, ritsch@iem.at, Thomas Charbonnel <thomas@undata.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 04 Apr 2004 10:53:28 -0400
Paul Davis <paul@linuxaudiosystems.com> wrote:

> >mainly the alsa guys who wrote the driver and know, how they access
> >the bus system and the hardware, have to tell the pcmcia guys, who
> >know, what's going on in the bus ... i CC'd this mail to the thomas
> >charbonnel, paul davis and winfried ritsch, who wrote or maintain
> >this driver and the alsa-devel list ...
> >i doubt that i'm able to understand either the cardbus or the alsa
> >side of the driver in a reasonable time ... 
> 
> there is no "cardbus side" of the driver.
> a cardbus device appears to an ALSA driver (and i suspect to the
> kernel as well) as a completely regular PCI device. unless you go
> "fishing" for evidence, there is no way to tell that the device is not
> a regular PCI device.
> 
> there is nothing in the ALSA driver for the HDSP that is conditional
> on the h/w being a cardbus device or not, because we don't (and likely
> can't) know that it is.
i think the pcmcia guys need to know, how you access the hardware no
matter if it's a cardbus or a pci device ... but they have no idea, what
the driver is actually doing, so if it's their problem or not...

quote from russell king:
> As I say, what needs to happen is that the driver author needs to
> work out what is happening from his drivers point of view, and from
> the hardware point of view.
> 
> Once we know that, we can start looking at whether it is related to
> the cardbus bridge or not.
> 
> Until then, as far as I'm concerned, it's an unknown driver operating
> using unknown methods doing something unknown.  That's far too many
> unknowns to even start to guess at the cause.
quote end.

i hope you can help us with that. 


> sorry. FWIW, i have an ENE 1411 and it works OK with my hdsp at period
> sizes below a certain threshold. i don't know if its the same problem
> or not.
if it's working on certain settings, it's definitely not the problem
ico, timothy and i are experiencing ... in the last 3 monthes i tried
nearly every combination of settings ... at least ico's and my problem
is very well documented by us, but since we have no idea of what the
driver is actually doing, we can't do anything more ... except buy a new
laptop. but at least i would be quite happy if we can track this problem
down ...
and it HAS do be a software issue, since at least on ico's and my
machine, the hdsp works flawless with winxp ... 
the problem you have, is that a linux only problem or do you experience
the same problems with windows?

thanks a lot...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
