From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Volume per voices [Feature Request]
Date: Thu, 28 Jul 2005 19:51:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507281927310.14095@denise.shiny.it>
References: <Pine.HPX.4.33n.0507280926040.9785-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507280926040.9785-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Dino Puller <dino@e4a.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Thu, 28 Jul 2005, Clemens Ladisch wrote:

> Giuliano Pochini wrote:
> >
> > On Wed, 27 Jul 2005, Clemens Ladisch wrote:
> >
> > > As far as I see, the iface/device/subdevice fields were designed for
> > > exactly this purpose, i.e., associating a control with a specific
> > > (sub)device.
> >
> > How do they work ?
>
> Set iface to the type of the ALSA device (HWDEP, PCM, RAWMIDI, TIMER,
> SEQUENCER), and set device/subdevice to the device/subdevice numbers
> (or device/substream numbers for PCM).

Nope, I can't make them match.


> > In my driver we have A analog channels and D digital channels. The
> > driver registers a "PCM Playback Volume" control as an array of
> > A+D integers, where each element is the gain (-128..+6) of each
> > channel, but they don't map directly to the PCM channels because
> > the driver exports analog and digital channels as two separate
> > devices (this feature can be removed easily). So pcmvol[0..A-1]
> > controls the volume of hw:0,0 and pcmvol[A..A+D-1] controls the
> > volume of hw:0,1. Furthermore, the user can open hw:0,0,x to
> > address the xth channel.
>
> As far as I can see, no driver actually uses the subdevice (substream)
> field for PCM substreams; probably because this would require a
> separate control for each substream instead of using an array.

My case is even more compicated because one ctl controls the volume of two
devices. A callback that gets snd_pcm_substream_t* and returns {int numid,
firstindex, lastindex} or sort of would make things much simpler wrt hw
controls. In case there are both hw volume and softvol, which has
priority ? :)
Without that callback, I perhaps can make it work splitting those controls
or merging the pcm devices. The former is better. It would not work
anyway if the user opens a subdevice !=0 (quite rare case).


> > The driver also has other controls that are quite hw-specific and
> > I don't think a generic application would be able to use them.
> > Those controls are not a problem, because I wrote echomixer to
> > manage them. It is important that apps can access basic controls,
> > though.
>
> alsamixer shows only controls with MIXER interface.

I was talking eg. about vmixer (mixes n PCM "voices" to m outputs) and
monitor mixer (mixes n inputs to m outputs). I don't think we should worry
about such complex controls.


--
Giuliano.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
