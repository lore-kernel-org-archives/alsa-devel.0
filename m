From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: Audigy 2 support - update
Date: Mon, 7 Jul 2003 21:49:14 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030707184914.GH7637@edu.joroinen.fi>
References: <20030523051240.GA10831@www.angiotech.com> <1053675028.18540.70.camel@rivendell.home.local> <20030524004334.GA15947@www.angiotech.com> <1053747456.6906.1.camel@rivendell.home.local> <3ECF6FDD.3090107@superbug.demon.co.uk> <20030527072847.GI7637@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030527072847.GI7637@edu.joroinen.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, May 27, 2003 at 10:28:47AM +0300, Pasi Kärkkäinen wrote:
> On Sat, May 24, 2003 at 02:13:01PM +0100, James Courtier-Dutton wrote:
> > Florin Andrei wrote:
> > >On Fri, 2003-05-23 at 17:43, Stephen Hassard wrote:
> > >
> > >>On Fri, May 23, 2003 at 12:30:28AM -0700, Florin Andrei wrote:
> > >>
> > >>>On Thu, 2003-05-22 at 22:12, Stephen Hassard wrote:
> > >>>How about MIDI output?
> > >>
> > >>MIDI output seems to work fine too.
> > >
> > >
> > >Thank you Stephen!
> > >
> > >And thanks to the ALSA developers. Now i'll go ahead and buy an Audigy2.
> > >Yeah, it's going to be a Platinum, yeah, maybe a few gizmos on the front
> > >panel won't work (we'll see), but as long as there is at least one pair
> > >of MIDI in/out that works, i'm happy.
> > >
> > >Keep up the good work!
> > >
> > I have heard reports that the SPDIF passthru does not work, so you will 
> > not be able to use external AC3 and DTS decoders.
> > 
> > Can anyone verify this?
> > 
> 
> I have audigy, and ac3/dts output is not working.
> 
> Alsa says it cannot find some hw device.. sorry I don't have the exact error
> message here.
> 
> I have gotten the same error at least 6 months now..
> 

I finally remembered this..

here comes the error-message from mplayer when trying to play movie with
ac3-sound and use the spdif output:


Forced audio codec: hwac3
Opening audio decoder: [hwac3] AC3/DTS pass-through SP/DIF
No accelerated IMDCT transform found
hwac3: switched to AC3, 448000 bps, 48000 Hz
AUDIO: 48000 Hz, 2 ch, 16 bit (0x400), ratio: 56000->192000 (448.0 kbit)
Selected audio codec: [hwac3] afm:hwac3 (AC3 through SPDIF)

Checking audio filter chain for 48000Hz/2ch/16bit -> 48000Hz/2ch/8bit...
AF_pre: af format: 2 bps, 2 ch, 48000 hz, big endian AC3 
AF_pre: 48000Hz 2ch AC3
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, AC3
alsa-init: soundcard set to iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2
ALSA lib pcm_hw.c:1055:(snd_pcm_hw_open) open /dev/snd/pcmC0D3p failed: No
such device
alsa-init: playback open error: No such device
Could not open/initialize audio device -> no sound.
Audio: no sound


-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
