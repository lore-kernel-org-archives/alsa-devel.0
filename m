From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] Null suspend/resume functions
Date: Thu, 19 Nov 2009 11:21:03 +0000
Message-ID: <20091119112102.GF9763@rakim.wolfsonmicro.main>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<20091109105858.GB1245@sirena.org.uk>
	<20091109133136.GC1245@sirena.org.uk>
	<20091116153000.GB29479@sirena.org.uk>
	<20091117115236.GB1376@ucw.cz>
	<20091117124125.GD823@rakim.wolfsonmicro.main>
	<20091118160908.GD20887@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1056B24539
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 12:21:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091118160908.GD20887@elf.ucw.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-kernel@vger.kernel.org, Magnus Damm <damm@opensource.se>, alsa-devel@alsa-project.org, linux-pm@lists.linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 18, 2009 at 05:09:08PM +0100, Pavel Machek wrote:
> On Tue 2009-11-17 12:41:25, Mark Brown wrote:

> > The problem I have with that is that for most APIs noop functions are a
> > big fat warning sign that something is going wrong and the API is being
> > abused.  This then creates noise and code review problems in the driver
> > code since you've got something that normally suggests a problem.

> That still sounds like poor reason to add tests to core. But return 0
> function for that purpose should be ok (and should make code easy to
> review, too).

What makes you believe that this is a poor reason?  The issue isn't that
the driver code is complex, the issue is that it's noise in the driver
which suggests that the driver isn't doing something it's supposed to
do.
