From: Dominik 'Aeneas' Schnitzer <dominik@schnitzer.at>
Subject: Re: [PATCH] EMU10K1.conf
Date: Tue, 06 Jan 2004 12:23:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073388215.7832.32.camel@blackhole>
References: <1072485112.2477.35.camel@blackhole> <s5h7k062vag.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k062vag.wl@alsa2.suse.de>
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

On Mon, 2004-01-05 at 17:51, Takashi Iwai wrote:
> "Wave XXX Volume" controls should be zero for multi-channel outputs
> indeed, because these are volumes of signals duplicated from the front
> channel to surround/center/lfe channels.
> locking could be optional, though.

Hi!

For me "Wave XXX Volume" controls (using digital out) work like
intended:

Wave: Front Speakers Volume
Wave Center: Center Speaker
Wave LFE: LFE
Wave Surround: Rear Speakers

But setting "Wave Surround Playback Volume" to 0 in the
EMU10K1.pcm.rear.0 section has the effect that no sound is coming out of
the rear boxes.

And setting "Wave Center Playback Volume" and "Wave LFE Playback Volume"
to 0 (in EMU10K1.pcm.center_lfe.0) has the effect that no sound is
coming out of the center and LFE speakers.

Generally this means that with the current alsa configuration only the 2
front speakers have sound (when using the digital out jack).

By removing the locks and 0-settings, its possible to control the other
volumes too -> and thus unlocking the other speakers too. :)

> >  - surround51 was statically bound to the non-digital output and locked
> > (to the analogue output), so there was no way to get surround sound on
> > my digital-out.
> 
> hmm, i'm not sure about this.  surround51 was designed for outputs
> from three analog jacks.
> 
> what do you get from digital out with surround51?

With the modified config-file and setting xine to use surround51 I get
True surround 5.1 sound. I have a 5.1 test-audio file, which I used for
testig - Its not just duplication of the front speakers signal.

Using the unmodified config and setting xine to use surround51, the card
switches to analogue out, the receiver blinks (no connection) and
nothing happens. If I remove the analogue-out lock in the config, only
the 2 front speakers work. Removing the 0 volume locks (and increasing
volumes in the mixer) everything works.

> does the card send non-encoded raw 6-channel PCM over spdif?

No, digital out sends the data over this creative-coaxial cable. AFAI
understand, spdif is only (?) used for sending raw Encoded AC3 data to a
5.1 receiver in order to let the receiver decode it.

> >  - other volume controls were locked too, I had a look at Audigy.conf
> > and reduced the locked controls to the minimum required.
> 
> on Audigy, the signal routing and control elements are fairly
> different from SB Live.  so, you cannot copy it simply...

I didn't copy the routing part, I just inspired :-) myself in the
Audigy.conf files. For the audigy digital-out and the other volumes
weren't locked and set to 0; so I tried this out for the EMU10k1 too and
it worked :D

I hope this helps a bit!
dominik.
-- 
Dominik 'Aeneas' Schnitzer <dominik@schnitzer.at>
http://www.schnitzer.at/dominik/ - Update 03/08/31: Birthday Party

PGP Fingerprint: E839 B9EA F518 899D AA35  BB67 0DBF 7AB2 5FE6 525A
PGP Public Key: http://www.schnitzer.at/dominik/public.key


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
