From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: how to define a 2-index control element?
Date: Wed, 08 May 2002 00:06:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD84FDC.1056ACA1@alsa-project.org>
References: <200205071717.g47HH3D25608@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.libero.it (smtp2.libero.it [193.70.192.52])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA27036
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 00:06:49 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >> If someone has hardware with 1400+ controls, than memory allocation issue
> >> is out of question. I wrote that we can optimize current code - add some
> >> hash tables for faster lookups for example.
> >
> >well, about 200kB is not so big nowadays :)
> >
> >i thought the hardware doesn't need allocate 1400 controls - the
> >controls are identical but have different indices.
> >in such a case, the indexed-access would be most straightforward.
> >no hash, no list.
> 
> precisely. in fact, there are:
> 
>            1456 mixer controls
>            52   RMS meters
>            80   peak meters
> 
> for the mixer controls, they form a matrix that is accessed by
> index. for the meters, they form unidimensional arrays that are also
> accessed by index.
> 
> i think any talk of allocating 1 control per "semantic control" is
> crazy. its clear that these controls should be accessed as a matrix
> type. they were designed by the h/w people as a matrix, and its been
> ALSA's policy to have the kernel API mirror h/w designs and
> capabilities.

Sorry to say that, but I think this is a nonsense.

Many cards have element organized in register with an index (you might
say an "array"), but this is definitely not a reason to implement it in
a different way.

We have well designed control keys (id) and I don't see any reason to
change something that's perfectly suitable (without any compromise) for
the job.

We have the sane association one control / one value and just because
this card has many controls, you seems to wish to go toward a different
(IMO insane and confusing) solution.

Consider that independently from how you represent the data this card
will ever have many controls (i.e. many values to show/change).

I definitely don't see your point, sorry.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
