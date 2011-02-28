From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: Re: [PATCH 1/2] acore: deprecated function
	in	wrappers.c
Date: Mon, 28 Feb 2011 12:43:00 +0100
Message-ID: <4D6B8A44.7080805@elproma.com.pl>
References: <4D67CC36.4090004@elproma.com.pl>
	<s5hk4goqfz7.wl%tiwai@suse.de>	<4D67D019.80807@elproma.com.pl>
	<s5hhbbsqfc5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout4.mailmx.agnat.pl
	[193.239.44.248])
	by alsa0.perex.cz (Postfix) with ESMTP id C2229103810
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 12:44:04 +0100 (CET)
In-Reply-To: <s5hhbbsqfc5.wl%tiwai@suse.de>
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
> Then configure script didn't detect the condition properly.
> Check CONFIG_HAVE_PCI_DEV_PRESENT in you config.log.  Most likely
> a wrong gcc option or path is given, and the check is screwed up.
>
>
> Takashi
ok, but still, something is wrong if it tries to compile the wrapper 
code even if new kernel was detected (2.6.35)...

Greg
