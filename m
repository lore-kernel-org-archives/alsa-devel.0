From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SH7760 ASoC support
Date: Fri, 11 May 2007 13:19:40 +0100
Message-ID: <1178885980.25225.16.camel@localhost.localdomain>
References: <20070510154213.GA10864@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 37BD324496
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 14:19:42 +0200 (CEST)
In-Reply-To: <20070510154213.GA10864@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, lg@wolfsonmicro.com, linuxsh-dev@lists.sf.net, lethal@linux-sh.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-05-10 at 17:42 +0200, Manuel Lauss wrote:
> Hello,
> 
> here goes attempt #3 for the SH7760 ASoC patch.
> Changes v2 -> v3
> - added a generic demo board for AC97
> 
> Changes v1 -> v2
> - incorporate Paul Mundt's suggestions                                                                                                                                              
> - work around an oops when aplay is used in mmap mode ('aplay -M')                                                                                                                  
>   by changing the allocation type to SNDRV_DMA_TYPE_CONTINUOUS
> 

Ack.

Liam
