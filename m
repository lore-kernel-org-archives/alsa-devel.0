From: Tom Watson <sdc695@yahoo.com>
Subject: Marian Marc-8 MIDI sound card (aka SKE'D)
Date: Sat, 22 Mar 2003 23:40:19 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030323074019.49704.qmail@web21508.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I'd like to get a driver working for this card, but "where to start" is
always a sticking point.
The info I have so far on the card is pretty detailed:
1) Its a PCI card (duh!!)
2) It uses 4 AK4524 24 bit codecs (total of 8 channels)
3) The PCI Target chip is a PLX PCI 9052 (pretty common)
4) It has a Xylinx "glue" chip that make it all work.

Some "differences"
1) On the PCI interface it presents 4 regions:
  a) PLX registers
  b) I/O area where the samples are stored  32k 24 bit samples for
     each channel (seperate record/playback).  It has the RAM on the
     card for buffering.  NO DMA!!
  c) Control/Status for the FPGA (Xylinx) part
  d) Interface for loading the Xylinx part with its info (a supplied
     binary file, apparently propritery, but appears to be quite
     stable)
2) There are a pair of MIDI I/O ports that map into the region 'C'
   above.  MIDI is not my chief concern.
3) The card doesn't use DMA.  You get the audio samples into the
   memory on the card, and the driver takes it from there.
4) Lots of things are programmable.  The sample frequency is one that
   can vary from 6kHz to 115kHz (if you can hear that!!)
5) You can have LOTS of these cards in one system.  The card supports
   a master/slave logic that allows all of them to be sync'd
   together.  I have a friend that has 6 of them working under
   Windoze.  He really wants to "Go Linux!!", and I'd like to help!!

Unknowns:
Somehow this card generates interupts.  I really haven't figured it
out totally yet.

If you want some info, I can forward some (or post them).

Once things get started, I can do the debugging, but that "start" is
my most difficult thing.

Thanks.

=====
-- 
Tom Watson
tsw@johana.com

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
