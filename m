From: Caleb Crome <caleb@crome.org>
Subject: Re: Need general idea how to architect driver for
 multi-codec board
Date: Fri, 3 Jun 2011 16:35:29 -0700
Message-ID: <BANLkTiniLox-47TAx3tX0EPr9QQ8gPfv+g@mail.gmail.com>
References: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
	<20110511175021.GB22798@sirena.org.uk>
	<BANLkTi=arRRqPEDS9S=-ynM_1d8N_A=d+w@mail.gmail.com>
	<20110527012756.GA26768@sirena.org.uk>
	<BANLkTinM_MigPxzY4WCBZhjRPwuV15b9gQ@mail.gmail.com>
	<20110528013355.GD5971@opensource.wolfsonmicro.com>
	<BANLkTinhMP143K5mAPPPc_R6N7Wxk8zZ3g@mail.gmail.com>
	<20110603084814.GB21286@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.212.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 939B524474
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jun 2011 01:35:31 +0200 (CEST)
Received: by pxi10 with SMTP id 10so1609022pxi.8
	for <alsa-devel@alsa-project.org>; Fri, 03 Jun 2011 16:35:29 -0700 (PDT)
In-Reply-To: <20110603084814.GB21286@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Okay,
   I finally got my system going -- in a *very* kludgy way.  I re-write
tlv320aic3x.c to include all the codecs.  Its nasty and ugly and horrible,
but it works with no changes to the kernel soc architecture.

Thanks for your help Mark!

I'll start another thread for proposed changes to the core so that this can
be done properly.

Thanks again,
  -Caleb
