From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: PCM hw mixing with volume
Date: Wed, 10 Mar 2004 15:16:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078928193.18054.247.camel@renegade>
References: <XFMail.20040310104621.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20040310104621.pochini@shiny.it>
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

ons, 10.03.2004 kl. 10.46 skrev Giuliano Pochini:
> On 09-Mar-2004 Ove Kaaven wrote:
> > Since we're ranting anyway: It's a similar situation with 3D graphics
> > hardware, where the 3D cards get ever more powerful, even though the CPU
> > power is going up. [...]
> 
> No need to enter the philosophycal battlefield.

Oh, I wasn't planning on it. I didn't say that to make an argument or
anything, just because "we're ranting anyway". Consider it venting, or
whatever, I'm not trying to persuade you, just make it clear that I have
an opinion which it's not worth Paul Davis's time to try to change. I'm
not trying to push that opinion on him or anyone else, just make it
clear that they shouldn't try to push theirs on me either, and then we
can get along together, agreeing that we disagree.

> The fact it there is
> no ALSA support for this yet. Thus, you can just await for it, or use
> another mixer library, or help ALSA developers to write it.

That point has already been made, and agreed upon. And not really what
we were debating, either.

> Please start writing what the API should provide.

Well, the requirements that raised this thread should be fairly clear.
For example,

ALTERNATIVE 1

snd_pcm_set_volume(snd_pcm_t* pcm, int volume)

and

snd_pcm_set_pan(snd_pcm_t* pcm, int pan)

using whatever value range makes the most sense, and perhaps some query
on whether these controls are available from the pcm info. It's
acceptable to have to explicitly ask for these controls using hw_params.
The plug plugin could insert the route/volume plugin if these controls
are asked for.

ALTERNATIVE 2

snd_pcm_set_volume(snd_pcm_t* pcm, int vol_left, int vol_right)

but I don't expect this to be useful, since there are probably some
oddball devices out there that aren't able to control left and right
volume independently like this.

ALTERNATIVE 3

Let each PCM channel have its own mixer control, like the EMU10K1
currently do. That is, use snd_pcm_info_get_subdevice() to get the
index, then look up a volume control with a well-known name and the
given index using the snd_ctl API to control the volume of that PCM
stream. The name and semantics of that mixer control would have to be
standardized and be the same on all devices that are capable of this
feature.

Whatever way is chosen, it's simple enough to work with.

But if we get into the realm of spatial sound, it can get trickier, of
course. I might suggest to create a new snd_pcm_fx_params_t or
something, which can be loaded into a PCM stream to change the volume,
pan, or other effect. The available effects should depend on which was
requested in hw_params. Specifically, the following effects would be
desirable:

* Volume
* Pan (not available if 3D sound is requested)
* Frequency (can be used for software-calculated doppler shift, or for
"wavetable synthesis"-like purposes)
* 3D position (relative to listener)
* Velocity (for hardware-calculated doppler shift)
* Cone inside/outside angles, direction, outside volume
* Min/max distance (wherever the sound is heard)

There are also settings that can be considered "global" for all sounds
in the game, but I'm not sure how they could really be considered such
using the PCM API, so it's acceptable to have to go through every PCM
stream and update the parameters of each one, if that's easier to
implement. If not, there must be a way to attach each 3D-aware PCM
stream to some kind of master structure which can hold these parameters.
This master can be a designated PCM stream with special hw_params.
Global settings include:

* 3D position, orientation (forward and upward directions), and velocity
of listener, to allow streams to use absolute, not relative,
coordinates, if they want to
* Distance, rolloff, and doppler factors (I don't remember the exact
semantics of these, but can look it up)

These will be required anyway for full HW-accelerated OpenAL support, of
course.

The API should also be designed to allow for further parametrized
effects to be applied to a particular stream, for example reverb
effects. For what it's worth, DirectSound has currently defined Gargle,
Chorus, Flanger, Echo, Distortion, Compressor, and a couple of Reverb
types...




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
