From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: ALC892 optical SPDIF not working
Date: Sun, 1 Aug 2010 01:32:23 +0200
Message-ID: <20100731233223.GA19209@wormhole>
References: <AANLkTimvFz0wW02WGzTx1iei_jOoaXgO=iGopE_n2-+C@mail.gmail.com>
	<s5hmxt9qqlv.wl%tiwai@suse.de>
	<AANLkTi=QxpJSyXgNH+WeUQdTo0kVNuPN73F-iXW5meAa@mail.gmail.com>
	<AANLkTim=_kdSJJ1NSW2D5X7GVWp=8ffwKqSbdQ9MqjMb@mail.gmail.com>
	<s5hvd7xp4dh.wl%tiwai@suse.de>
	<AANLkTin+BUQr0iVq3MT+O-dA6PYyZZF_QVcEdoM-xK9p@mail.gmail.com>
	<1280596972.4074.1.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id CACD22466C
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 01:32:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280596972.4074.1.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > >> Is there a way to insert an initial playback delay?  Under linux, the
> > >> first 2-2.5 seconds
> > >> of anything played are just silence; on windows audible playback
> > >> starts immediately.
> > >
> > > It's the time for synchronization your digital receiver takes, I guess.
> > > Maybe changing SPDIF status makes it resync, which happens at each
> > > opening / closing the stream.
> > 
> > Yes, seems so. I've found a workaround in meantime.
> 
> Could you elaborate on the workaround please, so others having this
> issue know it.

My receiver allows to mix analog and digital inputs; with analog mix
enabled it syncs immediately.

Manuel
