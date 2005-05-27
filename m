From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/core/oss pcm_oss.c,1.87,1.88
Date: Fri, 27 May 2005 11:23:17 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505271112380.8310-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0505271038060.1757@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E153209
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2005 11:23:19 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0505271038060.1757@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Thu, 26 May 2005, Clemens Ladisch wrote:
> > Modified Files:
> > 	pcm_oss.c
> > Log Message:
> > Summary: pcm_oss - fix SNDCTL_DSP_GETOPTR not working correctly
> >
> > This patch changes snd_pcm_oss_bytes() by adding a local variable
> > for the frames -> bytes conversion, which means that the frame count
> > is no longer corrupted by this conversion.
>
> It seems like a wrong patch to me. We cannot mix frames with bytes (see
> last expression).

I assumed that buffer_size would be in frames (due to its type), but
this is obviously wroung.

> This reverts the last patch which wrongly mixes bytes and frames.
> The real culprit might be the 32-bit overflow, so the return expression uses
> 64-bit values now in snd_pcm_oss_bytes().
>
>  static long snd_pcm_oss_bytes(snd_pcm_substream_t *substream, long frames)
>  {
> -     long bytes = 0;
>       snd_pcm_runtime_t *runtime = substream->runtime;
>       snd_pcm_uframes_t buffer_size = snd_pcm_lib_buffer_bytes(substream);
> -     bytes = frames_to_bytes(runtime, frames);
> +     frames = frames_to_bytes(runtime, frames);
>       if (buffer_size == runtime->oss.buffer_bytes)
> -             return bytes;
> -     return (runtime->oss.buffer_bytes * frames) / buffer_size;
> +             return frames;
> +     return (long)(((int64_t)runtime->oss.buffer_bytes * (int64_t)frames) / (int64_t)buffer_size);
>  }

This still uses a misleading type for buffer_size, and uses 'frames'
for a value not measure in frames.  I think I'd better rename these.
Any objections?


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
