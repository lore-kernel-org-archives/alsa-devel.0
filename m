From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: Fix cs4270 error path
Date: Tue, 30 Sep 2008 09:25:50 -0500
Message-ID: <48E236EE.1060502@freescale.com>
References: <20080831144214.62a17be6@hyperion.delvare>	<ed82fe3e0809290642l358dab29r274ba97d5bd4b473@mail.gmail.com>	<s5hhc7zjc6k.wl%tiwai@suse.de>	<20080930103137.52b428a6@hyperion.delvare>
	<s5hfxniypz3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 9167B24526
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 16:25:56 +0200 (CEST)
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
Cc: Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Oh, OK, then I must have missed that.  Could you repost?
> And, this *must* go to 2.6.27, or not?

The only patch that needs to go into 2.6.27 is the one titled "alsa: make the
CS4270 driver a new-style I2C driver" from me.  This one is missing from Linus'
tree.

I notice that "ALSA: ASoC: Fix another cs4270 error path" is in Linus' tree, but
nothing else is.

> Frankly, this series of cs4270 patches have been hard to handle
> because it was always unclear what the patch is for.
> The description "It's for 2.6.x" is too ambiguous because it doesn't
> always mean the purpose but also can mean the based version of the
> patch.  So, a more clear sign would be really helpful for me at the
> next time...

I can do that, but I'm not sure how I can be any clearer.  "This is for 2.6.x",
to me at least, means exactly that - that this patch should be applied to the
branch for 2.6.27, which is either a release candidate (i.e. 2.6.27-rcX) or a
bug fix (i.e. 2.6.27.x), depending on what's next.

If you want me to use different wording, just tell me what I should say.

-- 
Timur Tabi
Linux kernel developer at Freescale
