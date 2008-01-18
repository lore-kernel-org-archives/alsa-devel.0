From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] [POWERPC] Update MPC8610 HPCD
	to	support audio drivers
Date: Fri, 18 Jan 2008 09:18:14 -0600
Message-ID: <1B0EDDAA-B8DE-44C8-B9BE-959B81B4F7C8@kernel.crashing.org>
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>
	<Pine.LNX.4.64.0801180047460.16260@blarg.am.freescale.net>
	<4790BC58.3020606@freescale.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 719F0245D3
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 16:18:18 +0100 (CET)
In-Reply-To: <4790BC58.3020606@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Jan 18, 2008, at 8:48 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> Can you respin this.  It doesn't apply cleanly to my tree.
>
> Ok, but I have a feeling that the merge between alsa-git and powerpc- 
> git is going to be ugly.

Really, it would seem ok in that the powerpc stuff is only touch files  
under arch/powerpc.  So as long as the alsa is only touching files in  
drivers/ I think we'll be ok.  8610 my bitch a bit until the two exist  
in one place.

My merge conflict was because of updates/changes to booting-without- 
of.txt

- k
