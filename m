From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: fix efx_voices_mask setting for
	SBLive
Date: Tue, 01 Mar 2005 17:10:36 -0500
Message-ID: <1109715036.17405.24.camel@mindpipe>
References: <1109463592.1814.12.camel@krustophenia.net>
	 <1109464199.1814.23.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1109464199.1814.23.camel@krustophenia.net>
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
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-02-26 at 19:29 -0500, Lee Revell wrote:
> On Sat, 2005-02-26 at 19:19 -0500, Lee Revell wrote:
> > Also, the "EFX Voices Mask" control is renamed to "Captured FX8010
> > Outputs".  This is a trick to ensure the default mixer settings are
> > loaded when users upgrade from 1.0.8.  Otherwise, the upgrade process
> > will probably restore the old settings which results in the
> > "multichannel" capture device only having two channels.  I could not
> > think of a better way to get around this issue, and the alternative
> > seems to be a slew of bug reports.  Half the testers reported this to me
> > as a bug already.
> > 
> > Anyway, I think the new name is clearer anyway, because there's no
> > reason to tell userspace the hardware stores this value as a mask, and
> > "voices" is confusing because it implies some relation to the 64
> > wavetable/PCM voices.
> 
> Sorry, wrong patch.
> 

Please apply the second chunk of the patch ASAP, it's an important bug
fix.  The first part (renaming "EFX Voices Mask") is optional.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
