From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v5 0/9] Add Omapl138-Hawkboard support
Date: Thu, 21 Oct 2010 21:44:36 +0100
Message-ID: <1287693876.3205.72.camel@odin>
References: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E4D731038C8
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 22:44:35 +0200 (CEST)
Received: by wye20 with SMTP id 20so32136wye.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 13:44:35 -0700 (PDT)
In-Reply-To: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: vm.rod25@gmail.com
Cc: davinci-linux-open-source@linux.davincidsp.com, sshtylyov@mvista.com, nsekhar@ti.com, alsa-devel@alsa-project.org, khasim@ti.com, caglarakyuz@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-10-19 at 13:06 -0500, vm.rod25@gmail.com wrote:
> From: Victor Rodriguez <victor.rodriguez@sasken.com>
> 
> This patch adds
> EMAC, EDMA, ASoC, SOUND, MMC/SD and USB OHCI
> support for the Hawkboard-L138 system
> It is under the machine name "omapl138_hawkboard".
> This system is based on the da850 davinci CPU architecture.
> 
> Victor Rodriguez (9):
>   davinci: EMAC support for Omapl138-Hawkboard
>   davinci: EDMA support for Omapl138-Hawkboard
>   davinci: ASoC support for Omapl138-Hawkboard
>   davinci: McASP configuration for Omapl138-Hawkboard
>   davinci: Audio support for Omapl138-Hawkboard
>   davinci: MMC/SD and USB-OHCI configuration for Omapl138-Hawkboard
>   davinci: MMC/SD support for Omapl138-Hawkboar
>   davinci: USB clocks for Omapl138-Hawkboard
>   davinci: USB1.1 support for Omapl138-Hawkboard
> 
>  arch/arm/mach-davinci/board-omapl138-hawk.c |  317 +++++++++++++++++++++++++++
>  arch/arm/mach-davinci/da850.c               |   22 ++-
>  arch/arm/mach-davinci/include/mach/mux.h    |    4 +
>  sound/soc/davinci/Kconfig                   |    5 +-
>  sound/soc/davinci/davinci-evm.c             |    6 +-
>  5 files changed, 349 insertions(+), 5 deletions(-)
> 

ASoC parts :-

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
