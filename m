From: Brian L Scipioni <brian@gaugetheory.org>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Tue, 25 Jan 2005 12:09:50 -0500
Message-ID: <1106672990.27843.7.camel@radium.gaugetheory.org>
References: <1106091073.24484.60.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1106091073.24484.60.camel@krustophenia.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee,

	Can you provide instructions for applying the patch?

	First I assume I need the latest alsa from CVS, right?

thanks,
brian

On Tue, 2005-01-18 at 18:31, Lee Revell wrote:
> As promised, here's an updated patch to add real multichannel playback
> support (and improved multichannel capture) to the emu10k1 driver.
> 
> http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v001.patch
> 
> Please test it and report any problems.  I am especially interested in
> any regressions that impact regular PCM playback (the hw:0,0 device).
> 
> QuickStart:
> 
> $ jackd -R -v -d alsa -P hw:0,3 -C hw:0,2 -S
> 
> This also adds some new register info including a per channel half loop
> interrupt that I have discovered by reverse engineering the Windows
> drivers.
> 
> Improvements over previous versions:
> 
>  - Routes the 16 channels to the 16 FX buses by default.
> 
>  - Enables the first 16 FX capture outputs by default, required for 
> full duplex operation at latencies lower than 512 frames.
> 
>  - Rewrote the voice allocator to use a more efficient round 
> robin algorithm, eliminating the need to reserve the
> first 16 voices for the multichannel device.  The next free voice 
> is maintained in the card record and the search starts from there.
> 
>  - Use an extra voice for playback timing rather than the EFX capture
> interrupt.  I was only ever able to get that to work at 64 frames.  Also
> there are definite advantages to being able to use the capture and
> playback devices independently.
> 
>  - Use the newly discovered per-channel half loop interrupt source for
> the extra voice rather than the channel loop interrupts.  For unknown
> reasons, this works better for multichannel playback, and does not seem
> to affect regular PCM playback at all.
> 
> TODO:
> 
>  - Fix the send routing and volume controls for the multichannel device.
> The current (copy and paste) solution assumes either one or two voices
> per PCM.  So the default settings work fine but changing them with the
> mixer is likely to have unpredictable effects.  
> 
>  - EFX capture should capture output channels 16-32 (mostly unused now)
> by default, so that we only capture the sources the user has connected
> to the multichannel recording inputs in the DSP manager.  Typically FX
> buses 0-15 would be connected directly to FX outputs 16-32 so the
> capture channels would correspond directly to the playback channels.  In
> order for this to work the default DSP configuration has to be changed
> slightly.
> 
> I tested this and it works well with 16in/16out at 128, 256, 512 frames.
> 32 and 64 should work too but I can't test as I'm running a stock 2.6.10
> kernel for now ;-).  You can check that the routing is correct by
> connecting a JACK client to the playback ports corresponding to the FX
> buses described in Documentation/Audigy-mixer.txt and
> Documentation/SB-Live-mixer.txt, and verifying that the output appears
> on that channel (the FX buses are numbered from 0 but JACK numbers
> clients from 1).  For example (from SB-Live-mixer.txt):
> 
>     name='Music Playback Volume',index=0
> 
>     This control is used to attenuate samples for left and right MIDI FX-bus
>     accumulators. ALSA uses accumulators 4 and 5 for left and right MIDI samples.
>     The result samples are forwarded to the front DAC PCM slots of the AC97 codec.
> 
> So "alsaplayer -o jack -d alsa_pcm:playback_5,alsa_pcm:playback_6"
> should output to FX buses 4 and 5, which you can test by lowering the
> 'Music' control in alsamixer.  With an SBLive, use ports 1 and 2 for the
> front channels, 3 and 4 for the rear channels.  The Audigy uses
> different channels, see the above docs for more info.
> 
> In addition to multichannel recording applications, this should also be
> useful for OpenAL implementations, which are currently restricted to
> using 21 sources due to the use of an extra voice per stereo PCM.  This
> should allow up to 63 sources.
> 
> Lee
> 
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
