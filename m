From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 1/5] emu10k1 SB Live: Master volume and
	front channels via fxbus 8,9
Date: Fri, 25 Feb 2005 11:59:56 -0500
Message-ID: <1109350797.9681.30.camel@krustophenia.net>
References: <421A3A3A.6070009@glocalnet.net>
	 <Pine.LNX.4.58.0502220925540.1748@pnote.perex-int.cz>
	 <1109109856.31071.44.camel@krustophenia.net>
	 <Pine.LNX.4.58.0502230918440.1748@pnote.perex-int.cz>
	 <421C4586.5090000@glocalnet.net>
	 <Pine.LNX.4.58.0502230956490.1748@pnote.perex-int.cz>
	 <s5hwtszshhr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 11A9D23E
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2005 17:59:58 +0100 (MET)
In-Reply-To: <s5hwtszshhr.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org, "mikma@users.sourceforge.net" <mikma@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-02-23 at 11:22 +0100, Takashi Iwai wrote:
> IIRC, the problem was stated in the case that both front and
> multi-channel streams are output at the same time.
> 
> I think this patch is fine (although not tested yet).  At least, it
> will decrease the difference between Live and Audigy.

Agreed.  This should be applied, as soon as we have some successful test
reports.  I would like for it to be in 1.0.9.  But we should be careful
as so many patches will have gone into the emu10k1 driver since 1.0.8.

I'll test this on my SBLive this weekend.  And update some of the bug
reports so the users who were really bothered by this can give some
feedback.

Lee





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
