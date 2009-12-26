From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: CONFIG_GCD is never defined in the
	latest	alsa-driver
Date: Sat, 26 Dec 2009 14:04:45 +0200
Message-ID: <4B35FBDD.8050309@pardus.org.tr>
References: <4B35EB9C.9030501@pardus.org.tr> <s5hy6kqufv6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id EB2D510382B
	for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2009 13:04:43 +0100 (CET)
In-Reply-To: <s5hy6kqufv6.wl%tiwai@suse.de>
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
> CONFIG_GCD looks new indeed.  For 2.6.31 and 32, we need more check.
> I applied the following fix instead in case linux/gcd.h is defined
> by vendor kernels.
>   

Tested and works well, thanks.
