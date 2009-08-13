From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] new ad1836 codec driver based on asoc
Date: Thu, 13 Aug 2009 10:46:33 +0100
Message-ID: <20090813094633.GA21652@rakim.wolfsonmicro.main>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
	<20090812134645.GC11898@rakim.wolfsonmicro.main>
	<3c17e3570908122041m29a1843agd0f9fd0e415181c3@mail.gmail.com>
	<20090813090801.GA31504@sirena.org.uk>
	<3c17e3570908130237g34f34228v1d57d872dfba20ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D434243FC
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 11:46:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570908130237g34f34228v1d57d872dfba20ea@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2009 at 05:37:09PM +0800, Barry Song wrote:

> If so, all codec drivers need to save setting then restore them when
> resume. The physical shutdown depends on boards great. If we get an
> individual programmable PMU/LDO to control the voltage input to this
> chip, I can shutdown power-input to codec physically and save the
> registers when suspend,  then restore them when resume. If no this
> unit, should every codec driver handle this case?

Yes, every CODEC driver that supports suspend and resume needs to handle
this.  Since the CODEC drivers generally use a register cache it's
normally just a case of writing the values in the cache back to the
device at the start of resume.
