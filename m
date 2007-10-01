From: Timur Tabi <timur@freescale.com>
Subject: Re: ASOC: Best way to get private data from machine
 driver to the other drivers?
Date: Mon, 01 Oct 2007 16:49:06 -0500
Message-ID: <47016B52.1060702@freescale.com>
References: <46FD6EAA.5050801@freescale.com>
	<1191236021.3318.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D93624360
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Oct 2007 23:49:11 +0200 (CEST)
In-Reply-To: <1191236021.3318.41.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> Could you have a look at the V2 i.mx31 SSI driver and let me know if we
> need further changes for better dts support.

I'm trying to port the CS4270 codec driver (it's easier) to ASOC v2, and I see 
that you don't have snd_pcm_rate_to_rate_bit().  Where did it go?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
