From: Josh Green <josh@resonance.org>
Subject: Re: Intel Azalia problems (some progress)
Date: Fri, 15 Apr 2005 12:49:53 -0700
Message-ID: <1113594593.28862.18.camel@SillyPuddy.localdomain>
References: <1113394027.16526.3.camel@SillyPuddy.localdomain>
	 <s5hll7mg30n.wl@alsa2.suse.de>
	 <1113567180.7140.17.camel@SillyPuddy.localdomain>
	 <s5h4qe8dxfj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qe8dxfj.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-04-15 at 14:41 +0200, Takashi Iwai wrote:
> > 
> > I imagine this probably isn't exactly the right model.  The "Surround"
> > control affects the headphone volume but not the "Front" output (it
> > seems there is no volume level for the "Headphone" control for the w810
> > model).  The "Front" volume works as expected (internal speakers).  I
> > have not tested it any more than that.
> 
> That means the pin 0x16 is connected to the headphoone output.
> Note that ALC880 has no overall playback controls for all channels.
> The volume of each stereo channels is controlled independently.
> (That's why there is no "Master" control there.)
> 
> Does the device have surround and center-lfe outputs?  Are they shared
> with line-in and mic-in?
> Also, does "Front" volume affect the internal speaker volume?
> 

It basically has two jacks, one labeled S/PDIF which is S/PDIF and
headphone out combined, and the other seems to be mic input.  There is
also a built in mic at the top of the LCD screen.

I just figured out that this notebook is based on the Z71V ASUS platform
which should help a lot.  Yes, "Front" volume works as expected and
controls internal speaker volume.

> 
> > Still clicking in output, seemingly even with 48KHz audio, still
> > investigating.  Also many programs lock up at the end of the audio
> > output (like Rhythmbox when a song is finished for instance).
> 
> This is an unknown problem, so far.
> We got a similar problem but it was solved by setting TCREG bits 0-2.
> Possibly a similar mis-configuration by broken BIOS.
> 

Anything I can try?  I'll poke around in the source for the register you
mentioned.

> 
> Takashi
> 

Cheers!
	Josh Green




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
