From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Fix cs4270 error path
Date: Tue, 30 Sep 2008 11:38:55 +0200
Message-ID: <20080930113855.10717f1d@hyperion.delvare>
References: <20080831144214.62a17be6@hyperion.delvare>
	<ed82fe3e0809290642l358dab29r274ba97d5bd4b473@mail.gmail.com>
	<s5hhc7zjc6k.wl%tiwai@suse.de>
	<20080930103137.52b428a6@hyperion.delvare>
	<s5hfxniypz3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E7DC92442C
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 11:39:03 +0200 (CEST)
In-Reply-To: <s5hfxniypz3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Tue, 30 Sep 2008 10:53:20 +0200, Takashi Iwai wrote:
> At Tue, 30 Sep 2008 10:31:37 +0200,
> Jean Delvare wrote:
> > I fear there's some confusion there. There are two different patches
> > fixing error paths in cs4270. One fixing a fallout from the new-style
> > i2c driver conversion (in cs4270_i2c_probe), under name "ASoC: Fix
> > another cs4270 error path". This one you pushed to Linus last night.
> > 
> > But there's another one, named "ASoC: Fix cs4270 error path",
> > originally posted by myself on August 31st, fixing the error path of
> > cs4270_probe. This is the one Timur was just acking, but I do _not_ see
> > it in your queue, so I suspect you missed it. I can resend it if it
> > helps.
> 
> Oh, OK, then I must have missed that.  Could you repost?

Will do in a minute.

> And, this *must* go to 2.6.27, or not?

It could go in 2.6.27, certainly, but I wouldn't say it *must* go
there. The patch is "only" fixing an error path, which by definition
isn't supposed to be needed unless something unexpected happens, in
which case the driver probably won't work anyway. So it doesn't deserve
delaying 2.6.27, and sending a pull request to Linus for just that
patch would probably be overkill. But if you get the opportunity to
send such a pull request for another problem, then it makes sense to
include this cs4270 fix as well.

Anyway it's really up to you and Timur. I just happened to notice the
bug and posted a fix, but I'm not even using the driver myself.

> Frankly, this series of cs4270 patches have been hard to handle
> because it was always unclear what the patch is for.
> The description "It's for 2.6.x" is too ambiguous because it doesn't
> always mean the purpose but also can mean the based version of the
> patch.  So, a more clear sign would be really helpful for me at the
> next time...

OK, sorry about that. I'll try to make things clearer next time.

-- 
Jean Delvare
