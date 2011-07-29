From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 3/3] hdsploader: Temporary define for RPM
Date: Fri, 29 Jul 2011 17:50:17 +0200
Message-ID: <20110729155017.GW19500@ltw.loris.tv>
References: <1311889548-28617-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1311889548-28617-4-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hk4b163fb.wl%tiwai@suse.de> <s5hhb6563do.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FB691037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 17:50:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hhb6563do.wl%tiwai@suse.de>
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

On Fri, Jul 29, 2011 at 07:51:31AM +0200, Takashi Iwai wrote:

Hi!

> > > +# define RPM	5
> > > +#endif
> > 
> > Now (after committing it), I found that it should be 4 instead of 5...?
> 
> Also, the corresponding firmware file isn't found in alsa-firmware tree.
> Could you submit it, too?

http://git.alsa-project.org/?p=alsa-firmware.git;a=tree;f=hdsploader;hb=HEAD

There is rpm_firmware.bin, exactly the one we need.


Or am I missing something?


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
