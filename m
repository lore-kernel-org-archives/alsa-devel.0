From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: rme pcmcia woes
Date: Fri, 9 Sep 2005 21:36:36 +0200
Message-ID: <20050909193636.GB3998@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I just bought a second rme hdsp pcmcia card. They changed their design
to allow for normal firewire plugs on both ends different to the flat
custom plug in older cards (mine is about 4 years old). Unfortunately
the firmware refuses to load. I have two multifaces to test and both
work with my old pcmcia card (and with the pci cards) but don't work
with the new card. The card registers o.k. with the new card. The
output of hdsploader looks exactly the same if the firewire cable is
plugged or altogether unplugged (of course I tested with 4 different
cables of different lengths with no luck).

Here is the console output of the failure:

grisey:/home/orm# hdsploader
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : Intel 82801DB-ICH4 at 0xc0000c00, irq 11
Card 1 : RME Hammerfall DSP at 0x20800000, irq 11
Upload firmware for card hw:1
Hwdep ioctl error on card hw:1 : Input/output error.
grisey:/home/orm#

lspci shows this:

0000:03:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP (rev 32)

My question: Does anybody have a working pcmcia card of the new design
and -if so- which revision is it?

Thanx,
Orm


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
