From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [Alsa-user] linking breaks for rc3
Date: Fri, 23 Aug 2002 14:15:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208232115.OAA17594@cmn29.stanford.edu>
References: <4.3.1.2.20020823122127.016190b0@phosphor.cipic.ucdavis.edu>
	<20020823223148.314aa536.ketelaars@wanadoo.nl>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020823223148.314aa536.ketelaars@wanadoo.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > It generates many " multiple definition of" errors all related to isapnp
> > definitions.
> >
> > For example
> >
> > pcm_sgbuf.o: In function `isapnp_resource_change_R09b965af':
> > pcm_sgbuf.o(.text+0x70): multiple definition of
> > `isapnp_resource_change_R09b965af'
> >
> > I ran ./configure --with-isapnp=no and still generated these errors.
> >
> > Any suggestions?
>
> Latest news at: http://www.alsa-project.org/ :
>
> 2002-08-22  Note for compiling alsa-driver-0.9.0rc3: Please remove the
> file - alsa-driver-0.9.0rc3/include/linux/isapnp.h - before running the
> configure script. HTH :)

Is there a particular problem I don't understand with
releasing a rc3a (or whatever) tarfile that has this file
removed? This will keep happening and a note on the site is
not enough (IMHO). A tarfile should at least compile cleanly
and if not, it should be fixed asap.

-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
