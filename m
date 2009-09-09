From: Ng Oon-Ee <ngoonee@gmail.com>
Subject: Re: Alsa plugin unable to be loaded by Pulseaudio
Date: Wed, 09 Sep 2009 22:16:02 +0800
Message-ID: <1252505762.2154.1.camel@localhost.localdomain>
References: <1252365377.11542.5.camel@localhost.localdomain>
	<4f3252890909090110n68cbecefnab64f953d4788850@mail.gmail.com>
	<1252502217.20038.3.camel@localhost.localdomain>
	<20090909135939.GA14530@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f171.google.com (mail-px0-f171.google.com
	[209.85.216.171])
	by alsa0.perex.cz (Postfix) with ESMTP id D50AD10384E
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 16:16:57 +0200 (CEST)
Received: by pxi1 with SMTP id 1so950437pxi.23
	for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2009 07:16:56 -0700 (PDT)
In-Reply-To: <20090909135939.GA14530@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-09-09 at 15:59 +0200, Lennart Poettering wrote:
> On Wed, 09.09.09 21:16, Ng Oon-Ee (ngoonee@gmail.com) wrote:
> 
> > The "test" device is defined as follows (should have put it in
> > initially).
> > 
> > pcm.test {
> >  type plug
> >  slave { pcm "hw:0,0" }
> > }
> > 
> > It works with aplay. My issue is that the pulseaudio server cannot load
> > alsa plugins since 1.0.20 (as far as I can tell, ubuntuforums has a
> > thread which suggested as such). When I queried the pulse ML, Lennart
> > posted the below reply, which I've forwarded here to alsa-devel.
> > 
> > Basically, the issue as Lennart sees it is summarized by his last 3
> > paragraphs (bottom of this mail). He specifies the difference between
> > the way alsa is reacting to pulse and the way it 'should'.
> 
> After the discussion we had on alsa-devel about the ordering how buffer
> size and period size are initialized i have now changed PA git to try
> harder to initialize those values. Would be good if you could check if
> that actually makes your problem go away.
> 
> Lennart
> 

Thanks Lennart. Gonna try it out now.
