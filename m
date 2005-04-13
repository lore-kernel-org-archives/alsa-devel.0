From: Tim Phipps <tim@phipps-hutton.freeserve.co.uk>
Subject: dxs_support=1 works on an Insight P4-ITX board
Date: Wed, 13 Apr 2005 16:45:22 +0100
Message-ID: <200504131645.22926.tim@phipps-hutton.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Good afternoon,
	I'd like to report that the snd-via82xx driver works nicely with 
dxs_support=1.  I've had 4 lots of music playing at once (44100:16:2, ALSA) 
and it sounds like jazz.

I hope this is the correct place to report this, it would be nice if the 
kernel message gave an email address. "lspci -nv" reports this:

0000:00:11.5 0401: 1106:3059 (rev 50)
        Subsystem: 1106:c001
        Flags: medium devsel, IRQ 22
        I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2

Hope this helps,
Tim.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
