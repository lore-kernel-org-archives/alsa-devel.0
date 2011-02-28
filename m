From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 0/6] hdspmixer fixes
Date: Mon, 28 Feb 2011 15:03:45 +0100
Message-ID: <20110228140345.GR15327@ltw.loris.tv>
References: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5h39n8qxdb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id B30C610385E
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 15:04:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h39n8qxdb.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 28, 2011 at 11:14:40AM +0100, Takashi Iwai wrote:

> > Also, the old code never handled three cards correctly, but that's
> > fixed, too. (and tested against the three RME cards currently in my
> > workstation)
> Thanks, applied now to alsa-tools git tree.

TNX.

> Though, the static definitions in channel_mapping.h aren't ideal.
> If these are referred from difference places, they should be external
> and defined only once.

I'm not sure what you mean. Do you suggest to make them external inside
hdspmixer? Like with pixmaps.h? Or are you contemplating to put them
somewhere else, let's say hdspm.h? (Uh, let's not say hdspm.h ;) )

> Currently, you'll get tons of compile warnings.
> Care to fix these?

Fixed now.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
