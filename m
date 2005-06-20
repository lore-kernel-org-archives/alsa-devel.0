From: fab <fab@gnux.info>
Subject: Re: NULL pointer dereference
Date: Mon, 20 Jun 2005 23:49:31 +0200
Message-ID: <20050620214931.GA14357@blackmilk.localzone.fr>
References: <20050620123344.GA20286@blackmilk.localzone.fr> <s5hekaxos7e.wl%tiwai@suse.de> <s5hd5qgq3s9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hd5qgq3s9.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: fab <fab@gnux.info>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 20/06/05 20:30 +0200, Takashi Iwai wrote:
> At Mon, 20 Jun 2005 19:26:13 +0200,
> ?$B;d wrote:
> > 
> > At Mon, 20 Jun 2005 14:33:44 +0200,
> > fab wrote:
> > > 
> > > Hi,
> > > testing the latest cvs version to see if I can make the internal speaker
> > > working as in realtek's drivers (after having upgraded my kernel), I got it
> > > (and I get it as soon as I load the sound module):
> > 
> > Looks like the new code I added for auto-probing is buggy.
> > As a workaround, pass model=asus option unless it's fixed.
> 
> ... or try the patch below.

Ok, after having applied the patch everything is weired, it works even
worse than before :(
If I pass card=foo with "foo" being a quite old card type, I get less or
more the same effect as before (badly working).
With a new "foo" (z71v, asus, etc...) or no param at all, I get
something like:
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...

Then, If I run "alsamixer" It fails:
alsamixer: function snd_mixer_load failed: Invalid argument

and the kernel prints:
hda_codec: num_steps = 0 for NID=0x9

Hope this helps.
Fabien Devaux.

PS: it works like a charm in realtek's version, have you really applied
all the changes ? should I pass a specific model= argument ?



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
