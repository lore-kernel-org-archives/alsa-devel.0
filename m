From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: PCM hw mixing with volume
Date: Wed, 10 Mar 2004 17:05:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078934710.18056.310.camel@renegade>
References: <XFMail.20040310104621.pochini@shiny.it>
	 <1078928193.18054.247.camel@renegade>  <s5hy8q8loym.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8q8loym.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Giuliano Pochini <pochini@shiny.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ons, 10.03.2004 kl. 16.08 skrev Takashi Iwai:
> At Wed, 10 Mar 2004 15:16:34 +0100,
> Ove Kaaven wrote:
> > 
> > > Please start writing what the API should provide.
> > 
> > Well, the requirements that raised this thread should be fairly clear.
> > For example,
> > 
> > ALTERNATIVE 1
> > 
> > snd_pcm_set_volume(snd_pcm_t* pcm, int volume)
> > 
> > and
> > 
> > snd_pcm_set_pan(snd_pcm_t* pcm, int pan)
> 
> it'd be cleaner to separate these features from the existing snd_pcm
> stuffs.  i.e. i'd like to see rather another class, with simplified
> parameter setting and extended features.

Yeah, I suggested doing that with a snd_pcm_fx_params_t. But any way is
fine with me.

> > using whatever value range makes the most sense, and perhaps some query
> > on whether these controls are available from the pcm info. It's
> > acceptable to have to explicitly ask for these controls using hw_params.
> 
> hw_params is not a good candidate because it's a setup parameter at
> the initialization but not applied to the running streams.

Perhaps you misunderstood. I meant that hw_params is used in its setup
role to request such controls, not to use them. For example, if some
goon does this:

snd_pcm_hw_params_any(pcm, hw_params);
...set sample rate and format...
snd_pcm_hw_params(pcm, hw_params);
snd_pcm_prepare(pcm);
snd_pcm_set_volume(pcm, 100);
snd_pcm_set_pan(pcm, -10);

then ALSA would return errors or even assertion failures. But if this
was done:

snd_pcm_hw_params_any(pcm, hw_params);
...set sample rate and format...
snd_pcm_hw_set_controls(pcm, hw_params,
  SND_PCM_VOLUME_CONTROL | SND_PCM_PAN_CONTROL);
snd_pcm_hw_params(pcm, hw_params);
snd_pcm_prepare(pcm);
snd_pcm_set_volume(pcm, 100);
snd_pcm_set_pan(pcm, -10);

then the code would succeed. And then the "plug" plugin would then also
know in advance that it needs to pull in the route/volume plugin if the
hardware can't do it, while checking hw_params, same way I'd expect it
to pull in the rate plugin if the hw_params requests an unsupported
sample rate.

> > ALTERNATIVE 2
> > 
> > snd_pcm_set_volume(snd_pcm_t* pcm, int vol_left, int vol_right)
> > 
> > but I don't expect this to be useful, since there are probably some
> > oddball devices out there that aren't able to control left and right
> > volume independently like this.
> 
> again plugin in such a case?

Sure, for the general case, but our code probably won't use it as we
prefer to fall back to our own integrated software mixing code if
insufficient hardware capabilities are available for the purpose of the
stream. I'd expect volume/pan to be more flexible and widely supported
in hardware than left/right volume. The latter can easily be derived
from the former, after all, and perhaps some hardware might have only a
single volume and no pan (in which case it should be possible to use
that single volume without panning, whenever the stream doesn't need a
pan control).

> > ALTERNATIVE 3
> > 
> > Let each PCM channel have its own mixer control, like the EMU10K1
> > currently do. That is, use snd_pcm_info_get_subdevice() to get the
> > index, then look up a volume control with a well-known name and the
> > given index using the snd_ctl API to control the volume of that PCM
> > stream. The name and semantics of that mixer control would have to be
> > standardized and be the same on all devices that are capable of this
> > feature.
> 
> such an implementation detail will be anyway hidden in the library,
> and shouldn't appear in the API itself.

Perhaps, but the "well-known name" trick is already used for "PCM
Volume", so I didn't think this would be too different.

> > Whatever way is chosen, it's simple enough to work with.
> > 
> > But if we get into the realm of spatial sound, it can get trickier, of
> > course. I might suggest to create a new snd_pcm_fx_params_t or
> > something, which can be loaded into a PCM stream to change the volume,
> > pan, or other effect. The available effects should depend on which was
> > requested in hw_params. Specifically, the following effects would be
> > desirable:
> > 
> > * Volume
> > * Pan (not available if 3D sound is requested)
> > * Frequency (can be used for software-calculated doppler shift, or for
> > "wavetable synthesis"-like purposes)
> > * 3D position (relative to listener)
> > * Velocity (for hardware-calculated doppler shift)
> > * Cone inside/outside angles, direction, outside volume
> > * Min/max distance (wherever the sound is heard)
> 
> hmm, the question is how abstracted the ALSA API should be.
> we have the openAL layer on the ALSA hw API.
> so, the lower implementation isn't necessarily too generalized.

That's fine. It's possible we'd just end up writing a sound backend on
top of OpenAL eventually anyway, if OpenAL ever gets a more viable API
than the useless one it's currently sporting. I think our CTO has been
trying to fund people such as Ryan Gordon to redesign OpenAL. But
barring that, we should be able to adapt our own code to use any
features ALSA exposes, and just fall back to basics (which may mean
lower sound quality) when those features do not appear to be available
in any way.

> > The API should also be designed to allow for further parametrized
> > effects to be applied to a particular stream, for example reverb
> > effects. For what it's worth, DirectSound has currently defined Gargle,
> > Chorus, Flanger, Echo, Distortion, Compressor, and a couple of Reverb
> > types...
> 
> this reminds me the use of LADSPA plugins.  if the samples are handled
> in float internally, we can use LADSPA plugins quite easily.
> the calculation of float is cheap nowadays, the only cost is
> conversion between different types.

I guess. But there should be a way to let the sound card's DSP handle
some of those effects, if it can, rather than the CPU.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
