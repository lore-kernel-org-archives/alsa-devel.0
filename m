From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Re: Alsa and the ice1724 chipset
Date: Sun, 07 Sep 2003 04:14:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2u17p4a64.fsf@vador.mandrakesoft.com>
References: <20030829214934.50139ef9.joel@highvoltagelinux.com>
	<s5hvfscodwr.wl@alsa2.suse.de>
	<20030901094356.7a79dd1f.joel@highvoltagelinux.com>
	<s5hptikoc0j.wl@alsa2.suse.de>
	<20030901100242.522b430d.joel@highvoltagelinux.com>
	<s5hisocoaow.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisocoaow.wl@alsa2.suse.de> (Takashi Iwai's message of "Mon,
 01 Sep 2003 16:17:03 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Joel Hill <joel@highvoltagelinux.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > > > > > I was wondering if you wrote this driver and if so why it
> > > > > > is that i can loud the modules no problems alsamixer can
> > > > > > change the dac's etc but i get no sound and xmms
> > > > > > alsaplayer and aplay all hang
> > > > > 
> > > > > what card is that?
> > > > > are you sure that no other apps block the pcm device?
> > > > > 
> > > > > it's working fine on terratec aureon and m-audio revolution
> > > > > boards.
> > > >
> > > > i have a m-audio revolution and i have a santa cruz cs46xx in
> > > > the machine with the revo card i can use the cs46xx based card
> > > > but the ice1724 just causes freezes lockups etc, only reason i
> > > > have both of them in here at the same time is because i need
> > > > sound while i fix this ice1724 issue. i can use alsamixer to
> > > > mix both cards with alsamixer -c 0 or -c 1, aplay hang's xmms
> > > > says 'sample format not available for playback: invalid
> > > > argument' mplayer see's the device but locks after it detects
> > > > the card, once again the santa cruz cs46xx based doesnt show
> > > > these problems at all so i dont understand.
> > > 
> > > ice1724 doesn't support 16bit format.
> > > try to use plughw instead of hw layer if you use ALSA native apps.
> > > 
> > > 
> > > Takashi
> > i just went into xmms for eg and defined the alsa output as
> > plughw:0,0 and it works but thats the cs46xx based card with
> > plughw:1,0 which is the ice1724 it just freezes like it did
> > before.
> 
> do you mean freeze as the kernel lock-up or the machine is still
> responsible?
> 
> > so i dont know if thats the issue then
> 
> again, did you check whether no other apps block the device?
> cs46xx can play multiple streams at the same time, while ice1724
> cannot.

regardince M-Audio buggy support, i got a strange bug report about
snd-ice1724 in alsa-drivers-0.9.6 on kernel 2.4.2x, see mdk bug #5084:
http://qa.mandrakesoft.com/show_bug.cgi?id=5084



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
