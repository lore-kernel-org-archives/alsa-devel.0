From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: PCM questions
Date: Sat, 06 Mar 2004 16:45:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078587904.30309.1018.camel@renegade>
References: <1078416129.1865.868.camel@renegade>
	 <Pine.LNX.4.58.0403041720490.2204@pnote.perex-int.cz>
	 <1078422542.1866.899.camel@renegade>
	 <Pine.LNX.4.58.0403041932480.2204@pnote.perex-int.cz>
	 <1078430057.30309.921.camel@renegade>
	 <Pine.LNX.4.58.0403050839190.1869@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403050839190.1869@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

lør, 06.03.2004 kl. 11.10 skrev Jaroslav Kysela:
> I also extended the "auto-silence" function in driver in our CVS.
> Now, the code detects the written samples so snd_pcm_start() doesn't
> silence the whole ring buffer in this case.
> 
> Here is the patch for driver:

OK, thanks, may be useful for future projects.

I have a new question. How can I handle a buffer wraparound with
snd_pcm_mmap_begin and snd_pcm_mmap_commit? It seems that currently, if
the app frame pos is near the end of the buffer, the returned number of
mapped frames is apparently only up to the end of the buffer. But the
code that fills the buffer will want to handle the wraparound itself, so
I would like to return the requested number of frames to the code, and
let it do its own wraparound to offset=0 when the end of buffer is
reached. Is it safe to do something like calling snd_pcm_mmap_begin
twice to achieve this, then snd_pcm_mmap_commit twice after the sound
code has filled the buffer up?




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
