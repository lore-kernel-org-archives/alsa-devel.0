From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: start_threshold having no effect
Date: Tue, 21 Oct 2003 13:32:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310211326180.25721@pnote.perex-int.cz>
References: <20031020173030.GC28408@via.ecp.fr>
 <200310202223.h9KMNQlC022039@oud.linuxaudiosystems.com> <20031021095054.GB30326@via.ecp.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031021095054.GB30326@via.ecp.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johan Bilien <jobi@via.ecp.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Oct 2003, Johan Bilien wrote:

> On Mon, Oct 20, 2003, Paul Davis wrote:
> > the output latency is always roughly the size of the hardware
> > buffer. there is no way to avoid this. the best you could ever do
> > would be one period, where there are two periods per buffer (i.e half
> > the buffer size). when i say "the best you could do", the truth is
> > that you probably can't do it. the very first sample you deliver to
> > the hardware will have a delay of 1 period, each subsequent sample has
> > a steadily increasing delay all the way up to the last sample, which
> > is delayed by the length of the entire hardware buffer (2
> > periods). this assumes that delivery is basically instaneous:
> > obviously, if you take time to deliver it, the delay drops, but the
> > total delay (from when you could have written to when the sound is
> > audible) is the same.
>
> I am working on a voice over IP application. We would like delays from
> the write to soundcard to the actual playout lower than 50ms. Do you
> think it is impossible with ALSA ? With OSS free the delay we got were
> quite good, without any tweaking. But ALSA is said to have better
> support for full-duplex.

Comparing to OSS: OSS does not have any xrun detection (overrun/underrun).

> Maybe using a small buffer on the sound card should then be a better
> solution ? I tried with a buffer of 50 ms, and the playout is fine until
> for some reason the buffer gets full. At that point I get an EPIPE error

If you get EPIPE error, then the buffer is empty and you've reached an
underrun.

> on the next write, I then do a snd_pcm_prepare, can write again, but
> after that both reading and writing give a lot of errors, and after a

Sure. You need to resync here for full duplex. At this point, you have
much more data captured than played, so you need to flush also the capture
buffer.

> very short while a write will block for more than one second. Are those
> ALSA related problems, or hardware ones ?

You said that you're using an USB device. It might be a problem with our
USB driver. Also, USB devices are working with 1ms periods at the physical
level, so transferring 32 frames does not make probably sense anyway.

For a voice IP applications, it probably make sense to work without over
and underrun detection (yes, if CPU is busy, there will be some scratches,
but you'll avoid resyncing). Simply set stop_threshold to boundary for
the no-xrun detection.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
