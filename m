From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: intel8x0 sequencer & MTP-AV
Date: 03 Feb 2003 22:59:55 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044273602.2013.6.camel@littlewolf2.littlewolf>
References: <1044258789.30428.61.camel@littlewolf2.littlewolf>
	<s5h3cn5ino4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cn5ino4.wl@alsa2.suse.de>
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

Hi Takashi, 

I'll try that for intel8x0, the BIOS has a setting to turn on MPU-401,
and assign address either 300 or 330 so it should work. I'll try it
shortly. 

As for MTP-AV is there a piece of hardware that I can get that's not too
expensive to analyse the data stream.. or maybe some kind of software
interpreter under WinXp so I can help further. TO replace the MTP with a
Midiman device would cost around $1200aud.. so I'd rather buy something
that may get help get it working.

I can confirm to ALSA-DEV list that intel8x0 chip works for SiS 645DX
chipset motherboard for audio and will confirm all MIDI functionality
within the week. 

cheers

Allan Klinbail 





On Mon, 2003-02-03 at 22:55, Takashi Iwai wrote:
> Hi Allan,
> 
> At 03 Feb 2003 18:53:03 +1100,
> Allan Klinbail wrote:
> > 
> > Hi takashi, 
> > 
> > Long time no see. 
> > 
> > I've still got my MTP-AV and am still keen to get it working under
> > linux, so if there is anyway I can help development through testing
> > e.t.c.. let me know. 
>  
> thanks.  MTP still doesn't show their attitude for linux audio scene,
> so the reverse engineering is the only way.  the hardware tests would
> be really apperciated, although, so far, i have no plan until someone
> requests bug-fixes or new features.
> 
> > Also, I ahve a motherboard with a 645DX chipset. The intel8x0 module
> > works fine for audio but I can't seem to get the MIDI port active.
> > 
> > I ahve emailed both alsa-dev and alsa-user with no response. I also
> > searched the archives for any reports of this. 
> > 
> > Below is my modules.conf configuration for this module.. I'm sure the
> > problem lies here. 
> > 
> >  # ALSA portion -SiS onboard sound card
> > alias char-major-116 snd
> > alias snd-card-0 snd-intel8x0
> > options snd-intel8x0 mpu_port="1" ac97_clock="0"
> 
> try mpu_port=0x330 instead.  the valid value is either 0x330 or
> 0x300.
> 
> but i'm not sure whether the midi i/o works on your chipset.
> it's not supported on every intel8x0 chip, and as far as i've tested,
> it works only partially, either midi out or midi in.
> if you have another choice (even a cheap soundcard), it would be
> a better option...
> 
> 
> ciao,
> 
> Takashi




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
