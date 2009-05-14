From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: AC97 reset fail after suspend
Date: Thu, 14 May 2009 13:32:41 +0100
Message-ID: <20090514123241.GL28291@sirena.org.uk>
References: <200905080148.20137.sleep_walker@suse.cz>
	<200905140357.35682.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CCBC5103916
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 14:32:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905140357.35682.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Tomas 'Sleep_Walker' Cech <sleep_walker@suse.cz>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 03:57:35AM +0200, Marek Vasut wrote:

> The following patch fixes the issue and should be correct. It's indeed a 
> regression that's not in wm9713, but is in wm9712. Please consider applying.

Please CC maintainers on patches!

> The following patch fixes problem with wm9712 codec being unable to resume from
> sleep because it doesn't respond after AC97 port was coldreseted (which is done
> in case the warmreset wasn't successful). The solution uses similar approach as
> wm9713, that is, do one more warmreset after coldreset.

Are you sure this is required?  The WM9713 needs this because the
default state on reset is not to clock the AC97 link, a warm reset is
needed to start the link.  I'll need to check but IIRC the WM9712 runs
the link by default and I can't see any changes to this behaviour in the
driver changelog.
