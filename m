From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCM format restrict dilema
Date: Wed, 17 Sep 2003 09:03:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309170849030.5983@pnote.perex-int.cz>
References: <1063721993.1556.12.camel@localhost> <s5hd6e08z6c.wl@alsa2.suse.de>
 <3F675208.8090409@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F675208.8090409@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Sep 2003, James Courtier-Dutton wrote:

> I help develop an application called xine.
> We wish to use the function: -
> dir=0;
> err = snd_pcm_hw_params_set_buffer_time_near(this->audio_fd, params,
> &buffer_time, &dir);
>
> We then try to set the period size to buffer_size / 8.
>
> I have already found out that not all audio devices like an interger
> amount of periods, so this can fail in some circumstances.
>
> I have two problems: -
> 1) Once one sets the buffer size, and then tries to set the period size
> near, and fails. One would think that one could then go back a try a
> different buffer size, but I have found this does not work.
> 2) The different combinations of setting period_size/time and
> buffer_size/time and the dependence between them seems to be very
> difficult to achieve for all sound cards.
>
> I want to try and aim at 8 periods per buffer.
> Common sense would tell me that one should be able to set the buffer
> size first, and then try to set the period size to buffer_size/8. But I
> should be able to use the set_period_size_near call so that it selects
> the next closest value, so that I achieve a result as close as possible
> to what I want. This seems to fail with the current setup on some sound
> cards, but works with other sound cards.
>
> Can I assume that this is a bug in alsa, or some deeper issue.

Well, I am trying to debug these problem from time to time and the result
is that 99% of all cases are not bugs, but the problem with the refine
algorithm. Note that all not-locked parameters are "refined" when a
parameter is restricted (set). It is step by step issue, so you cannot get
back and change a parameter which is already restricted (as you noted for
buffer_size). You need to begin with the "refine" sequence again (thus
begin with the snd_pcm_hw_params_any() or save the hw_params value - use
snd_pcm_hw_params_copy() - BEFORE the failing step and recover it when you
want to try another values).

I don't think that the algorithm is bad. It allows us to track all
hardware constraints. I would probably suggest for all developers to try
their values and if they fail, this step might be the last resort:

snd_pcm_hw_params_any()
snd_pcm_hw_params_set_access(your...access)
snd_pcm_hw_params_set_format(your...format)
snd_pcm_hw_params_set_channels(your...channels)
snd_pcm_hw_params_set_rate_near(your...rate)
snd_pcm_hw_params_set_periods_minmax(min = 2, max = 8)
# buffer size from 0.1sec to 1sec
snd_pcm_hw_params_set_buffer_time_minmax(min = 100000, 1000000)
snd_pcm_hw_params()

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
