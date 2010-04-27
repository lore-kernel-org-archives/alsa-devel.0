From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC	drivers
Date: Tue, 27 Apr 2010 21:50:04 +0100
Message-ID: <20100427205004.GB15083@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2pfa686aa41004271327v1658e33bgd170ecc9735f285b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7914A2433C
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 22:50:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <j2pfa686aa41004271327v1658e33bgd170ecc9735f285b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 02:27:42PM -0600, Grant Likely wrote:
> On Tue, Apr 27, 2010 at 4:09 AM, Benjamin Herrenschmidt

> > I don't have bandwidth to contribute much in this discussion right now,
> > at least not to lead it, so I'm happy to let others do so, but I'm happy
> > to provide feedback from my own experience as proposals are made.

> Unfortunately, I'm in the same boat.  :-(  However, I'll be at UDS in
> 2 weeks time, and I know audio is a big concern for the Ubuntu folks.
> A bunch of the ARM vendors will be there too.  I'll schedule a session
> to talk about audio bindings and hopefully that way make some headway
> on defining a binding that makes sense and is actually useful.

Hrm, the only issue that's been raised upstream is multi-CODEC (there
are one or two other things that boil down to multi-CODEC, but nothing
else I'm aware of).  If you schedule something please announce it here,
I believe that UDS generally has arrangements for remote participation.

Note that most of the complexity explosion you'll see here is visible in
things like phones more than the sort of devices you'd run Ubuntu on
currently and much of it isn't really visible to a lot of the CPU
vendors at all since it's generally all handled off the CPU.
