From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: Re: [ANN] hdspmixer-1.1
Date: Wed, 30 Jul 2003 11:42:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030730094231.GB758@finnendahl.de>
References: <289844.1059532392410.JavaMail.java@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <289844.1059532392410.JavaMail.java@localhost>
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

frankgaetano@collegeclub.com am 29. Juli 2003 um 22:33:12 Uhr (-0400):

> Hello everyone, Does this mean that all of the software is now
> working with the newest version of the firmware for the HDSP?

Alsa drivers (including MIDI) and all the tools work on my machine:

Acer TravelMate 528TXV, kernel 2.4.22-pre8 (plain, no low-latency),
gcc3.2.3 with a RME PCMCIA and Multiface (both, revision 0x0a and
0x0b).

I didn't check with the PCI cards on my other machines yet. Upon
loading of the firmware occasionally the system freezes. This might be
my mistake (issuing hdsploader a second time for example freezes it,
or changing the Multiface and trying to reload the firmware with
installed module) or due to the unstable kernel. Apart from that
everything works very smoothly :-)

--
Orm


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
