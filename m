From: linuxconsole@free.fr
Subject: Re: alsa and 2.6.25.4 kernel
Date: Mon, 16 Jun 2008 17:15:52 +0200
Message-ID: <1213629352.485683a853269@imp.free.fr>
References: <1213376560.4852a830e906b@imp.free.fr>
	<s5hwskppt0f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wmproxy1-g27.free.fr (wmproxy1-g27.free.fr [212.27.42.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 8745B24355
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 17:17:30 +0200 (CEST)
In-Reply-To: <s5hwskppt0f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Thanks for your response.

My distro (http://linuxconsole.org) doesn't use udev, to go faster.

I disabled alsa from 2.6.25.4 kernel, build alsa drivers from
alsa-driver-1.0.17rc1 and now it works fine.

Best regards.

Yann.

Selon Takashi Iwai <tiwai@suse.de>:

>
> My wild guess is that the device file doesn't match with the kernel
> setting.  You can build ALSA drivers with dynamic minor numbers.  In
> this case, the minor numbers of device files are assigned dynamically,
> and thus the device files must be handled via udev.  If you have
> static device files with different numbers, this won't match
> properly.
>
>
> Takashi
>
