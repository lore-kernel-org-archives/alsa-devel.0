From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] [POWERPC] Update MPC8610 HPCD
 to	support audio drivers
Date: Fri, 11 Jan 2008 11:16:40 -0600
Message-ID: <4787A478.7050500@freescale.com>
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>	<fa686aa40801101452q608907f3rf6f98a5d091d09d9@mail.gmail.com>	<47879BD6.9010205@freescale.com>	<s5htzlkl3b2.wl%tiwai@suse.de>	<4787A259.5010200@freescale.com>
	<s5hmyrcl20j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id A469F245CD
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 18:16:45 +0100 (CET)
In-Reply-To: <s5hmyrcl20j.wl%tiwai@suse.de>
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

Takashi Iwai wrote:

> The problem is that HG repo doesn't contain the whole kernel tree but
> only the ALSA subtree to reduce the repo size.

So is it okay if I use the git repo to base my work?  I use git for all other 
Linux development, so it would be awkward for me to use HG just for ALSA work.

> That'd be helpful.  Then I'll apply your second part and leave the
> first part to ppc guys.

Kumar Gala is going to apply the first part.  It'll be in his "for-2.6.25" 
branch.  Can I assume that you'll push the second part to alsa.git and then to 
Linus when the 2.6.25 window opens?

-- 
Timur Tabi
Linux kernel developer at Freescale
