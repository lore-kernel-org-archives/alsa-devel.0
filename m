From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] wm8750: add missing VREF output
Date: Mon, 11 Aug 2008 12:47:28 +0100
Message-ID: <20080811114726.GE5560@sirena.org.uk>
References: <1218444346-19153-1-git-send-email-dbaryshkov@gmail.com>
	<1218444346-19153-2-git-send-email-dbaryshkov@gmail.com>
	<20080811091119.GC9668@rakim.wolfsonmicro.main>
	<48A0025C.6000903@gmail.com> <20080811101939.GB5560@sirena.org.uk>
	<s5h8wv3q1l2.wl%tiwai@suse.de>
	<20080811104204.GC5560@sirena.org.uk>
	<s5h63q7q183.wl%tiwai@suse.de>
	<20080811110046.GD5560@sirena.org.uk>
	<s5h1w0vpyup.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CAA224521
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 13:47:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1w0vpyup.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 11, 2008 at 01:36:46PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Sorry, there may have been a miscommunication here - this should only
> > *need* to go to 2.6.27 since the bulk registration functions are more

> Ah, OK.  So it's not for stable.  (A detailed changelog would be still
> better, though :)

Yeah, definitely.  

It's one of these things that gets mildly confusing in the -rc cycle -
from a development point of view there are bug fixes that should be
cherry picked down into the next stable release (so bug fixes targetted
at stable) but which don't go into the -stable process (which is a
different thing again).
