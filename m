From: Lee Revell <rlrevell@joe-job.com>
Subject: TODO-1.1
Date: Fri, 04 Mar 2005 16:02:54 -0500
Message-ID: <1109970174.6710.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

I just noticed the TODO-1.1 file in ALSA CVS, and it seems like a lot of
it is done.

>   - [ti] software volume control on alsa-lib (for c-media chips)
> 

This one is done...

> Emu10k1:
> ========
>   - [ti] mixer redesign - Peter's patch for audigy looks better,
>        a bit clean up is needed.

Would anyone care to elaborate on this one?  Personally I don't think a
mixer redesign is needed.  Applying Mikael's patch would put the SBLive
and Audigy mixer in a good state.  Splitting the view to "Playback" and
"Capture" made the emu10k1 mixer a lot more comprehensible.  Finally,
the multichannel patch lets JACK users bypass the mixer completely.

>   - ld10k1 development?

I propose this be added to alsa-tools.  Although Peter will not be
maintaining it anymore, others have volunteered, and it's quite useful.

>   - [ti] ALSA-native sfxload

Is there any reason asfxload can't be added to alsa-tools too?

Lee




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
