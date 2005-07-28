From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Volume per voices [Feature Request]
Date: Thu, 28 Jul 2005 09:42:48 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507280926040.9785-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0507271750440.10303@denise.shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0507271750440.10303@denise.shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Dino Puller <dino@e4a.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:
>
> On Wed, 27 Jul 2005, Clemens Ladisch wrote:
>
> > As far as I see, the iface/device/subdevice fields were designed for
> > exactly this purpose, i.e., associating a control with a specific
> > (sub)device.
>
> How do they work ?

Set iface to the type of the ALSA device (HWDEP, PCM, RAWMIDI, TIMER,
SEQUENCER), and set device/subdevice to the device/subdevice numbers
(or device/substream numbers for PCM).

> The tutorial says nothing about control names, interfaces and their
> arrangement and expecially how they are meant to be sorted out.

This may be the reason why the drivers don't use these fields in any
consistent manner ...

> In my driver we have A analog channels and D digital channels. The
> driver registers a "PCM Playback Volume" control as an array of
> A+D integers, where each element is the gain (-128..+6) of each
> channel, but they don't map directly to the PCM channels because
> the driver exports analog and digital channels as two separate
> devices (this feature can be removed easily). So pcmvol[0..A-1]
> controls the volume of hw:0,0 and pcmvol[A..A+D-1] controls the
> volume of hw:0,1. Furthermore, the user can open hw:0,0,x to
> address the xth channel.

As far as I can see, no driver actually uses the subdevice (substream)
field for PCM substreams; probably because this would require a
separate control for each substream instead of using an array.

> The driver also has other controls that are quite hw-specific and
> I don't think a generic application would be able to use them.
> Those controls are not a problem, because I wrote echomixer to
> manage them. It is important that apps can access basic controls,
> though.

alsamixer shows only controls with MIXER interface.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
