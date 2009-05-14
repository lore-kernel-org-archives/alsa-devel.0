From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: AC97 reset fail after suspend
Date: Thu, 14 May 2009 15:51:37 +0200
Message-ID: <200905141551.37422.marek.vasut@gmail.com>
References: <200905080148.20137.sleep_walker@suse.cz>
	<200905140357.35682.marek.vasut@gmail.com>
	<20090514123241.GL28291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id E426910396B
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 15:51:34 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1631131ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 06:51:34 -0700 (PDT)
In-Reply-To: <20090514123241.GL28291@sirena.org.uk>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Tomas 'Sleep_Walker' Cech <sleep_walker@suse.cz>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thursday 14 of May 2009 14:32:41 Mark Brown wrote:
> On Thu, May 14, 2009 at 03:57:35AM +0200, Marek Vasut wrote:
> > The following patch fixes the issue and should be correct. It's indeed a
> > regression that's not in wm9713, but is in wm9712. Please consider
> > applying.
>
> Please CC maintainers on patches!

Sorry, it was 4am when I sent this patch, I was a little tired.
>
> > The following patch fixes problem with wm9712 codec being unable to
> > resume from sleep because it doesn't respond after AC97 port was
> > coldreseted (which is done in case the warmreset wasn't successful). The
> > solution uses similar approach as wm9713, that is, do one more warmreset
> > after coldreset.
>
> Are you sure this is required?  The WM9713 needs this because the
> default state on reset is not to clock the AC97 link, a warm reset is
> needed to start the link.  I'll need to check but IIRC the WM9712 runs
> the link by default and I can't see any changes to this behaviour in the
> driver changelog.

Well without this, the codec doesn't kick in (reading the registers returns 
all zeros) so I assume that's the same issue as on wm9713.
