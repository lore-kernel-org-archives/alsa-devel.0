From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: sequencer queue PCM timing
Date: Thu, 13 May 2004 19:34:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405131934.26656.cannam@all-day-breakfast.com>
References: <200405131416.54774.cannam@all-day-breakfast.com> <Pine.LNX.4.58.0405132009120.1834@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0405132009120.1834@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 13 May 2004 7:12 pm, Jaroslav Kysela wrote:
> Maybe, lost interrupts can cause this. Actually, there is no
> correction in the PCM slave timer code for this situation.

Looking over the figures again, it looks like (for the test case 
forwarded to me) the sequencer queue is actually consistently 
reporting more frames than JACK.  Does that mean JACK might be 
losing, or can the sequencer queue ever gain?

For what it's worth (very little I imagine) both the sequencer queue 
and the JACK frame count are slightly behind the elapsed time 
reported by gettimeofday.

> Can this
> problem be reproduced using a bigger period size for the JACK
> daemon?

I'm not quite sure what you mean.  Do you mean if I were to run JACK 
with a bigger period size, on my machine where this problem hasn't 
occurred before, it might cause something to start dropping 
interrupts?  Why?  I'm happy to give it a go, but I don't understand.


Chris



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
