From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: [alsa-cvslog] CVS: alsa-lib/src/pcm pcm.c,1.227,1.228
Date: Wed, 23 Oct 2002 19:51:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB6E19D.2241271D@libero.it>
References: <Pine.LNX.4.33.0210231933090.5772-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Wed, 23 Oct 2002, Abramo Bagnara wrote:
> 
> > Jaroslav Kysela wrote:
> > >
> > > Added ommited clear() functions
> > >
> > > Index: pcm.c
> > >  /**
> > > + * \brief clear snd_pcm_hw_params_t structure
> > > + * \param obj pointer to structure
> > > + */
> > > +void snd_pcm_hw_params_clear(snd_pcm_hw_params_t *obj)
> > > +{
> > > +       assert(obj);
> > > +       memset(obj, 0, snd_pcm_hw_params_sizeof());
> > > +}
> >
> > Why that _clear functions?
> > What's the expected semantic for "clear"?
> >
> > When we designed new API I took in consideration them, but the lack of
> > usefulness and the ambiguity of semantic has pushed me to avoid them.
> 
> Well, you're right that the name is misleading, but wouldn't be good to
> let to reuse a structure? Perhaps, _init suffix is better.

This is fine if we state in documentation that the object will go in the
same state than after OBJ_alloca/OBJ_malloc.

In this case I think that we have to change the memset in the OBJ_alloca
and OBJ_malloc function to OBJ_init call.

That apart there are some OBJs for which the _init function is nonsense.
snd_pcm_hw_params and snd_pcm_sw_params are among that.

The only sensible initializers for snd_pcm_hw_params are the existing
snd_pcm_hw_params_any and snd_pcm_hw_params_current.
Same for snd_pcm_sw_params_current.

To resume: I think that your proposal may have some reason for some OBJ
(but I'm not sure that in this specific ALSA context they exist), but I
think that to have it for OBJs with sane initializer is wrong.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
