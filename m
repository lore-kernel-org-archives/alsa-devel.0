From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsactl adds volume controls?
Date: Fri, 3 Sep 2010 09:07:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009030905210.10278@eeebox2.perex-int.cz>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<4C78059B.50801@canonical.com>
	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
	<s5h4oec8r6f.wl%tiwai@suse.de> <4C7BABA9.1010100@canonical.com>
	<s5hlj7ont8e.wl%tiwai@suse.de>
	<4C7E549E.4080505@canonical.com> <s5hr5hczi06.wl%tiwai@suse.de>
	<4C7F6D5D.7020101@canonical.com> <s5hmxs0h437.wl%tiwai@suse.de>
	<4C809DB3.9090201@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E19824458
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 09:07:27 +0200 (CEST)
In-Reply-To: <4C809DB3.9090201@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Sep 2010, David Henningsson wrote:

> What would be really helpful would be if snd_mixer_open() took an
> optional pcm handle, and then only returned the mixer controls that
> affects the signal path of that pcm.

This will be solved by another mechanism like ucm (use case manager). The 
idea is to return the PCM handle and associated mixer controls (master + 
pcm) for specified use case (like hdmi output etc.).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
