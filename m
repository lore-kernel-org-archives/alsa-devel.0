From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: amixer issues
Date: Tue, 04 Apr 2006 19:07:39 +0100
Message-ID: <1144174060.9472.10.camel@localhost.localdomain>
References: <1143907666.9228.31.camel@localhost.localdomain>
	 <20060404161719.GB18884@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 68A9221C
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 20:07:48 +0200 (MEST)
In-Reply-To: <20060404161719.GB18884@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-04 at 18:17 +0200, Clemens Ladisch wrote:
> Adrian McMenamin wrote:
> > I have a working sound card with a working (if basic) PCM mixer:
> > 
> > /proc/asound # cat cards
> > 0 [AICA           ]: snd_card_aica - AICA
> >                      Yamaha AICA Super Intelligent Sound Processor for SEGA Dreamcast
> > 
> > but when I try to use amixer nothing seems to work:
> > 
> > / # amixer -c 0
> > Invalid card number.
> > Usage: amixer <options> command
> 
> Does /dev/snd/controlC0 exist, and does it point to the control device
> listed in /proc/asound/devices?
> 
> 


/ # ls -l /dev/snd
crw-rw-rw-    1 root     sys      116,   0 Apr  4 19:13 controlC0
crw-rw-rw-    1 root     sys      116,  16 Apr  4 19:13 pcmC0D0p
crw-rw-rw-    1 root     sys      116,  33 Apr  4 19:13 timer



/ # cat /proc/asound/devices
 16: [0- 0]: digital audio playback
  0: [0- 0]: ctl
 33:       : timer


Does that mean they agree? Looks like it to me, but I'm not *absolutely*
sure what I am looking for.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
