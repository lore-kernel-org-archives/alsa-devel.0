From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: meaning of EMU10K1_MIDI vs. EMU10K1_SYNTH
Date: Fri, 25 Mar 2005 09:08:42 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503250907050.1791@pnote.perex-int.cz>
References: <1111690690.8268.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1111690690.8268.17.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 24 Mar 2005, Lee Revell wrote:

> I noticed that EMU10K1_MIDI (and voice->use->midi) is never used.  The
> wavetable synth uses EMU10K1_SYNTH / voice->use->synth.
> 
> Can I remove it?  I cannot see where you would want to make a
> distinction.  AFAICT it's needless bloat.

Well, the names might be misleading, but the difference should be:

1) voice allocated for MIDI (usually dynamic assignment)
2) voice allocated for wavetable synth (usually static assigment - 
   modplayers etc.)

I think, the later support is not implemented in emu10k1, but it is 
implemented for example in trident (where the midi support is mising).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
