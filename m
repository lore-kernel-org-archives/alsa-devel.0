From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Memory corruption in ASoC
Date: Thu, 18 Mar 2010 17:35:37 +0000
Message-ID: <1268933737.3773.36.camel@odin>
References: <20100318161755.GJ30801@buzzloop.caiaq.de>
	<20100318164305.GB6142@rakim.wolfsonmicro.main>
	<20100318164853.GK30801@buzzloop.caiaq.de>
	<20100318170745.GC6142@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id ABBD424397
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 18:35:38 +0100 (CET)
Received: by pwj7 with SMTP id 7so1668263pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 10:35:37 -0700 (PDT)
In-Reply-To: <20100318170745.GC6142@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-18 at 17:07 +0000, Mark Brown wrote:
> On Thu, Mar 18, 2010 at 05:48:53PM +0100, Daniel Mack wrote:
> > On Thu, Mar 18, 2010 at 04:43:06PM +0000, Mark Brown wrote:
> 
> > > It should really be per-substream, yes.
> 
> > Do you want me to fix this or are you working on this already?
> 
> I'm all in favour of approaches that involve me doing less work :)
> Though watch out for a mail from Liam shortly...
> 

Please do.

Fwiw we do have some unnecessary complexity in our hw_params() and
hw_free() calls in order to support OSS emulation. i.e. hw_params() can
be called several times for each substream by OSS emulation with
different audio parameters each time (hence the need to always free and
re-config resources). This is not needed for native alsa.

Mark and I have just agreed we will accept patches that remove this sort
of complexity and hence OSS emulation support. OSS is being dropped by
distro's anyway now and we haven't been testing OSS emu on new ASoC
drivers for a while either.....  

So don't feel obliged to support OSS emulation in your fix.

> > I know there are some pxa-ssp related things pending which will also
> > cause merge conflicts - which tree should thing apply to currently?
> 


The major work Mark mentioned is the multi-codec + multi-platform (Audio
Engine) support. Mark and I are just finalising the API changes and
there is some a development branch here :-

http://git.kernel.org/?p=linux/kernel/git/lrg/asoc-2.6.git;a=shortlog;h=refs/heads/topic/multi-codec

The API move things closer the the driver model and are being aimed at
2.6.35.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
