From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: (Fwd) ALSA related comments - please correct [wulfram-26284]
Date: Mon, 29 Dec 2003 10:10:40 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312290957500.25504@pnote.perex-int.cz>
References: <E1AYV4I-00086T-00@spirou.transgaming.com> <3FE9DC5F.5090508@transgaming.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA28047
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2003 10:16:26 +0100
In-Reply-To: <3FE9DC5F.5090508@transgaming.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Hunnisett <peter@transgaming.com>
Cc: Ove Kaaven <ovek@transgaming.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Dec 2003, Peter Hunnisett wrote:

> >What's looping sound? You can initiate endless ring buffer looping when
> >you set stop_threshold to boundary (sw_params). I think that this
> >major drawback does not exist.
> >  
> >
> 
> Thanks for pointing out that sound looping is possible in a reasonable 
> and straightforward way. We had actually realized that we could have 
> worked around this even if ALSA didn't provide support using a PCM 
> callback and some double buffering but it wasn't obvious which is why 
> the link you quoted above indicates the lack of looping support. The 
> online documentation that we looked at certainly wasn't clear or 
> particularly informative in showing this reasonably common usage so may 
> I suggest improving it.

OK, I've added a few words to snd_pcm_sw_params_set_stop_threshold()
and snd_pcm_sw_params_get_stop_threshold() functions.

> We have been unable to find a way to tell ALSA, through 
> snd_pcm_mmap_begin(), where we want to write data when using the mmap 
> api. OSS doesn't have this restriction and this is the only documented 
> way we can see to support sound engines which mix in new sounds using 
> looping buffers and "randomly" writing ahead of the playing position. We 
> have seen that there are undocumented ways to support this functionality 
> and we are leery of using undocumented functionality since it could 
> disappear or change. Can you suggest a documented way to achieve the 
> desired effect or would you be in favour of modifications to the API?

Use snd_pcm_forward() and snd_pcm_rewind() functions to move the
application pointer in the ring buffer before snd_pcm_mmap_begin().
Note: The pointer for these functions is the stream pointer
[0 ... (boundary - 1)]. The offset to the ring buffer is:

stream_pointer % ring_buffer_size

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
