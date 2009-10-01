From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Use codec mutex in dapm_set_pga()
Date: Thu, 1 Oct 2009 13:08:14 +0100
Message-ID: <20091001120814.GE19998@rakim.wolfsonmicro.main>
References: <1254377856-5588-1-git-send-email-ext-eero.nurkkala@nokia.com>
	<20091001103714.GB14417@sirena.org.uk>
	<1254394869.2472.25.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D60F31038F2
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:08:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254394869.2472.25.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 02:01:09PM +0300, Eero Nurkkala wrote:

> I still think the described scenario can happen. Or could
> you point where the mutex is taken earlier? If it was,
> I would've deadlocked every time....Maybe I'm missing
> some info.

Any of the control paths down from user space should be taking it.

> BTW, what's the reasoning for codec mutex anyway?

It protects all the data on the card - we've got a lot of
read/modify/write cycles going on, plus things like the power state
transitions which need to be run single threaded otherwise they'll get
therribly confused.  We could do something finer grained but it's never
been an issue.
