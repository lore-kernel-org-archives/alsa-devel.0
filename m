From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Audio on omap3+twl4030 codec
Date: Thu, 23 Oct 2008 12:04:51 +0300
Message-ID: <20081023120451.23b1971e.jarkko.nikula@nokia.com>
References: <ef0d8a250810220547u1b795313y47f964144591e97d@mail.gmail.com>
	<20081022131036.GG7640@sirena.org.uk>
	<ef0d8a250810220624u7396b496q7b86efa0703e7e15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 4371D244C1
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 11:05:59 +0200 (CEST)
In-Reply-To: <ef0d8a250810220624u7396b496q7b86efa0703e7e15@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Oct 2008 18:54:12 +0530
"ext naveen krishna ch" <naveenkrishna.ch@gmail.com> wrote:

> I forget to add one more observation
> that is i have a older omap2 and twl4030 asoc codec driver and driver/ssi
> mcbsp support in a 2.6.24 kernel.
> 
> when i try to use this in my coustum board the audio is working fine all the
> ways.
> 
> > > I am wokring on 2.6.26 whre the support was not there for omap3 mcbsp.
> > > so i ported some stuff from the 2.6.27 latest git tree and now audio is
> > > working on omap3 evm.
> > > with the very same kernel when i try with my custom board. I am unable to
> > > hear audoi.
> >
So to summarize:

- 2.6.26 + backported drivers on OMAP3 EVM -> audio works
- 2.6.26 + backported drivers on custom board with NAND boot -> no audio
- 2.6.26 + backported drivers on custom board with MMC boot -> audio
  works
- 2.6.24 (TI SDP release?) on custom board -> audio works

And I understood also that bootloader images were the same in all of
these cases. Did I get these correctly?

Is the rootfile system the same between these cases? I.e. that same
mixer settings like audio volumes etc. are used?

> Can anyone refer me towards the ones who worked on this kind of audio codec
> driver.
> 
Worth to ask also on linux-omap mailing list
(linux-omap@vger.kernel.org) since TI engineers are reading it.


Jarkko
