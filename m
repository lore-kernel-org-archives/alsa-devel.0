From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: Opensource MIDISport firmware: microscheduling
Date: Wed, 30 Apr 2003 00:00:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304300000.14958.plcl@telefonica.net>
References: <E19AKgN-0004k7-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19AKgN-0004k7-00@sc8-sf-list2.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>
Cc: alsa-devel@lists.sourceforge.net, Lars Doelle <lars.doelle@on-line.de>
List-Id: alsa-devel@alsa-project.org

On Tuesday 29 April 2003, Frank van de Pol wrote:
> The Midiman devices are using a Cypress EZUSB 2131 microcontroller for
> which an opensource firmware exists (by Lars Doelle,
> http://member.nifty.ne.jp/Breeze/softwares/unix/usbmidi-e.html).

There is a later version of this firmware as a CVS repository here: 
:pserver:anonymous@cvs.linux-hotplug.sourceforge.net:/cvsroot/linux-hotplug
(module name: firmware)

You can also browse this CVS repository online:
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/linux-hotplug/firmware/

There are two versions of the firmware: stable (directory named 'original')  
that you already know, and supports only up to Midisport2x2, and a 
development branch (directory 'unified') aimed to be compatible with the 
high-end EZUSB devices. Unfortunately, this project had no progress for the 
last 6 months AFAIK.

I have forwarded your message to Lars, hoping he could answer you. Sorry, but 
i only did contributed with a poor set of regression tests to this project, 
and i don't have a 4x4 or 8x8 to play, but i would be glad to help.

Anyway, I agree with you that a timestamped protocol between ALSA and these 
devices can be possible, and also very desirable. I've heard about Roland  
having something like this. 

Regards,
Pedro



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
