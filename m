From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: PCM hw mixing with volume
Date: Wed, 10 Mar 2004 17:56:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078937796.18056.355.camel@renegade>
References: <XFMail.20040310165505.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20040310165505.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ons, 10.03.2004 kl. 16.55 skrev Giuliano Pochini:
> Uhm... I think first of all we need a way to know how many
> virtual channels are available (hw and sw)

For the EMU10K1, snd_pcm_info_get_subdevices_count() and
snd_pcm_info_get_subdevices_avail() works for me. But I suppose you're
right that this isn't a good abstraction.

> and a function to
> allocate some of them.

snd_pcm_open works for me for now... you mean reserve, perhaps?

>  The app may choose to use less channels
> than it wishes in order to not fall back to software mixing.
> set_volume() should be something more generic. Think about 5.1 .

I think 3D position controls or pan controls would be more appropriate
than a more flexible volume control. Or perhaps the stream might just be
6-channel in the first place...

> Also, the API should lay above the PCM API because, if the
> card hasn't the required capabilities, that layer will emulate
> it using the PCM API. Also, in some cases (eg. the Echoaudio
> Mia and probably hdsp), that mixing feature is already
> supported by the driver through the normal PCM and control APIs.

Good point, but I wonder how 3D effects could be applied to sounds
loaded into the card's onboard memory (via the suggested wavetable API).
Perhaps that won't be a very important feature though.

> > ALTERNATIVE 2
> >
> > snd_pcm_set_volume(snd_pcm_t* pcm, int vol_left, int vol_right)
> >
> > but I don't expect this to be useful, since there are probably some
> > oddball devices out there that aren't able to control left and right
> > volume independently like this.
> 
> And there are some cards which haven't a pan control, but only l/r
> volumes.

The l/r volume can easily be calculated from the volume and pan. That
doesn't make it less useful to make the API express it in terms of
vol/pan for the benefit of the hardware that don't use l/r volume.

> There also is another important question: What is the unit used
> to set the gain ?  Decibel is probably the right choice, but
> the control API provides no way to translate the dB scale to the
> scale used by the hardware.

I don't have a preference, but it probably should be addressed.

> > * Volume
> > * Pan (not available if 3D sound is requested)
> > * Frequency (can be used for software-calculated doppler shift, or for
> > "wavetable synthesis"-like purposes)
> > * 3D position (relative to listener)
> > * Velocity (for hardware-calculated doppler shift)
> > * Cone inside/outside angles, direction, outside volume
> > * Min/max distance (wherever the sound is heard)
> 
> And all the above must not be static. You may need to change
> them while the sound is playing.

Exactly.

> > The API should also be designed to allow for further parametrized
> > effects to be applied to a particular stream, for example reverb
> > effects. For what it's worth, DirectSound has currently defined Gargle,
> > Chorus, Flanger, Echo, Distortion, Compressor, and a couple of Reverb
> > types...
> 
> We can define a small set of standard effects, or we can do something
> like the control API.

As far as I'm concerned, as long as the API can do what I need, it
doesn't matter much what it looks like. DirectSound does allow
individual drivers to implement custom device-specific effects, but I
don't expect to really want that. Standard effects are good enough.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
