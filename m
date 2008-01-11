From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] [POWERPC] Update MPC8610 HPCD
 to	support audio drivers
Date: Fri, 11 Jan 2008 11:07:37 -0600
Message-ID: <4787A259.5010200@freescale.com>
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>	<fa686aa40801101452q608907f3rf6f98a5d091d09d9@mail.gmail.com>	<47879BD6.9010205@freescale.com>
	<s5htzlkl3b2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 877A8245A3
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 18:07:46 +0100 (CET)
In-Reply-To: <s5htzlkl3b2.wl%tiwai@suse.de>
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

> I can merge the ALSA part from myself, but the change in ppc subtree
> is difficult because I have no access to alsa.git tree.

What is the relationship between the alsa.git repo and the Hg repo?  Why do we 
have two repos anyway?

> Is it OK that the first patch goes to ppc tree?

Yes, either part can be applied independent of the other.  If you want to apply 
just the second part, I can find someone on the PPC to apply the first.

-- 
Timur Tabi
Linux kernel developer at Freescale
