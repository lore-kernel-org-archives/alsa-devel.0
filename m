From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Procedure for alsa modules compilation from git
Date: Sat, 7 Apr 2018 00:04:54 +0200
Message-ID: <325f4103-3552-8caf-44b2-8ea0b366d585@ivitera.com>
References: <c5de487e-3d99-e7d9-7640-cf1781748075@ivitera.com>
 <fe243517-c3ed-dd66-c339-8843be7ee038@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id BBEA6267359
 for <alsa-devel@alsa-project.org>; Sat,  7 Apr 2018 00:05:04 +0200 (CEST)
In-Reply-To: <fe243517-c3ed-dd66-c339-8843be7ee038@perex.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 6.4.2018 v 20:33 Jaroslav Kysela napsal(a):

> The info is unfortunately obsolete, because the demand for this type of
> the compilation is really low. For simple changes, you may use the code
> from your kernel and write own Makefile for the external module build
> (copy obj parts from the ALSA makefiles) like:
> 
> --
> obj-m += test.o
> 
> all:
>      make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
> --
> 
> For complex changes, use the whole git tree.

Thanks a lot, I will compile the whole tree then.

Best regards,

Pavel.
