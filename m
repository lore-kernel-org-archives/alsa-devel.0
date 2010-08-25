From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 25 Aug 2010 11:43:03 +0100
Message-ID: <1282732983.2991.161.camel@odin>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
	<alpine.LNX.2.00.1008231907170.10278@eeebox2.perex-int.cz>
	<1282640988.3053.43.camel@odin>
	<alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BE43C103807
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 12:43:09 +0200 (CEST)
Received: by wyb32 with SMTP id 32so424000wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2010 03:43:08 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-25 at 11:35 +0200, Jaroslav Kysela wrote:
> On Wed, 25 Aug 2010, Liam Girdwood wrote:
> 
> >> Next step may be to support the 'amixer' like syntax for the control and
> >> mixer element handling.
> >
> > Btw, we need to try and avoid using the control ID in any mixer syntax.
> > I found that minor driver changes could change ID numbering meaning
> > major updates to config files. The mixer names are pretty constant and
> > using them has been quite painless.
> 
> Definitely. I meant the full control identifier (not just numid).
> 

btw, have started any of the other API changes in use-case.c yet ?

I could make changes to the parser .....

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
