From: Ctirad Fertr <c.fertr@gmail.com>
Subject: Re: E-mu 1212M ADAT channels missing ?
Date: Mon, 19 Nov 2007 13:29:29 +0100
Message-ID: <200711191329.29885.c.fertr@gmail.com>
References: <675225.53975.qm@web51108.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from praha.adaptech.cz (r9bz245.net.upc.cz [78.102.77.245])
	by alsa0.perex.cz (Postfix) with ESMTP id DB86D24883
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 13:29:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by praha.adaptech.cz (Postfix) with ESMTP id D0D3DAFCF1
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 13:31:35 +0100 (CET)
Received: from praha.adaptech.cz ([127.0.0.1])
	by localhost (praha.adaptech.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYJCRRYzDN-3 for <alsa-devel@alsa-project.org>;
	Mon, 19 Nov 2007 13:31:30 +0100 (CET)
Received: from [192.168.0.58] (unknown [192.168.0.58])
	by praha.adaptech.cz (Postfix) with ESMTP id 198A6AFCBA
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 13:31:30 +0100 (CET)
In-Reply-To: <675225.53975.qm@web51108.mail.re2.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne Monday 19 of November 2007 03:04:15 Kenneth Long napsal(a):
> yeah, that is it.. it use to be hw 0,0.  Its now 0,2.
>
> There seems to be a lot more xruns now...
> is that from something new?
> my kernel is now 2.6.23-gentoo-r1

There shouldn't be any changes in this aspect. Try to increase size of jack 
buffers and check if jack samplerate matches samplerate in alsamixer. 

------
Ctirad



> thank you.
>
> --- Ctirad Fertr <c.fertr@gmail.com> wrote:
> > Dne Sunday 18 of November 2007 05:54:37 Kenneth Long
> >
> > napsal(a):
> > > I'm using qjackctl to launch jackd and before, I
> >
> > would
> >
> > > see the PCM channels appear under "Connect"
> >
> > button.
> >
> > > Alsa_pcm only shows two channels "capture_1 and
> > > capture_2. Before there were 16 channels...
> >
> > Do you use correct capture device in qjackctl? The
> > correct device for
> > multichannel capture is 0,2 (in case your card is
> > 0).
> >
> > ------
> > Ctirad
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
>
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>
> hello
