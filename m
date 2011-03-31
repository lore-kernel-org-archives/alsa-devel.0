From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Question about your DSP topic
Date: Thu, 31 Mar 2011 22:37:21 +0100
Message-ID: <1301607441.3549.217.camel@odin>
References: <4D2652C8.7030701@codeaurora.org>
	<4D939519.6040506@codeaurora.org> <1301595977.3549.7.camel@odin>
	<4D94EB35.4070206@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A184C10380D
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 23:37:25 +0200 (CEST)
Received: by wyg36 with SMTP id 36so2623445wyg.38
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2011 14:37:25 -0700 (PDT)
In-Reply-To: <4D94EB35.4070206@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-03-31 at 13:59 -0700, Patrick Lai wrote:
> > > I've not seen that one yet and we have a similar route on OMAP4. Is it
> > repeatable 100% or just some of the time. It would also be useful to
> > post your oops message and I'll take a closer look.
> >
> > I'm due to push an squashed update to my dsp branch later tonight in
> > prep for upstream. Could you also check soc-dsp.c against this copy,  it
> > may be that something that was lost in the backport ?
> >
> It's 100% reproducible. I sync to your branch last week so soc-dsp.c
> should be in sync. Since it's not blocking me, I will wait for
> your update and see if new change in soc-dsp.c makes any difference
> Otherwise, I will send you log off line.
> 

Just pushed. Thanks, could you also include the sequence of commands
(e.g. aplay, amixer etc used to cause the error)

Thanks

Liam

> > Liam
> >
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
