From: mark@undertone.org
Subject: Re: Extigy testing
Date: Mon, 25 Nov 2002 08:37:50 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021125133750.GA32741@undertone.org>
References: <20021014192959.GA6792@undertone.org> <20021014193407.GA6821@undertone.org> <s5h8z106km8.wl@alsa2.suse.de> <20021015175750.GA8918@undertone.org> <s5hof9u666f.wl@alsa2.suse.de> <20021016194055.GA11982@undertone.org> <s5h8z0x5v3r.wl@alsa2.suse.de> <20021017134235.GA14241@undertone.org> <20021017144440.GA14352@undertone.org> <s5hu1jl3se4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hu1jl3se4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

After having been pretty busy at work the past few weeks, this morning
I decided to give this testing another shot. Last time I had been able
to dicern or notice any change at all when most of the switches were
fliped... this time amixer/alsamixer simply seg faults. On console the
kernel just gives me a "divide error: 0000". If I attempt to tempt
fate a second time, the machine crashes with a polite hang and no
messages.

There is a ton of info I could fiesably provide, although I'm not sure
what good it would do. If there is something specific you need or
would like, just say. As a reminder, I am running alsa with two
soundcards; an onboard cs4281 and the extigy. Running amixer/alsamixer
against the cs4281 works perfectly fine.

-Mark

On Thu, Oct 17, 2002 at 07:08:19PM +0200, Takashi Iwai wrote:
> At Thu, 17 Oct 2002 09:44:40 -0500,
> mark@undertone.org wrote:
> > 
> > In a bit of good news, although playing back streams dont really want
> > to work, if I use the line in on the card and shove in the output from
> > my onboard sound card, I actually get sound of the card now while it
> > is connected via usb to the laptop. Earlier, the only way to get sound
> > of the card while booted into linux was to disconnect it completely
> > and use it as a stand-alone device in the same manner. As a result, I
> > can test a couple of the mixer settings for you. I'm using alsamixer
> > for this, doing it by hand via amixer would take a while . . .
>  
> alsamixer is also fine.  it can do most of things what amixer can.
> 
> > The first 4 master controls control front,back, and center-woofer. Not
> > sure about the exchange with the last two, I only have a 4.1 sound
> > system hooked up into the device. "Master 1" is a general master that
> > controls all sound. Bass and treble follow... The PCM interface I
> > can't test, due to the same earlier problems. Line and Line 1 seem to
> > do the same thing for me at the moment. I would guess that "line" is
> > for the specific line in 1/8 jack im using in the front of the unit,
> > and that "line 1" is a general control for all input lines... it didnt
> > control the mic though. Only the "Mic" control controls the mic. 
>  
> if you build the module with --with-debug=detect option, there are
> kernel messages at loading module about which control corresponds to
> which usb mixer unit such like
> 
> 	[10] FU [PCM Playback] ch = 2, val = 0/10
> 
> the first number is the unit id and the second is the type of unit,
> and the third is the ALSA control name (i.e. the name of mixer
> element).
> when you compare these unit ids with the picture in usbmixer_maps.c,
> you'll get more clues.
> 
> it would be appreciated if it can be clarified, which inputs/outputs
> correspond to what, so on.
> 
> 
> > Now on to the "odd" stuff ... I cant test the digital in and outs.
> 
> i guess this is because the corresponding descriptors are not parsed.
> but digital out might be possible by some switches, e.g. "Digital Out"
> "Digital Out1", "Digital Out2", etc.
> 
> > I just don't have another optical audio device here. The "Speaker"
> > interface seems like a master mute button. All other interfaces, uh,
> > don't seem to do anything. If you can suggest better ways to test, I'm
> > all ears. I could do more extensive testing if you like, but uh hmm
> > not sure exactly how the logistics of that would work out in real
> > life, heh.
> 
> there are many unknown switches.  please take a look at
> usbmixer_maps.c.
> 
> 
> Takashi


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
