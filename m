From: John Shillinglaw <ianchas@sc.rr.com>
Subject: Re: Roland SCP-55 Soundcanvas ALSA Driver
Date: Thu, 09 Mar 2006 01:29:08 -0500
Message-ID: <1141885748.7625.21.camel@Pippin.home>
References: <1141197867.923.8.camel@Pippin.home>
	 <s5h3bhtrw2m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3bhtrw2m.wl%tiwai@suse.de>
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

I'm just getting started on this driver. I started by modeling my
driver's functions from the vxpocket and pdaudiocf drivers, and need to
update the source published on the internet. I'm focusing on the mpu401
part first.

Anyway, the mpu part has the standard io port of 330, and has an
hardware buffer.

The audio apparently has an io port of 201. It's specs are 2 channels of
digital in/out audio at 44.1 mhz. Each channel is independently settable
at 44.1, 22.05, and 11.025. I'm not sure about any other details about
the audio portion of the card.

The soundcanvas's synth responds to midi messages sent from the
computer, and I think also from the midi in port. Overall card settings
such as master volume, pan, etc can be set by sending midi messages to
the card.

And so, getting the midi part of alsa working is the most important part
of the driver.

On Wed, 2006-03-08 at 12:54 +0100, Takashi Iwai wrote:
> At Wed, 01 Mar 2006 02:24:26 -0500,
> John Shillinglaw wrote:
> > 
> > Hello, 
> > 
> > Some time ago, I posted a request about help developing a driver for
> > Roland's SCP-55 Soundcanvas pcmcia card which has 2 digital audio in/out
> > channels, MPU-401 compatible MIDI in/out, and a wave table synth module.
> > 
> > I've made some progress and have created a webpage to document my work:
> > http://linuxtech.netfirms.com
> 
> Hmm, scp55.c and scp55.h from the web look strange...
> Do you have any information about the audio stuff of this card?




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
