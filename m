From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: PCM hw mixing with volume
Date: Wed, 10 Mar 2004 16:55:05 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040310165505.pochini@shiny.it>
References: <1078928193.18054.247.camel@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078928193.18054.247.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 10-Mar-2004 Ove Kaaven wrote:

> Well, the requirements that raised this thread should be fairly clear.
> For example,
>
> ALTERNATIVE 1
>
> snd_pcm_set_volume(snd_pcm_t* pcm, int volume)
>
> and
>
> snd_pcm_set_pan(snd_pcm_t* pcm, int pan)
>
> using whatever value range makes the most sense, and perhaps some query
> on whether these controls are available from the pcm info. It's
> acceptable to have to explicitly ask for these controls using hw_params.
> The plug plugin could insert the route/volume plugin if these controls
> are asked for.

Uhm... I think first of all we need a way to know how many
virtual channels are available (hw and sw) and a function to
allocate some of them. The app may choose to use less channels
than it wishes in order to not fall back to software mixing.
set_volume() should be something more generic. Think about 5.1 .

Also, the API should lay above the PCM API because, if the
card hasn't the required capabilities, that layer will emulate
it using the PCM API. Also, in some cases (eg. the Echoaudio
Mia and probably hdsp), that mixing feature is already
supported by the driver through the normal PCM and control APIs.


> ALTERNATIVE 2
>
> snd_pcm_set_volume(snd_pcm_t* pcm, int vol_left, int vol_right)
>
> but I don't expect this to be useful, since there are probably some
> oddball devices out there that aren't able to control left and right
> volume independently like this.

And there are some cards which haven't a pan control, but only l/r
volumes.

There also is another important question: What is the unit used
to set the gain ?  Decibel is probably the right choice, but
the control API provides no way to translate the dB scale to the
scale used by the hardware.


> ALTERNATIVE 3
>
> Let each PCM channel have its own mixer control, like the EMU10K1
> currently do. That is, use snd_pcm_info_get_subdevice() to get the
> index, then look up a volume control with a well-known name and the
> given index using the snd_ctl API to control the volume of that PCM
> stream. The name and semantics of that mixer control would have to be
> standardized and be the same on all devices that are capable of this
> feature.

IMHO, it's not robust enough.


> Whatever way is chosen, it's simple enough to work with.
>
> But if we get into the realm of spatial sound, it can get trickier, of
> course. I might suggest to create a new snd_pcm_fx_params_t or
> something, which can be loaded into a PCM stream to change the volume,
> pan, or other effect. The available effects should depend on which was
> requested in hw_params. Specifically, the following effects would be
> desirable:
>
> * Volume
> * Pan (not available if 3D sound is requested)
> * Frequency (can be used for software-calculated doppler shift, or for
> "wavetable synthesis"-like purposes)
> * 3D position (relative to listener)
> * Velocity (for hardware-calculated doppler shift)
> * Cone inside/outside angles, direction, outside volume
> * Min/max distance (wherever the sound is heard)

And all the above must not be static. You may need to change
them while the sound is playing.


> The API should also be designed to allow for further parametrized
> effects to be applied to a particular stream, for example reverb
> effects. For what it's worth, DirectSound has currently defined Gargle,
> Chorus, Flanger, Echo, Distortion, Compressor, and a couple of Reverb
> types...

We can define a small set of standard effects, or we can do something
like the control API.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
