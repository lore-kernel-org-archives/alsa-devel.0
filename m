From: Mark Knecht <markknecht@attbi.com>
Subject: Re: alsasound init script (Re: possible
	problems	with	rc6 aplay )
Date: 18 Dec 2002 05:11:36 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1040217097.1370.7.camel@Godzilla>
References: <E18O7m1-0002AU-00@sc8-sf-list1.sourceforge.net>
	<1040096816.3766.16.camel@Godzilla> <s5hpts0sy4k.wl@alsa2.suse.de>
	<1040153770.5622.86.camel@cmn37.Stanford.EDU>
	<s5h1y4fwqne.wl@alsa2.suse.de>  <s5hznr3vanh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznr3vanh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Paul Davis <paul@linuxaudiosystems.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2002-12-18 at 03:17, Takashi Iwai wrote:
> At Wed, 18 Dec 2002 11:46:45 +0100,
> I wrote:
> > 
> > > It would be better to make the alsasound script more robust (and
> > > independent of the startup order) and able to deal with partially loaded
> > > modules, so instead of just checking for the /proc/asound directory it
> > > would actually see what modules are already loaded and only load those
> > > that are not. It does not look too easy, it seems that /proc/asound does
> > > not provide a list of loaded modules (rather a list of cards that are
> > > not associated with module names). 
> >  
> > agreed.  a scenario i can imagine now is that the script just takes a
> > look at /proc/asound/cards and checks the numbers at the first column.
> > this should correspond to the card indices which have been already
> > loaded.  then the script will try to load the modules snd-card-X but
> > skip the numbers listed in the above...
> > i'll try to rewrite as this way.
> 
> after reconsideration: it would be much simpler to create a new proc
> file which shows the modules already loaded.
> 
I was wondering what would happen in this process if someone had two r
three identical USB devices, like the MidiMan 2X2? OR also two identical
cards like the RME HDSP 9652?

It is important that the system recognize the same hardware as the same
sound device every time the machine booted, and whether the machine is
warm or cold booted. 

The name I'm seeing linked in /dev/sound are possibly a bit too generic,
being just '2X2' and 'DSP'.

Just a thought.




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
