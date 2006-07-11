From: Diego Calleja <diegocg@gmail.com>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 13:18:05 +0200
Message-ID: <20060711131805.543307f8.diegocg@gmail.com>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	<20060710235934.GC26528@dspnet.fr.eu.org>
	<1152578344.21909.12.camel@mindpipe>
	<20060711085952.f1254229.atlka@pg.gda.pl>
	<Pine.LNX.4.61.0607110937160.9147@tm8103.perex-int.cz>
	<20060711110811.947e15ed.atlka@pg.gda.pl>
	<Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24D54B7
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 13:18:14 +0200 (MEST)
Received: by ug-out-1314.google.com with SMTP id k40so1688394ugc
	for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2006 04:18:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, galibert@pobox.com, linux-kernel@vger.kernel.org, rlrevell@joe-job.com, atlka@pg.gda.pl, alan@lxorguk.ukuu.org.uk
List-Id: alsa-devel@alsa-project.org

El Tue, 11 Jul 2006 11:52:56 +0200 (CEST),
Jaroslav Kysela <perex@suse.cz> escribi=F3:


> > Kernel redirector is not a bad solution - there should be some kind of =

> > interface for such redirectors for different purposes. netlink device =

> > maybe? For example you should redirect all these traffic to some RT =

> > daemon doing all job.
> =

> I would prefer probably a network lowlevel ALSA driver. You'll get the =

> network transparency as benefit.


Shouldn't the plan9 filesystem (the implementation merged in Linux) be able
to do networking transparency already? It should be able to export /dev
devices nodes through the network transparently, AFAIK.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
