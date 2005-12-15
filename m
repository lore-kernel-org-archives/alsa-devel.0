From: Paulo Marcel Coelho Aragao <pmcaragao-ag@yahoo.com>
Subject: Re: Tips on debugging ALSA driver snd_es18xx
Date: Thu, 15 Dec 2005 17:42:29 -0200
Message-ID: <20051215194229.GE5793@cortazar>
References: <20051215013411.GK7983@cortazar> <1134635237.43a128e5e75fa@webmail.uni-halle.de> <20051215111213.GA3636@cortazar> <1134660339.43a18af3d7aa4@webmail.uni-halle.de> <20051215165203.GC5793@cortazar> <s5hvexqz28y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvexqz28y.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote on Dec, 15:

[...]

> > > Please add this to your ~/.asoundrc:
> > > 
> > > pcm.u8 {
> > > 	type plug
> > > 	slave.pcm {
> > > 		type linear
> > > 		slave {
> > > 			pcm "hw:0"
> > > 			format U8
> > > 		}
> > > 	}
> > > }

[...]

> This configuration forces to use 8bit-unsigned format.  If any other
> formats are given, it's converted to u8 automatically.

This means that the driver processes the data in 8bit-unsigned chunks ?

> > > and try to play some 16-bit file to the ALSA device named "u8" instead 
> > > of the
> > > default one.  If this works, there is a bug in the driver in relation with
> > > 16-bit data.

> > Fantastic, Clemens ! You hit the bull's eye. Now the scenario is:
> > 
> > 1) aplay -Du8 produces sound from 8 or 16-bit data (the same I used before) on 
> >    both speakers

> I guess you're using a mono wav file?

I don't know how to inspect it. Could you give me a hint ? It's 
/usr/share/sounds/alsa/Front_Right.wav from Debian package alsa-utils.

> > 2) xmms and gxine produce sound only on the left speaker. I've attached a file 
> >    with the few config parameters which are explicitly set for gxine (the rest 
> >    is commented out, therefore, default). xmms saves every single parameter, 
> >    so I'm just sending the ALSA stanza.  My eye didn't catch anything that 
> >    might be related to usage of left/right speakers. Just in case, I'm also 
> >    attaching my mixer settings.

> This implies that u8-stereo doesn't work.

Should it work ?

> > 3) speaker-test -Du8 produces what I suppose is pink noise on both speakers, 
> >    but I noticed that its output included only "0 - Front Left"

> It means u8-mono works as expected, at least.

[...]

> > If this is indeed a bug in the driver, should I file a bug in ALSA BTS ?

> As you like.  We can continue the debug session on alsa-devel ML, too.

As long as we get to the bottom of this and squash this bug, the context 
doesn't matter to me. So, grasshopper Paulo asks Masters Takashi and Clemens: 
what's the next step ? I guess the goal is making 16-bit work, right ?

Thanks a lot, Takashi, for spending your time on this
Paulo


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
