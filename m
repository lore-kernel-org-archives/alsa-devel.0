From: PIETER PALMERS <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: Marian Marc-8 MIDI sound card (aka SKE'D)
Date: Sun, 23 Mar 2003 16:05:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048431930.3e7dcd3a9b7d0@webmail.kuleuven.ac.be>
References: <20030323074019.49704.qmail@web21508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030323074019.49704.qmail@web21508.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com, Tom Watson <sdc695@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The best starting point is gathering info. Without good info, developement isn't
easy. But you seem to be lucky, because I found the following on the website of
Marian (www.marian.de):
"Developers of drivers can obtain all information on the hardware architecture
of our cards, which is necessary for developing drivers for such operating
systems that are not supplied."
 
I'd say getting this info is the first step.

Next I'd recommend you to read the "Writing an alsa driver" document by Takashi
Iwai. It can be found on the ASLA website. You could try and find an existing
ALSA driver of a card that resembles your cards architecure. Might be usefull
when reading the tutorial. After finishing the tutorial, you'll know what to do.

btw: are you sure the card doesn't support DMA? The PLX 9052 supports DMA, and I
can't imagine Marian not using it.


Pieter



Quoting Tom Watson <sdc695@yahoo.com>:

> I'd like to get a driver working for this card, but "where to start" is
> always a sticking point.



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
