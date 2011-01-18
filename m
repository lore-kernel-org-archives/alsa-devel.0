From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH - [hdspm] 2/3] Enable RME RayDAT and AIO
Date: Tue, 18 Jan 2011 16:24:08 +0100
Message-ID: <20110118152408.GV21889@ltw.loris.tv>
References: <1295359939-14673-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1295359939-14673-3-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hlj2igt1f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 825012472D
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 16:24:21 +0100 (CET)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 26E7F1AC62A
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 16:24:15 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1AxAoCnDmuIl for <alsa-devel@alsa-project.org>;
	Tue, 18 Jan 2011 16:24:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hlj2igt1f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 03:55:56PM +0100, Takashi Iwai wrote:

> > -#include <linux/math64.h>
> No math64 stuff is necessary?

Probably not. At least it works and compiles without. Perhaps
cross-included from somewhere else? I see div_u64 down there, so I guess
linux/math64.h should be included. Fixed.

> > +#include <linux/sysfs.h>
> It's not implemented yet, so don't include it.

ACK.

> > -static DEFINE_PCI_DEVICE_TABLE(snd_hdspm_ids) = {
> > +static struct pci_device_id snd_hdspm_ids[] __devinitdata = {
> Why open-coded again?

No particular reason. Now you mention it, I'll change it back.

How did it end up there?: I took the code from Florian's tarball. Looks
like there was some divergent development in the meantime (between his
fork and mainline kernel)

> > @@ -796,6 +1009,8 @@ static void hdspm_silence_playback(struct hdspm *hdspm)
> >  	int n = hdspm->period_bytes;
> >  	void *buf = hdspm->playback_buffer;
> >  
> > +	snd_printk(KERN_INFO "hdspm_silence_playback\n");
> Don't put such a verbose debug message in frequently called callbacks.

ACK. Removed.

> >  	n = div_u64(n, rate);
> >  	/* n should be less than 2^32 for being written to FREQ register */
> > -	snd_BUG_ON(n >> 32);
> > +	snd_BUG_ON((n >> 32) == 0);
> This check is consistent with the comment above...

Inconsistent I guess...?

I suggest to remove the line. We know n, we control rate, this should
never be an issue.


> The rest is too long to review. Would be nice if you can split the
> whole patch in logical orders...

I'm afraid I can't, because there's no logical order. There's just this
single hdspm.c (and .h) by Florian and my style fixes. No VCS.

So whatever is wrong needs to be spotted by some experienced ALSA dev. I
guess you'd be faster fixing it instead of mailing me all the things
that are wrong, but I'm happy to change things you point out.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
