From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: Re: aplay/arecord hang at 44100 Hz
Date: Wed, 12 Feb 2003 13:18:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4A3B8C.7080808@uni-bonn.de>
References: <3E476DD8.7050907@uni-bonn.de>	<s5hu1fbcfyb.wl@alsa2.suse.de>	<3E49291E.7000307@uni-bonn.de>	<s5hel6eoilm.wl@alsa2.suse.de>	<3E4A140A.7050300@uni-bonn.de> <s5hr8adn2j2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr8adn2j2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

I had to apply the diff by hand, because patch rejected it:

josh@spleen:~/programs/debian/alsa-lib-0.9.0rc7$ patch -p1 < 
rate-multi-fix.dif
patching file src/pcm/pcm_params.c
Hunk #1 FAILED at 966.


But guess what? Your patch works! aplay and arecord both work perfectly now!

That was fast work!

-josh





Takashi Iwai wrote:
> Hi Josh,
> 
> the debug trace really helps debugging.
> could you try the attached patch?
> 
> 
> thanks,
> 
> Takashi

-- 
"When you wake up in the morning, Pooh," said Piglet at last,
"what's the first thing you say to yourself?"

"What's for breakfast?" said Pooh.  "What do you say, Piglet?"

"I say, 'I wonder what's going to happen exciting today?'" said Piglet.

Pooh nodded thoughtfully.  "It's the same thing," he said.

	-- A.A. Milne

-----------------------------------------------------
http://www.nyfairuse.org/

WTO + WIPO = DMCA http://www.anti-dmca.org

Innovation vs Patent Inflation http://swpat.ffii.org/

120000 voices and 400 Firms against logic patents
http://www.noepatents.org/
-----------------------------------------------------




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
