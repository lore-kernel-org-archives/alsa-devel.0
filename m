From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-cvslog] CVS: alsa-lib/src/pcm pcm.c,1.271,1.272
Date: Tue, 2 Mar 2004 08:53:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403020850590.1995@pnote.perex-int.cz>
References: <E1AxjBQ-00059u-Nx@sc8-pr-cvs1.sourceforge.net> <4043A86C.4000406@tin.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4043A86C.4000406@tin.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@tin.it>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Mar 2004, Abramo Bagnara wrote:

> Jaroslav Kysela ha scritto:
> > Update of /cvsroot/alsa/alsa-lib/src/pcm
> > In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv19814
> > 
> > Modified Files:
> > 	pcm.c 
> > Log Message:
> > Fixed return comment for *near() functions
> > 
> > Index: pcm.c
> > ===================================================================
> > RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm.c,v
> > retrieving revision 1.271
> > retrieving revision 1.272
> > diff -u -r1.271 -r1.272
> > --- pcm.c	23 Feb 2004 10:34:17 -0000	1.271
> > +++ pcm.c	1 Mar 2004 08:53:50 -0000	1.272
> > @@ -3418,7 +3418,7 @@
> >   * \param pcm PCM handle
> >   * \param params Configuration space
> >   * \param val target channels count, returned chosen channels count
> > - * \return chosen channels count
> > + * \return 0 otherwise a negative error code if configuration space would become empty
> 
> *near() functions semantic cannot return error by design.
> 
> Taken for granted that configuration space on entry of function is not 
> empty how it can become empty if I ask for *nearest* value?
> 
> Obviously at least one configuration exists, then in the worst case such 
> value is returned.
> 
> Do you agree?

Ok, I replace the phrase with "if configuration space is empty".

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
