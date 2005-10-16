From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Writing a driver: what do I do next?
Date: Sun, 16 Oct 2005 16:53:05 +0100
Message-ID: <1129477985.3290.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I am writing a driver for the Sega Dreamcast (see
http://newgolddream.dydndns.info/repos for the code). Some years ago I
wrote the OSS/Free driver for this on 2.4 kernels but now (obviously)
want to write a driver for ALSA and also using DMA (the OSS one used
polling and took a big hit on high bitrate sounds as you might expect).

The DMA code on the DC is a bit messy (ie it doesn't work) but I think
it is fixible. But I don't really understand what I need to do to join
all the bit together in ALSA. Under OSS it was simple - fed in the
sample 'by hand' and it got played.

The complication with the DMA is that the sound card is on a different
bus and so I think I need to use the DMA to take samples fed into the
main (SH4) bus and send them over to the buffer on the ARM7 bus of the
sound chip.

So what should I do? Create a buffer in the SH4 bus space and have the
data feed into that? Which call handles the reading in of data from
userspace? (ie is there a simple way that userland can write data and I
can then get hold of that and start the DMA transfer?)

Sorry if this is not too clear - to be honest I am finding it quite
difficult to see the wood for the trees with ALSA.





-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
