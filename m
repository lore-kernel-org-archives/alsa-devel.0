From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Subject: Re: PCM Rate Plugin
Date: Fri, 12 Apr 2002 13:16:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0204121312350.95907-100000@fest.stud.fee.vutbr.cz>
References: <Pine.LNX.4.33.0204120916570.581-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0204120916570.581-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Apr 2002, Jaroslav Kysela wrote:

> On Fri, 12 Apr 2002, Kasparek Tomas wrote:
>
> > > well, then it's a bug of alsa-lib.
> > > could you explain the symptom more precisely?
> >
> > I have solved this yet. Original behavior (using "pcm.default") was:
> >
> > - using rate supported by card -> mono and stereo capture works
> >
> > - using non-standard rate -> just stereo works (that is native for the UDA
> >   chip), for Mono "arecod" produces just 44bytes of header.
>
> It should work in both cases. I suspect for a bug in alsa-lib. Can you
> trigger this bug also in snd-dummy driver? Can you send me modified dummy
> driver then?

I will try it.

> > Weel, I would like to ask one more question: The chip sipport not only
> > 16bit(LE) samples but 18 and 20 bits LE samples too. Would it be hard to
> > update ALSA to support these sample sizes? Where should I look for
> > informations when trying to get this running?
>
> How are these samples organized? They are stored in 32-bit words or
> something else?

I did't tried yet, but from the documentation I suppose they are stored in
18/20-bit words. All transfer is done via serial line, so after DMA
transfer you probably get these 18/20bit words without any padding.

I will try this too and send results.

Bye

--

	Tomas Kasparek (sioux, xkaspa06)
 	 tomas.kasparek@[seznam.cz,volny.cz]
	 linux@fit.vutbr.cz
	student FIT VUT Brno
