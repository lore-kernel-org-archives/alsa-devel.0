From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: Re: es1938 - patch trying to improve capture hw
	pointer	reads
Date: Thu, 24 Jan 2008 16:21:02 +0100
Message-ID: <20080124152102.GE8290@lemon.iwr.uni-heidelberg.de>
References: <20080123003512.GA6828@lemon.iwr.uni-heidelberg.de>
	<s5hr6g74f8d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de
	[129.206.100.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D6E324362
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 16:21:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr6g74f8d.wl%tiwai@suse.de>
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

On Thu, Jan 24, 2008 at 12:47:46PM +0100, Takashi Iwai wrote:
...
> Thanks for the patch.
> The change look OK to me.  Another idea would be to use DMAADDR only
> when DMACOUNT goes mad.

The problem is to decide when you have read garbage from DMACOUNT.
DMAADDR is better in the first place, because you know the range
in 24 bit which is valid (DMACOUNT is 16bit only). But my patch tries
to make the failure probability much more lower by reading and comparing
both, so from which one you calculate the pointer at the end is only 
a cosmetic issue.

> But the back-off to the last pointer is
> propbably a safer solution.

I'm glad to hear the alsa design allow's this trick - or is
that even the recommeded way to deal with when the hardware pointer
could be temporarily not determined ?

> The patch is, however, unable to apply as is because of coding style
> problems.  Try $LINUXKERNEL/scripts/checkpatch.pl, fix what are
> suggested there, and repost the patch together with your sign-off.

Will do that when I digged trough the details (have to learn about signing).

Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
