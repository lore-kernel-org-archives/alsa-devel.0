From: Donald M Burns <donald@sequel.demon.co.uk>
Subject: YMFPCI No midi record.
Date: Sun, 30 Mar 2003 19:24:15 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303302024.15366.donald@sequel.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi all,

I've just downloaded and installed ALSA 0.9.2 complete with OSS emulation.
I'm using an Addonics Sound Vision SV550 which is based on the Yamaha
YMF724F chip, and running Red Hat 7.3.

Whilest all is OK with the PCM and OPL3 bits the MIDI record function does not
work. This is the contents of /proc/asound/card0/midi0 while playing the 
synth's keyboard:-
MPU-401 (UART) 0-0

Output 0
  Tx bytes     : 201410
  Mode         : native
  Buffer size  : 4096
  Avail        : 4096
Input 0
  Rx bytes     : 0
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0

I had a similar problem with old OSS driver (ymfpci.c) and tracked it down to
the fact that only ISA interrupts for the midi were supported by the driver. 
This means that the driver is OK  for midi on motherboard mounted chips but
cannot work with PCI cards as there is no way to route an ISA interrupt across
the PCI bus. I came up with a simple patch which fixed it in the end.

I was wondering if we had the same problem with ALSA driver.

Any comments would be much appreciated.

Best Regards,

Donald.


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
