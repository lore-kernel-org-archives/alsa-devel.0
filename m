From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: New driver for Opcode 64X Serial MIDI interfaces
Date: Fri, 25 Feb 2005 14:12:17 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502241352040.300-100000@studcom.urz.uni-halle.de>
References: <opsmo7etnqn0kn27@linux.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <opsmo7etnqn0kn27@linux.site>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Adair <adair@gotadsl.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bill Adair wrote:
> Do you want me to (a) provide a replacement file for
> serial-u16550.c, (b)  provide a version of serial-u16550.c with
> comment documentation in but no Opcode driver and a seperate
> Opcode driver file, or (c) provide just a comment documented
> Opcode driver and leave serial-u16650.c alone?

If the Opcode is similar enough to other serial devices (BTW: what are
the differences?), there's no reason to put it into a separate file.

Please submit one patch for each logically independent change.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
