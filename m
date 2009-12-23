From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: need help with io plugin programming: how to
	add	delay ?
Date: Wed, 23 Dec 2009 17:09:35 +0000
Message-ID: <20091223170934.GA21444@sirena.org.uk>
References: <4B312435.800@gmail.com> <4B315163.5090404@gmail.com>
	<53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>
	<4B31D184.3020300@gmail.com>
	<53baa24a0912230128p5fee628en39b7b81f45e9fb9c@mail.gmail.com>
	<4B31FC67.2090201@gmail.com> <4B3247B4.4000506@kiilerich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 547DD1038AF
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 18:09:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B3247B4.4000506@kiilerich.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mads Kiilerich <mads@kiilerich.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Stefan Schoenleitner <dev.c0debabe@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 23, 2009 at 05:39:16PM +0100, Mads Kiilerich wrote:
> Stefan Schoenleitner wrote, On 12/23/2009 12:08 AM:

> > I mean how should it work with an alsa plugin if not even this simple simulation code works
> > in a timely and precise manner ?

> > * What am I doing wrong ?

> > I thought of adding buffering so that the socket read operations do not have a strict timing schedule.

At this point you're not really dealing with ALSA issues at all, the
scheduling of tasks in Linux is handled by the core kernel scheduler
code.  Rather than looking at the audio APIs it seems like you'd be
better off looking at either reducing your dependency on highly accurate
scheduling or looking at how to work best with the scheduler to get the
best possible performance from it.

> > It is connected over UART at 460800 baud and requires exactly 160 16bit PCM samples
> > with 8kHz sampling rate each 20ms for speech compression.

> It is my experience that it matters that two different oscillators never 
> have exactly the same frequency, so over time you will get an over- or 
> under-run.

Indeed.  If you've got two different clock domains and no way of lining
them up you'll eventually get drift between the two sufficient to cause
an under or overrun if you run for long enough without a break.
