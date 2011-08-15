From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 0/5] RME RayDAT/AIO - enable period size of
	32 samples	(v2)
Date: Mon, 15 Aug 2011 11:42:32 +0200
Message-ID: <20110815094232.GM19500@ltw.loris.tv>
References: <20110814215943.GK19500@ltw.loris.tv>
	<1313360574-9891-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5h62lz6njt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C8BC24585
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 11:42:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h62lz6njt.wl%tiwai@suse.de>
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

On Mon, Aug 15, 2011 at 11:17:58AM +0200, Takashi Iwai wrote:

Hi!

> > Here is a series of patches that enable period sizes of 32 samples on
> > RME RayDAT and AIO cards. It also adds 8192 samples per period for MADI
> > and AES cards, this mode was present in the original driver but got lost
> > during the merge.
> 
> Thanks, applied now.
> 
> Meanwhile, I found more cleanups and fixes are possible.
> Could you check the patches I'll send later?

All reviewed and runtime tested. Everything's fine.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
