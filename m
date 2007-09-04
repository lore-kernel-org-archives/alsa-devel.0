From: "Brian Hinz" <bphinz@hotmail.com>
Subject: Re: ALSA bug 0002948
Date: Mon, 03 Sep 2007 21:39:15 -0400
Message-ID: <BAY105-F251D6C8EE506A85669BBCFC8CA0@phx.gbl>
References: <1188859440.4982.121.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s3.bay0.hotmail.com (bay0-omc3-s3.bay0.hotmail.com
	[65.54.246.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DF0B10388B
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Sep 2007 03:39:22 +0200 (CEST)
In-Reply-To: <1188859440.4982.121.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tdavis@dsl-only.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Tobin,

Thanks for responding.  I've added the output of the alsa-info.sh as an 
attachment to the issue report page:

https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=2210&type=bug

The model I'm struggling with is an NX100X, the bug was initially opened in 
regards to an MX3414 and others have reported the same trouble with an 
ML3109.  The only reason that I mention this is that they all use the same 
ini file and windows driver, can't say with any real certainty if the 
hardware is identical, but they are all using stac9200 and agere softmodem 
codecs (the one that was reported recently as being claimed by the 
patch_si3054 erroneously, so I've removed that id from patch_si3054.c and 
also used probe_mask=1).  I'm currently using an hg build from about two 
days ago.

As for the pin configs, I've read the datasheet front to back several times 
and as near as I can tell they are correct.  What is shipped with the 
gateway driver seems like a very generic set of values - very similar to 
what the codec datasheet specifies as the defaults.  These values are also 
what the windows registry reports, but those reported by microsoft's 
"uaatest" utility (from the MS hardware compatibility testsuite) seem to 
make a lot more sense, and since they are from a direct probe of the codec 
I've stuck with these.  I've tried every variant that makes sense to me, but 
so far the only port that produces sound is the mic.

I also removed the motherboard from the laptop and probed around a bit with 
a continuity meter.  The only notable thing that I could get from this was 
that I did not have continuity from any of the pins in the speaker connector 
to any of the pins on the codec - so I assume that there is an external amp 
somewhere, though I couldn't locate it.  Is it possible that the modem is 
somehow involved? I've tried setting the EAPD bit but nothing there 
either... (however GPIO3 doubles as the SPDIF in and also controls EAPD, and 
the windows driver does have a "GPIO: "3": hex:85" line - I emailed IDT and 
asked what the significance of this was but never got a response).

Thanks,
-brian




>From: Tobin Davis <tdavis@dsl-only.net>
>To: Brian Hinz <bphinz@hotmail.com>
>CC: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] ALSA bug 0002948
>Date: Mon, 03 Sep 2007 15:44:00 -0700
>
>Well, to start, which version of the driver are you running?
>(cat /proc./asound/version).
>
>Also, what model Gateway?  What is the output from
>http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh
>
>These tidbits will help to get your system supported.  What Windows does
>during use and what Alsa does can be completely different due to
>numerous factors.  But for the Sigmatel codecs, the key is the
>initialization settings for the pins.  Once these are set properly, the
>sound will work almost the same (well, alsa doesn't have the bloat that
>Windows has).
>
>Tobin
>
>On Mon, 2007-09-03 at 17:31 -0400, Brian Hinz wrote:
>
> > Hi,
> >
> > I'll apologize up front if this post seems a little incoherent, I've 
>been
> > trying to find a solution to this bug for a few months now and this is 
>sort
> > of a collection of observations that I've made and I'm hoping someone 
>might
> > read this and a light will go on...
> >
> > The problem is no sound from a stac9200 on various gateway models, 
>although
> > it's possible to get sound from the mic port, never from the hp or 
>internal
> > stereo speakers. I recently used a windows utility called "regmon" to 
>log
> > the registry events that occurred during a jack cycle on the hp port. I
> > expected to see something like this:
> >
> > ...
> > stsystra.exe:2380 SetValue
> > HKLM\Software\Sigmatel\GlobalState\STSysTray\1.0\JackPresenced SUCCESS 
>0x0
> > ...
> >
> > indicating an event on port D, but instead got:
> >
> > ...
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompRatio
> > SUCCESS 0xC8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompAttack
> > SUCCESS 0x26B6
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompRelease
> > SUCCESS 0x26B6
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompThreshDb
> > SUCCESS 0xFFFFFDA8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\MakeupGainDB
> > SUCCESS 0xC8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateRatio
> > SUCCESS 0x258
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateAttack
> > SUCCESS 0x2706
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateRelease
> > SUCCESS 0x2706
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateThreshDb
> > SUCCESS 0xFFFFDCD8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\Flags
> > SUCCESS 0x9
> > ...
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompRatio
> > SUCCESS 0xE74
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompAttack
> > SUCCESS 0x26AC
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompRelease
> > SUCCESS 0x26AC
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompThreshDb
> > SUCCESS 0x0
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\MakeupGainDB
> > SUCCESS 0x0
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateRatio
> > SUCCESS 0x64
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateAttack
> > SUCCESS 0x2328
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateRelease
> > SUCCESS 0x2328
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateThreshDb
> > SUCCESS 0xFFFFDCD8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\Flags
> > SUCCESS 0xB
> > ...
> >
> > and upon removal:
> >
> > ...
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompRatio
> > SUCCESS 0xC8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompAttack
> > SUCCESS 0x26B6
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompRelease
> > SUCCESS 0x26B6
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompThreshDb
> > SUCCESS 0xFFFFFDA8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\MakeupGainDB
> > SUCCESS 0xC8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateRatio
> > SUCCESS 0x258
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateAttack
> > SUCCESS 0x2706
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateRelease
> > SUCCESS 0x2706
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateThreshDb
> > SUCCESS 0xFFFFDCD8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\Flags
> > SUCCESS 0x8
> > ...
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompRatio
> > SUCCESS 0xE74
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompAttack
> > SUCCESS 0x26AC
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompRelease
> > SUCCESS 0x26AC
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompThreshDb
> > SUCCESS 0x0
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\MakeupGainDB
> > SUCCESS 0x0
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateRatio
> > SUCCESS 0x64
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateAttack
> > SUCCESS 0x2328
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateRelease
> > SUCCESS 0x2328
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateThreshDb
> > SUCCESS 0xFFFFDCD8
> > SetValue
> > 
>HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\Flags
> > SUCCESS 0xA
> > ...
> >
> > Notice how the "Flags" key changes?  I don't understand much of this, 
>but it
> > seems like the output is being manipulated via digital post-processing
> > rather than re-tasking of the analog pin widgets.  I had also been 
>trying to
> > make sense of the following line in the windows driver file:
> >
> > InitVerbs: 03, a0, 45, 01;
> >
> > which I'd guessed earlier could be interpreted as verb 0x3a0 and payload 
>of
> > 0x4501, (amplifier gain/mute, set input amp, port B(?), unmute, gain 
>step 1)
> > which actually makes some sense in this context, since if the flags key 
>is
> > referencing pin widgets the input mux should be unmuted if it's to be 
>used
> > as the limiter.
> >
> > So if I'm actually on the right track here, how would something like 
>this be
> > implemented in ALSA? Via /etc/asoundrc?  I tried setting the digital 
>mixer
> > as the default pcm device and now the gnome-volume-applet shows the 
>device
> > as being muted, and is unable to unmute it.  Nothing is muted in 
>alsamixer
> > though, so I'm guessing that I didn't do this correctly in any event.
> >
> > Another potentially interesting observation is that in the windows sound
> > control options there is both a master volume control and a "Wave" 
>volume
> > control which seem to be bound together somehow even though they are
> > independent controls.  ie: the wave control appears to have the exact 
>same
> > function as the master volume.
> >
> > Lastly, the system beep (which for what it's worth "sounds digital" to 
>my
> > untrained ears), works prior to the snd-hda-intel module being loaded, 
>but
> > not afterwards, even when unloaded.  Is there any debugging code aready 
>in
> > alsa that would produce a copy of /proc/asound/card0/codec#0 prior to 
>any
> > codec initialization?
> >
> > If anyone can make some suggestions I'd be quite grateful.  Also, if 
>there
> > is any specific debugging results you'd like to see let me know and I'll
> > append them to the bug report.
> >
> > Thanks,
> > -brian
> >
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>--
>Tobin Davis
>
>
>Real Users are afraid they'll break the machine -- but they're never
>afraid to break your face.
