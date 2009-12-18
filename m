From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: 2.6.32-gitX: oops in ac97 codec registration
Date: Fri, 18 Dec 2009 10:46:50 +0000
Message-ID: <20091218104649.GA19544@sirena.org.uk>
References: <f861ec6f0912170040m57874014s7b1a6bb3b863c0f1@mail.gmail.com>
	<20091217105559.GC20667@rakim.wolfsonmicro.main>
	<f861ec6f0912170831r16b98515u7afdc68fcbb64fcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B547110380A
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 11:46:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f861ec6f0912170831r16b98515u7afdc68fcbb64fcd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 17, 2009 at 05:31:14PM +0100, Manuel Lauss wrote:
> On Thu, Dec 17, 2009 at 11:56 AM, Mark Brown

> > The generic AC97 bodge code is broken. ?Again. ?I've not checked the
> > ordering requirements here but reversing the order of snd_soc_new_pcms()
> > and snd_ac97_bus() in ac97_soc_probe() might do the trick.

> It's not that easy; seems something else is fishy.  I even get an oops with
> I2S.  I'll try to find out what's going on (the same code works on
> vanilla 2.6.32
> though).

Ah, oh dear.  That sounds like it'll be something platform specific -
I'd expect to have heard about it if it was more widespread, and my
tests have certainly been OK.
