From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Audigy SPDIF Output Sample Rate
Date: Fri, 25 Feb 2005 16:58:47 -0500
Message-ID: <1109368727.13193.10.camel@krustophenia.net>
References: <1108880895.6773.50.camel@radium.gaugetheory.org>
	 <1109351825.9681.43.camel@krustophenia.net>
	 <1109367868.6245.9.camel@cthulhu.rlyeth.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1109367868.6245.9.camel@cthulhu.rlyeth.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: The Orqwith Vagrant <theorqwithvagrant@bredband.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-02-25 at 22:44 +0100, The Orqwith Vagrant wrote:
> On Fri, 2005-02-25 at 12:17 -0500, Lee Revell wrote: 
> > On Sun, 2005-02-20 at 01:28 -0500, Brian L Scipioni wrote:
> > > I'm using yesterday's CVS.
> > > 
> > > The new alsamixer control "Audigy SPDIF Output Sample Rate" for the
> > > emu10k1 toggles the sample rate among 44100, 48000 and 96000.  I believe
> > > the mapping here is wrong (or at least the 3 rate labels are reversed). 
> > > My 5.1 receiver will accept 441000, 48000 or 96000 from SPDIF.  When it
> > > receives a 96KHz, signal it will indicate that with "96 k" printed out
> > > on the receiver front panel LEDs.  It does that when alsamixer selects
> > > 44100 and NOT 48000 or 96000.  So when alsamixer displays 44100, it
> > > appears 96000 is actually being output.
> > > 
> > 
> > Thanks.  Please try the attached patch.
> > 
> > Does your receiver tell you if it's receiving 48000 or 44100?  If so
> > please check that those are also correct.
> > 
> > So, have you tested that 96KHz SPDIF playback sounds OK?  None of the
> > alsa developers seem to have a 96KHz capable receiver (unless someone
> > want to give me one ;-)) so this is all untested so far.
> > 
> > > Also some new behavior with the latest CVS:
> > > When monitoring Aux2 in, the sound is badly distorted until the "Audigy
> > > SPDIF Output Sample Rate" switch is toggled back and forth among the
> > > rates.  After a little rate switching, the sound becomes fine.
> > 
> > This is probably related to this cryptic comment from some Creative
> > engineer:
> > 
> > 298             if (emu->revision == 4) { /* audigy2 */
> > 299                     /* Unmute Analog now.  Set GPO6 to 1 for Apollo.
> > 300                      * This has to be done after init ALice3 I2SOut beyond 48KHz.
> > 301                      * So, sequence is important. */
> > 302                     outl(inl(emu->port + A_IOCFG) | 0x0040, emu->port + A_IOCFG);
> > 
> > We have no idea what "Alice3" and "Apollo" are, though we have some good
> > guesses ;-)
> > 
> > I'll see if I can fix this.  The comment implies that in order to set
> > 96KHz mode, we may have to mute and unmute analog around the samplerate
> > register setting.  So instead of noise you would get a brief silence.
> > 
> > Lee
> 
> As someone who does have a 96 Khz capable reciever, I thought I might
> add my own comments tho this. The 96khz setting works perfect, sounds
> perfect with this patch; however, 48 & 44.1 are reversed now. Trying to
> play 48khz samples when the setting is 44.1 causes ugly scratchy
> distortion, but oddly, only on the right channel. Using the spdif raw
> PCM device, which reverses left and right channels of a stereo file,
> still has the distortion on the right channel.

OK I'll post a new patch.

> No luck with ac3 at any sample rate, but ac3 passthrough has never
> worked for me, and I have tried basically everything suggested on this
> mailing list to others with similar problems. The reason I'm always
> quick to test any patch/change that touches emu10k1 SPDIF is because I'm
> always hopeful it will somehow also solve my AC3-deficiency. No luck
> with _that_ so far. Oh well...
> 

That's strange.  It should work.  I guess you made sure to enable the
"IEC958 Optical Raw" switch, and the "Audigy Analog/Digital Mode"?

There was someone else who could not get it to work no matter what and
swapping the cable fixed it.

Anyway, that's weird.

> One thing tho: iecset still lists the spdif output rate as 48khz when
> it's set to 96khz, even though the reciever does say it's getting 96khz.
> Furthermore, trying to use "iecset rate 96000" causes iecset to report
> 44.1khz... but no change on the reciever, it still says 96khz if it's
> set that way in the alsa mixer, Should this be the case?
> Another - wouldn't in fact iecset be what you should use to change this
> setting, rather than have a mixer element for it? I saw a change like
> that was done in another driver recently, so perhaps that'd be a good
> idea for emu10k1 as well, if only for the sake of consistency?
> 

The reason I made it a separate control is that 96KHz mode is not set by
the standard SPDIF status bits.  There is a separate register for it.

Maybe someone on alsa-devel can explain the relationship between this
control and iecset.  I really have no idea.

> Notes: My card is an Audigy2 Platinum, my amp is a Denon AVR-3803, and
> I'm using the optical spdif connector on the audigy drive to connect
> them.
> 

Can someone else with the same hardware can confirm or deny that they
also have the AC3 problem?  Also, did you open a bug report?  Please
check for an existing one first.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
