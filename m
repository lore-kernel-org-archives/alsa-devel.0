From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: emu10k1 bug and patch (0.9.0rc7)
Date: Fri, 14 Feb 2003 13:51:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302141349500.1222-100000@pnote.perex-int.cz>
References: <s5hptpvjjzo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptpvjjzo.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Arnaud de Bossoreille de Ribou <arnaud.debossoreille@via.ecp.fr>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "bozo@via.ecp.fr" <bozo@via.ecp.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, 14 Feb 2003, Takashi Iwai wrote:

> At Thu, 13 Feb 2003 21:30:17 +0100 (CET),
> Jaroslav wrote:
> > 
> > On Mon, 10 Feb 2003, Arnaud de Bossoreille de Ribou wrote:
> > 
> > > So the bug looks like a signedness problem since sw_ready is unsigned
> > > and there is a while(sw_ready > 0), which explain the constant delay,
> > > next in the "snd_emu10k1_fx8010_playback_transfer" function.
> > > 
> > > So the emu10k1.patch file attached fixes the problem and seems not to
> > > introduce new ones.
> > 
> > Please, could you try this patch, if it also fixes your problem? Thanks.
> 
> i don't think the patch fixes the original problem.
> if there are only two periods, the diff will be either period_size or
> -period_size, i.e. (buffer_size/2) or -(buffer_size/2).
> 
> assume the buffer size = 200
> 	appl_ptr
> 
> 	0
> 
> 	100	diff = 100 - 0 = 100
> 
> 	0	diff = 0 - 100 = -100
> 
> 	100
> 
> 
> >  	if (diff) {
> >  		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
> >  			diff += runtime->boundary;
> > -		pcm->sw_ready += diff;
> > +		frames += diff;
> >  	}
> 
> and since boundary = buffer_size as default, the above condition will
> be not satisfied (i.e. diff is equal with -(runtime->boundary/2) and
> it is never smaller).

The boundary is close to LONG_MAX and 'buffer_size * N = boundary'
condition is always true. We have enough space to detect the proper
rewind/boundary crosses. Isn't it?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
