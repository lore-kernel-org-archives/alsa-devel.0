From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsasound init script (Re: possible problems
	with	rc6 aplay )
Date: 17 Dec 2002 11:36:10 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1040153770.5622.86.camel@cmn37.Stanford.EDU>
References: <E18O7m1-0002AU-00@sc8-sf-list1.sourceforge.net>
	<1040096816.3766.16.camel@Godzilla>  <s5hpts0sy4k.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpts0sy4k.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Knecht <markknecht@attbi.com>, Paul Davis <paul@linuxaudiosystems.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2002-12-17 at 03:06, Takashi Iwai wrote:
> At 16 Dec 2002 19:46:55 -0800,
> Mark Knecht wrote:
> > On Mon, 2002-12-16 at 18:51, Paul Davis wrote:
> > > i think it would something like this:
> > > 
> > > options snd-hdsp snd_index=0
> > > options snd-usb-foo snd_index=1
> > > 
> > > i'm sure that takashi or jaroslav will correct me if i got this wrong.
> > 
> >    This makes perfect sense, and it isn't what I did. (!!)
> > 
> >    The PlanetCCRMA has a Nano-HOWTO on how to install the MidiMan 2X2 by
> > hand. It's a little USB-based MIDI interface (not a sound card) that is
> > not recognized by alsaconf, so we do a bit of editing by hand.
> 
> the behavior depends on the order of booting.
> if the hotplug service is booted before the alsasound init script,
> hotplug will start the snd-usbaudio module, which will be assigned as
> the first empty device, i.e. device #0, unless you specify the index
> option.  and afterwards, the alsasound script is started, and it
> results in the confliction of devices.
> 
> setting an index option is one of the solutions.
> in this case, the first usb-audio/midi device will be forced to be
> assigned to #1.  so, it's safe to start it beforehand.
> 
> but, when we take a deeper look at this, we find another problem.
> the alsasound init script checks whether the ALSA was already started
> by checking the existence of /proc/asound directory.  and, if hotplug
> started the usb-audio/midi before alsasound, this directory would be
> also created because the alsa core was started without help of
> alsasound init script, too.  this leads to the skip of loading of any
> other soundcards, because alsasound will quit immediately.
> 
> after all, a simple solution for this is to make sure that alsasound
> starts before hotplug.  then, even the index option for snd-usbaudio
> wouldn't be necessary (in theory).

I think that in RedHat hotplug is not started as a service so we cannot
make sure that alsasound starts first (at least not easily - I have to
check again on the startup scripts to see what is done and when). 

It would be better to make the alsasound script more robust (and
independent of the startup order) and able to deal with partially loaded
modules, so instead of just checking for the /proc/asound directory it
would actually see what modules are already loaded and only load those
that are not. It does not look too easy, it seems that /proc/asound does
not provide a list of loaded modules (rather a list of cards that are
not associated with module names). 

> in the above scenario, anyway, cards_limit must be changed.  and i
> think it's a bit annoying.
> 
> the attached patch will change the handling of cards_limit option.
> with the patch, the alsa won't restrict the number of cards per
> cards_limit option, but only limits the auto-probing via kmod.
> i.e. you can load more card modules even with cards_limit=1.

That sounds reasonable. 
-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
