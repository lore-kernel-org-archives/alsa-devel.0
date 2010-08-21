From: "Demian Martin" <demianm_1@yahoo.com>
Subject: Problem with USB Class 2 Audio Driver
Date: Fri, 20 Aug 2010 17:40:22 -0700
Message-ID: <054801cb40c9$70349710$509dc530$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n19.bullet.mail.mud.yahoo.com (n19.bullet.mail.mud.yahoo.com
	[68.142.206.146]) by alsa0.perex.cz (Postfix) with SMTP id 599DC24366
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Aug 2010 02:41:45 +0200 (CEST)
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Daniel Mack' <daniel@caiaq.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel:

I'm testing an early sample of the Wavelength Wavelink, a USB to S/PDIF
adapter that supports 44.1-192 KHz sample rates and uses async usb to talk
to ALSA. It works and plays all of the sample rates correctly with the git
version of Alsa from 7/30/2010 whenthe files are sourced from the network.
However if I try to play from a usb source to the usb dac it doesn't work
and the whole system gets unstable.  The platforms I have tested it on seem
to have a single USB host interface but with USB 2 there should be enough
bandwidth to pass the data from a USB stick to the cpu and back. If I use an
older 96 only usb dac on the same system it works (unless the down
conversion isn't a direct divide, which overloads the CPU, but that is a
different issue). The problem seems to be sample rate independent and hits
the moment I try to access the file. This is using MPD as a player.

 

What additional info do you need to troubleshoot this? Is it an intrinsic
limitation to the interface? What additional tests should I do? It's
possible it's a hardware issue but how do I divide them so I can go back to
the hardware guy if it's his issue? 

 

Demian Martin

Product Design Services
