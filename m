From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: [alsa-cvslog] CVS: alsa-lib/src/pcm pcm.c,1.227,1.228
Date: Wed, 23 Oct 2002 19:31:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB6DCE3.4452ABED@libero.it>
References: <E180L07-0002h2-00@usw-pr-cvs1.sourceforge.net>
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> Added ommited clear() functions
> 
> Index: pcm.c
>  /**
> + * \brief clear snd_pcm_hw_params_t structure
> + * \param obj pointer to structure
> + */
> +void snd_pcm_hw_params_clear(snd_pcm_hw_params_t *obj)
> +{
> +       assert(obj);
> +       memset(obj, 0, snd_pcm_hw_params_sizeof());
> +}

Why that _clear functions?
What's the expected semantic for "clear"?

When we designed new API I took in consideration them, but the lack of
usefulness and the ambiguity of semantic has pushed me to avoid them.


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
