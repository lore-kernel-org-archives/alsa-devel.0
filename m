From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Re: [RFC] merging splited driver back
Date: Thu, 22 Aug 2002 15:41:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2r8gr6mf6.fsf@vador.mandrakesoft.com>
References: <s5hr8gtsw70.wl@alsa2.suse.de>
	<Pine.LNX.4.33.0208202012410.12251-100000@pnote.perex-int.cz>
	<s5h7kijt3z9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kijt3z9.wl@alsa2.suse.de> (Takashi Iwai's message of "Thu,
 22 Aug 2002 15:31:06 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > I don't like very much to merging of ENS1370 and ENS1371, because
> > different codecs are used (snd-ak4531-codec and snd-ac97-codec).
>
> ah, yes, that's not beautiful to have two codec modules for one
> driver.
>
>> Sure, 
>> there is common code (MIDI UART, most of PCM routines), but I think that 
>> the final difference (separate module with common code) will be 
>> negligible, but we may do it.
>
> well, then let's leave ens1370/1 as they are.

this would have enbling to reduce memory usage if one have both 1370
and 1371 cards, and/or reduce kernel package size :-)

> > VIA code may be merged.
>
> yes.  i'll work on this later.

nice.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
