From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: device_create_drvdata missing on older kernels
Date: Wed, 30 Jul 2008 09:39:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0807300938580.7676@tm8103-a.perex-int.cz>
References: <200807301500.34579.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E599124430
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 09:39:17 +0200 (CEST)
In-Reply-To: <200807301500.34579.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Jul 2008, Eliot Blennerhassett wrote:

> I could not compile current git. (Error on acore/init.c)
> 
> Adding this to adriver.h fixed it for me. I'm not sure if this is the correct 
> general fix?
> 
> #ifndef CONFIG_SND_HAS_DEVICE_CREATE_DRVDATA
> #define device_create_drvdata(c,d,m,p,s,n) device_create((c),(d),(m),(s),(n))
> #endif 

It looks like a correct fix. Applied. Thanks.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
