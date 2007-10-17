From: Peter Skensved <peter@jay.phy.queensu.ca>
Subject: Re: 1.0.15rc3 patch_analog.s bug + fix
Date: Wed, 17 Oct 2007 10:55:46 -0400
Message-ID: <20071017145546.GA23576@jay.phy.queensu.ca>
References: <20071015025303.GA17664@jay.phy.queensu.ca>
	<s5hsl4c62fl.wl%tiwai@suse.de>
	<20071015203421.GA6047@jay.phy.queensu.ca>
	<s5hk5pn47d1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jay.phy.queensu.ca (jay.phy.QueensU.CA [130.15.24.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F39524339
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 16:55:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk5pn47d1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 16, 2007 at 01:38:34PM +0200, Takashi Iwai wrote:
> At Mon, 15 Oct 2007 16:34:21 -0400,
> Peter Skensved wrote:
> > 
> > On Mon, Oct 15, 2007 at 01:29:50PM +0200, Takashi Iwai wrote:
> > > At Sun, 14 Oct 2007 22:53:03 -0400,
> > > Peter Skensved wrote:
> > > > 
> > > >      Hi,
> > > >   I've come across a problem with the 1.0.15rc3 alsa driver on my Lenovo 3000 N100 laptop using
> > > > the auto mute feature - it appears to work backwards !  Plugging in the headphones unmutes the
> > > > external speakers and unplugging the heaphones mutes them ...
> > > > 
> > > >   Changing the if statement in line ~600 in patch_analog.c in ad1986a_update_hp to
> > > > 
> > > >     if (!spec->jack_preset)
> > > > 
> > > > makes it work the intended way.  ( spec->jack_present changes state  _before_ the call to
> > > > ad1986a_hp_automute )
> > > 
> > > Hmm, the code logic looks correct to me.  If HP jack is present, the
> > > internal speaker should be muted.  Otherwise it follows the state of
> > > HP jack (muted/unmuted, that acts as a master switch).
> > > 
> > 
> >    Well - in the default mode the jack is present and the internal speakers are permanently
> > muted until I plug in a set of headphones no matter how I toggle the speaker mute in the mixer.
> > 
> >   With headphones plugged in I can mute and unmute the internal speakers in alsa mixer
> > 
> > 
> >   Surely the default cannot be that I have to carry a set of headphones with my
> > laptop all the time ???!!???
> > 
> > 
> > > Is jack_present set/reset correctly when HP jack is plugged/unplugged
> > > at all?  Or, the pin NID is swapped, or any other reason?
> > > 
> > 
> >   I sprinkled some printk's in the driver :
> >  On entry to ad1986a_update_hp :     plugging headphones into jack : spec->jack_present = 0
> >                                      removing headphones from jack : spec->jack_present = 1
> 
> This implies rather that the jack detection itself is reversed from
> the standard.  Could you try the patch below?
> 
> 
> thanks,
> 
> Takashi
> 


   It works -
                          peter
