From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-cvslog] CVS: alsa-lib/src/pcm pcm.c,1.227,1.228
Date: Wed, 23 Oct 2002 19:38:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210231933090.5772-100000@pnote.perex-int.cz>
References: <3DB6DCE3.4452ABED@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DB6DCE3.4452ABED@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Oct 2002, Abramo Bagnara wrote:

> Jaroslav Kysela wrote:
> > 
> > Added ommited clear() functions
> > 
> > Index: pcm.c
> >  /**
> > + * \brief clear snd_pcm_hw_params_t structure
> > + * \param obj pointer to structure
> > + */
> > +void snd_pcm_hw_params_clear(snd_pcm_hw_params_t *obj)
> > +{
> > +       assert(obj);
> > +       memset(obj, 0, snd_pcm_hw_params_sizeof());
> > +}
> 
> Why that _clear functions?
> What's the expected semantic for "clear"?
> 
> When we designed new API I took in consideration them, but the lack of
> usefulness and the ambiguity of semantic has pushed me to avoid them.

Well, you're right that the name is misleading, but wouldn't be good to 
let to reuse a structure? Perhaps, _init suffix is better.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
