From: Dan Aloni <da-x@colinux.org>
Subject: ALC658 rev 0 - a problem with Rear Right
Date: Sat, 5 Mar 2005 17:35:03 +0200
Message-ID: <20050305153503.GA10747@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hello,

Somewhere between 2.6.8 and 2.6.11 my alc658 (rev 0) card stopped 
outputing audio on the Rear Right speaker. Of course I checked the
cables and there's nothing wrong with the speaker.

I tried to play around with volume controls, but got nothing.

I test with 'speaker-test -Dplug:surround51 -c6 -s 4'.

I also tried to revert specific parts in sound/pci/ac97 and got 
nothing.

Assuming that I'm a capable kernel hacker, do you have any advice 
about how to debug this?

-- 
Dan Aloni
da-x@colinux.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
