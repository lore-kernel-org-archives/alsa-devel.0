From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Re: rme96 and mmap, bug?
Date: Fri, 29 Nov 2002 09:36:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211290936.53333.torger@ludd.luth.se>
References: <200211271913.43032.torger@ludd.luth.se> <0ClXrX057A140000.gml@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <0ClXrX057A140000.gml@xs4all.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: vanDongen-Gilcher <gml@xs4all.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 29 November 2002 00.05, vanDongen-Gilcher wrote:
> Out of curiosity,
>
> What makes a card support mmap directly in general? And what would be
> missing?

I'm sure I'll get corrected if I say something wrong here:

If the card itself can transfer its samples from its onboard buffer into 
computer RAM, without CPU involvement (this is called DMA, direct 
memory access). Then one memory maps that memory, and the program can 
process samples directly in that memory area.

For RME96 which has no DMA functionality, the CPU must also copy to/from 
the card's onboard buffer into RAM, and thus there is an extra memory 
copy, and the gain from having memory mapped I/O in terms of reduced 
amount of memory copies disappears (depending on how the driver is 
designed).

There is also some user-space/kernel-space stuff concerning this, but if 
I'm not mistaken, it is not relevant for this discussion.

/Anders Torger


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
