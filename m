From: Burton Samograd <kruhft@kruhft.dyndns.org>
Subject: multichannel virutal devices
Date: Sun, 25 Aug 2002 10:50:33 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020825175033.GB3705@kruhft.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kruhft.dyndns.org (h24-68-68-53.vc.shawcable.net [24.68.68.53])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA11940
	for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2002 19:50:44 +0200
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I sent this to alsa-user a while ago and got no replies, so I figured
I'd try this list and see what I get:

----------------------------------------------------------------------

Hi all,

I've been wondering if something is possible using alsa and a bit of
.asoundrc trickery.  I have a delta 6/6 (ice1712) card, which has 10
channels that feed into the hardware mixer.  Now, what i'm wondering
is: can you create multiple virtual slave devices (i'm thinking using
plughw for format conversion) that will use the hardware mixer.  I was
thinking the aserver would do this, but i don't think that it would
use the hardware in that way and i couldn't get it to work anyways.

I guess i'm looking for a way to go:

<console1>
aplay -D ice1712a long_wave_file.wav
<console2>
aplay -D ice1712b another_long_wave_file.wav

where ice1712a uses channels 1 and 2, and ice1712b uses 3 and 4, and
so on.

After searching through the documentation, i came across the "share"
command, but i can't for the life of me figure out how to use it or
even if it allows you to do something like this...  Is this type of
configuration possible and if so, could someone post an example on how
this could be setup?

Thanks,

burton

----------------------------------------------------------------------


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
