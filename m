From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Marian Marc-8 MIDI sound card (aka SKE'D)
Date: Sun, 23 Mar 2003 22:51:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030323215157.GB1869@tuba.home>
References: <20030323074019.49704.qmail@web21508.mail.yahoo.com> <1048431930.3e7dcd3a9b7d0@webmail.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1048431930.3e7dcd3a9b7d0@webmail.kuleuven.ac.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: PIETER PALMERS <pieter.palmers@student.kuleuven.ac.be>
Cc: tsw@johana.com, Tom Watson <sdc695@yahoo.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 23, 2003 at 04:05:30PM +0100, PIETER PALMERS wrote:
> The best starting point is gathering info. Without good info, developement isn't
> easy. But you seem to be lucky, because I found the following on the website of
> Marian (www.marian.de):
> "Developers of drivers can obtain all information on the hardware architecture
> of our cards, which is necessary for developing drivers for such operating
> systems that are not supplied."
>  
> I'd say getting this info is the first step.
> 
> Next I'd recommend you to read the "Writing an alsa driver" document by Takashi
> Iwai. It can be found on the ASLA website. You could try and find an existing
> ALSA driver of a card that resembles your cards architecure. Might be usefull
> when reading the tutorial. After finishing the tutorial, you'll know what to do.
> 
> btw: are you sure the card doesn't support DMA? The PLX 9052 supports DMA, and I
> can't imagine Marian not using it.

Doesn't use DMA?! Maybe this card runs in the same way like the rme cards
(rme32, rme96, rme9652, hdsp): In this case you copy data from/to the card and
set a startbit on the register. After that you get an interrupt. You can
read that details in the RME Digi96 document, which you can found on
ftp.alsa-project.org. Those cards were alsa using a Xilinx FPGA and I think
that they are in some way related to your Marian/Sek'd. (BTW: RME Digi32 was
also sold by Sek'd!). I don't know the details about the pdplus driver, but
maybe it's also interesting for you, because it can be related in some manner.

The first step of writing a driver should be the pci detection without any
driver functionality (study that manual "Writing an alsa driver" therefore
or look at other pci driver code). And if you can modprobe/rmmod an empty 
module you can start implementing some functionality to it.


martin


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
