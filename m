From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: [PATCH 2/2] ALSA sound driver
	for	the	AT73C213	DAC	using Atmel SSC driver
Date: Mon, 16 Jul 2007 16:46:58 +0200
Message-ID: <1184597218.15535.36.camel@localhost.localdomain>
References: <11845952993023-git-send-email-hcegtvedt@atmel.com>
	<11845952991232-git-send-email-hcegtvedt@atmel.com>
	<s5hbqeczb7k.wl%tiwai@suse.de>
	<1184595928.15535.26.camel@localhost.localdomain>
	<s5h7ip0zahr.wl%tiwai@suse.de>  <s5h4pk4za3q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id E25C61038D3
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2007 16:45:15 +0200 (CEST)
In-Reply-To: <s5h4pk4za3q.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kernel@avr32linux.org
List-Id: alsa-devel@alsa-project.org


On Mon, 2007-07-16 at 16:39 +0200, Takashi Iwai wrote:
> At Mon, 16 Jul 2007 16:30:56 +0200,
> I wrote:
> > 
> > At Mon, 16 Jul 2007 16:25:28 +0200,
> > Hans-Christian Egtvedt wrote:
> > > 
> > > 
> > > On Mon, 2007-07-16 at 16:15 +0200, Takashi Iwai wrote:
> > > > At Mon, 16 Jul 2007 16:14:59 +0200,
> > > > Hans-Christian Egtvedt wrote:

<cut driver description>

> > > > Are these intended to be merged to 2.6.23 kernel?
> > > 
> > > I would prefer that yes. AFAIK alsa-devel@ is the correct list for the
> > > sound drivers?
> > 
> > Yes.  Then the questions are:
> > - the driver is mature enough for the upstream merge,
> > - whether it's built and tested on the latest 2.6.22 (or more
> >   prefarably on the latest git) tree
> 
> Also,
> 
> - whether atmel-ssc driver would be merged to 2.6.23, too
>   (otherwise it makes no sense to merge only the corresponding ALSA
>    driver)

Agree, I have no feedback on the atmel-ssc driver yet. It should be a
trivial addition the the kernel.

-- 
With kind regards,

Hans-Christian Egtvedt, siv.ing. (M.Sc.)
Applications Engineer - AVR32 System Solutions - Atmel Norway
