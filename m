From: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Subject: periods,packets and driver patterns not to mention patience!!!
Date: Fri, 9 Apr 2004 16:13:57 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040409151357.81599.qmail@web25109.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

 Hi All,
   i'm using an open source VoIP application with the
alsa driver. My card is the onboard intel8x0.
   My problem is figuring out the patterns I am
getting with the alsa driver when transmitting
packets.

For instance when I use the GSM codec with a packets
size of 80 msecs and 132 bytes, packets are
transmitted at alternate intervals of 64/96 msecs.

When I configure the codec so the packet size is 128
bytes(power-of-two) and still 80 msecs, packets are
still transmitted at 64/96 msecs.

Now when i configure the codec so packet size is 132
bytes and 64 msces, packets are transmitted every 64
msces.
Given that the alsa driv interrupts at period
boundaries(which are defined in bytes), the tests i
have carried out prove otherwise..i.e that the driver
operates in millisecond power-of-two based periods.
??
Help appreciated,

Brian.


	
	
		
____________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
