From: Arnaud de Bossoreille de Ribou <arnaud.debossoreille@via.ecp.fr>
Subject: Re: emu10k1 bug and patch (0.9.0rc7)
Date: Mon, 17 Feb 2003 09:36:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030217083611.GA2181@via.ecp.fr>
References: <20030210172112.GA12226@via.ecp.fr> <Pine.LNX.4.44.0302132129000.1315-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302132129000.1315-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Arnaud de Bossoreille de Ribou <arnaud.debossoreille@via.ecp.fr>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 13, 2003, Jaroslav Kysela wrote:
> On Mon, 10 Feb 2003, Arnaud de Bossoreille de Ribou wrote:
> 
> > So the bug looks like a signedness problem since sw_ready is unsigned
> > and there is a while(sw_ready > 0), which explain the constant delay,
> > next in the "snd_emu10k1_fx8010_playback_transfer" function.
> > 
> > So the emu10k1.patch file attached fixes the problem and seems not to
> > introduce new ones.
> 
> Please, could you try this patch, if it also fixes your problem? Thanks.
> 
> 
> Index: emufx.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
> retrieving revision 1.26
> diff -u -r1.26 emufx.c
> --- emufx.c	31 Jan 2003 15:21:03 -0000	1.26
> +++ emufx.c	13 Feb 2003 20:29:55 -0000
> @@ -532,7 +532,7 @@
>  	if (diff) {
>  		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
>  			diff += runtime->boundary;
> -		pcm->sw_ready += diff;
> +		frames += diff;
>  	}
>  	pcm->sw_ready += frames;
>  	pcm->appl_ptr = appl_ptr + frames;
> 
> 						Jaroslav

It doesn't. sw_ready is negative (or above 2^31 as you like).

I think it has nothing to do with runtime->boundary since the 2 appl_ptr
are very close. The difference is always one period but I wonder why
runtime->control->appl_ptr is above pcm->appl_ptr. Is this because the
hardware has played one period that it shouldn't ?

On the other hand if the difference is really always of one period the
fix consists in conditioning the diff calculation with a
"if(frames != 0)" so that sw_ready never reaches its lower boundary.

Regards,

-- 
Arnaud


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
