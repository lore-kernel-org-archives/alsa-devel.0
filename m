From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: Fix cs4270 error path
Date: Tue, 30 Sep 2008 09:56:15 -0500
Message-ID: <48E23E0F.6040105@freescale.com>
References: <20080831144214.62a17be6@hyperion.delvare>	<ed82fe3e0809290642l358dab29r274ba97d5bd4b473@mail.gmail.com>	<s5hhc7zjc6k.wl%tiwai@suse.de>	<20080930103137.52b428a6@hyperion.delvare>	<s5hfxniypz3.wl%tiwai@suse.de>	<48E236EE.1060502@freescale.com>
	<s5h3ajhheoq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CCCE424544
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 17:00:30 +0200 (CEST)
In-Reply-To: <s5h3ajhheoq.wl%tiwai@suse.de>
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

> So, do you mean that this patch (ASoC: Fix cs4270 error path) doesn't
> have to go into 2.6.27?  Hell, there are still things unclear to
> me...

I think "ASoC: Fix cs4270 error path" should go in, but Jean is correct - it
just fixes an error condition that will never happen in real life.  It's your
call if you want to push it up.

>>  This one is missing from Linus'
>> tree.
> 
> It's already in 2.6.27-rc8:
> ec2cd95f340fb07b905839ee219b3846ecf58396 ALSA: make the CS4270 driver a new-style I2C driver

Ah, I misread the search page.  I see it now.

> In short: "A is for B" is too passive and ambiguous.  Rather say
> simply "Do X".

Got it.

-- 
Timur Tabi
Linux kernel developer at Freescale
