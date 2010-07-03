From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: issue with TWL4030
Date: Sat, 3 Jul 2010 01:06:36 +0100
Message-ID: <20100703000635.GA3533@sirena.org.uk>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 23FC224350
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Jul 2010 02:06:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 03, 2010 at 01:50:50AM +0300, Grazvydas Ignotas wrote:

> there seems to be a problem with TWL4030 hw_param programming, which
> is easy to reproduce over OSS emulation with this simple program:

OSS emulation is strongly disrecommended due to the fact that it
repeatedly reprograms things using partially valid configurations.  Some
drivers will refuse to run with it.

> So it looks like twl4030->configured is the culprit of this, removing
> it solves the problem, but I guess that will break something else. Any
> ideas how to properly fix this?

Usually the best thing is to sidestep the issue by avoiding using OSS.
