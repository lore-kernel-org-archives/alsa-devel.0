From: Bill Gatliff <bgat@billgatliff.com>
Subject: Lots of noob questions on writing an ALSA driver for SM501
Date: Tue, 26 Jul 2005 09:16:46 -0500
Message-ID: <42E645CE.609@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Guys:


I'm attempting to write my first ALSA driver.  My objective is to get 
sounds to emerge through a UCB1400 connected to an SM501's AC97-link 
controller, and to receive sounds coming from the UCB1400's audio input(s).

I'm going over Takashi Iwai's "Writing an ALSA Driver" document, but 
there are a few things I just don't understand yet.  I'm hoping that 
someone here will be able to set me straight.

The SM501 has an AC97-Link controller, but nothing else related to audio 
as far as I can tell.  In my hardware the SM501 is memory-mapped, and is 
not a PCI device.  The host processor is an AT91RM9200 (ARM).

As far as I can tell, I need a "PCM Interface" driver to provide a PCM 
device file to userspace.  It also looks like I need an "AC97 Interface" 
driver to provide access to the UCB1400 during playback and recording.  
Is this right?

I'm hoping someone will set me straight here.  Thanks!!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

The true Southern watermelon is a boon apart, and not to be mentioned
with commoner things.  It is chief of the world's luxuries, king by
the grace of God over all the fruits of the earth.  When one has
tasted it, he knows what the angels eat.  It was not a Southern
watermelon that Eve took; we know it because she repented.
                -- Mark Twain, "Pudd'nhead Wilson's Calendar"



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
