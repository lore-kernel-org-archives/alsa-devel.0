From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/core/oss mixer_oss.c,1.38,1.39
Date: Wed, 9 Mar 2005 10:20:58 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503091011430.15496-100000@studcom.urz.uni-halle.de>
References: <s5hhdjl5gv6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <s5hhdjl5gv6.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Summary: fix forgotten release of semaphore in error path
> >
> > In snd_mixer_oss_get_volume1_vol and snd_mixer_oss_put_volume1_vol,
> > card->controls_rwsem wouldn't be released if the boolean type
> > check fails.
> > ...
> > -	snd_runtime_check(uinfo->type != SNDRV_CTL_ELEM_TYPE_BOOLEAN || uinfo->value.integer.min != 0 || uinfo->value.integer.max != 1, return);
> > +	snd_runtime_check(uinfo->type != SNDRV_CTL_ELEM_TYPE_BOOLEAN || uinfo->value.integer.min != 0 || uinfo->value.integer.max != 1, goto __unalloc);
>
> IMO, it'd be better to use a plain if() rather than this macro.
> It lowers readability.

Yes, these lines are too long.

I made the minimal change to make it correct, just to be sure.  Feel
free to change it any way you want.  :-)


BTW: are there any plans to enforce the 80 columns limit of Linux
source code?  ;-)


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
