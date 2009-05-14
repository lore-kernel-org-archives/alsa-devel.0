From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: AC97 reset fail after suspend
Date: Thu, 14 May 2009 15:26:07 +0100
Message-ID: <20090514142606.GN28291@sirena.org.uk>
References: <200905080148.20137.sleep_walker@suse.cz>
	<200905140357.35682.marek.vasut@gmail.com>
	<20090514123241.GL28291@sirena.org.uk>
	<200905141551.37422.marek.vasut@gmail.com>
	<20090514142509.GM28291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 377EA10398E
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 16:26:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090514142509.GM28291@sirena.org.uk>
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

On Thu, May 14, 2009 at 03:25:10PM +0100, Mark Brown wrote:

> the second option, I guess.  A version of your patch would be good, but
> it should check for warm reset support in the AC97 controller before it
> tries to use it since the chip won't always need the warm reset.

Oops, it does already - I'll apply it with an updated changelgo
explaining what's going on.
