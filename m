From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: au88x0 - arecord, aoss
Date: Wed, 30 Mar 2005 10:07:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0503301006160.1757@pnote.perex-int.cz>
References: <424988D4.2070805@netvigator.com> <1112170290.3207.15.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1112170290.3207.15.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: Raymond <rayau@netvigator.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Mar 2005, Manuel Jander wrote:

> Yes, you just get the same stuff recorded from different PCM's. In
> theory, if ALSA would support it, we could record from the codec, and
> other sources  like SPDIF, serial interfaces, etc. at the same time, but
> ALSA currently lacks a generic mechanism to route individual PCM's, I
> mean, some how to tell the PCM, "use that specific source".
> By the way, the same applies for playback, with different audio outputs,
> where we currently just use different PCM's, in order to implicitly tell
> ALSA what audio output we want.

It's not true. Look to /usr/share/alsa/cards configuration files.
The alsa-lib can setup some controls to set the wanted behaviour.

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
