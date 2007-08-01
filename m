From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] Get rid of dead code
	in	sound/pci/ac97/ac97_patch.c
Date: Wed, 01 Aug 2007 13:14:56 +0100
Message-ID: <1185970496.3078.181.camel@localhost.localdomain>
References: <46AF9D47.5090302@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 823A42459B
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 14:14:57 +0200 (CEST)
In-Reply-To: <46AF9D47.5090302@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

I'd prefer we keep this code in atm. The WM97xx touch driver needs it to
eliminate any audio noise from the touchscreen ADC.

I'll post the remaining touch driver patches in time for the next merge
window. 

Liam 

On Tue, 2007-07-31 at 22:36 +0200, Michal Piotrowski wrote:
> Hi,
> 
> File /home/devel/linux-rdc/sound/pci/ac97/ac97_patch.c line 484
> Unknown CONFIG option! CONFIG_TOUCHSCREEN_WM9705
> 
> Regards,
> Michal
> 
