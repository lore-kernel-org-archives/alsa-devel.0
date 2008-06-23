From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Fix register programming in Freescale
 MPC8610 HPCD sound driver
Date: Mon, 23 Jun 2008 11:41:13 -0500
Message-ID: <485FD229.1090102@freescale.com>
References: <1213383751-17284-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A83DD103872
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 18:41:18 +0200 (CEST)
In-Reply-To: <1213383751-17284-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Fix the Freescale MPC8610 HPCD sound driver so that it programs the DMACR
> and PMUXCR registers in the global utilities correctly.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> This patch is for 2.6.26.  A similar fix has already been made in the ASOC V2
> repository.  

Is this patch going to get picked up for 2.6.26?  I posted it 10 days ago, but
it looks like no one noticed.

-- 
Timur Tabi
Linux kernel developer at Freescale
