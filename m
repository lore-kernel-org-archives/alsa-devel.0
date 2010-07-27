From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: detecting the presence of dmix
Date: Tue, 27 Jul 2010 21:24:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007272123580.4068@eeebox2.perex-int.cz>
References: <4C4F320C.4000700@pseudoterminal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FB1A2414E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 21:24:38 +0200 (CEST)
In-Reply-To: <4C4F320C.4000700@pseudoterminal.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dv <dv@pseudoterminal.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Jul 2010, dv wrote:

> Hello,
>
> is it possible to programmatically detect
> whether or not dmix is enabled?

Don't do this.

> it is important for a software stack where dmix would introduce unwanted
> resampling artifacts

Use SND_PCM_NO_AUTO_RESAMPLE or configure alsa-lib to use better resampler 
(alsa-plugins).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
