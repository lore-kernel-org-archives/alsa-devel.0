From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: softvol and snd_pcm_rewind() is broken
Date: Wed, 16 Jul 2008 16:54:11 +0200
Message-ID: <20080716145411.GA22968@tango.0pointer.de>
References: <20080716143004.GA21124@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id CB1C5244BB
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 16:54:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080716143004.GA21124@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 16.07.08 16:30, Lennart Poettering (mznyfn@0pointer.de) wrote:

> Heya!
> 
> With 1.0.17rc3 snd_pcm_rewind() is broken for softvol as it seems:
> 
> - Sometimes the sound becomes heavily distorted after such a seek:
> 
>   http://mailman.alsa-project.org/pipermail/alsa-devel/2008-June/008860.html
> 
> - And snd_pcm_rewind() might return a value that is higher than was
>   passed in, which as far as I understood should never happen:
> 
>   http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007308.html
> 
> These two issues might be caused by the same error.
> 
> Takashi, Jaroslav, how can I bribe you into fixing this? I'd love to
> release my new PulseAudio version soon which heavily relies on
> snd_pcm_rewind(), but unfortunately the most important driver (hda
> with softvol) makes the most problems with it. :-(

Hmm, if I understand snd_pcm_plugin_rewind() in pcm_plugin.c
correctly, then I read it like this:

1. we clamp the input frames to hw_avail
2. we convert this to slave frames
3. we issue the rewind
4. we convert back to client frames
5. we return hw_avail.

Step #1 seems wrong to me. The code will make sure that we rewind as
least as much as can be written right now. Does that make any sense? I
don't think so. Shouldn't this be a clamp that makes sure that we
rewind at most as much as the buffer is filled right now?
I.e. something along the lines of:

   if (frames > buffer_size - n)
        frames = buffer_size - n;

Also, step #5 seems wrong to me. Shouldn't we return the result of the
second conversion? I.e. shouldn't "return n" be replaced by "return
(snd_pcm_sframes_t) frames"?

I am puzzled though, not sure if I understood that function correctly
at all.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
