From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: ESI Juli@ crash with external clock switch - patch
Date: Mon, 12 Jan 2015 09:34:52 +0100
Message-ID: <54B3872C.2010501@ivitera.com>
References: <54B28174.7060008@ivitera.com> <s5hwq4t2u33.wl-tiwai@suse.de>
 <54B2B992.7000909@ivitera.com> <s5hegr12gxn.wl-tiwai@suse.de>
 <54B2E48B.7020000@ivitera.com> <s5hvbkc1kaa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3452605FA
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 09:34:56 +0100 (CET)
In-Reply-To: <s5hvbkc1kaa.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12.1.2015 09:21, Takashi Iwai wrote:
> Yeah, restart is necessary only in a certain situation, and is a bug
> that is done through work itself.  This was the cause.  I'll prepare
> fix patches later.

I wish I could help but unfortunately my practical knowledge of kernel
workqueues is close to zero :-( Of course I will test the patches and
will extend them for quartet with testing too.


> The HZ/10 isn't that bad, but the problem is that it's unconditionally
> running even if user doesn't need/want.

It is useful only for the external clock mode. In fact the detection of
incoming SPDIF rate is not reliable for internal clock in Juli (while it
works just fine in Quartet, its FPGA pins configure the SPDIF receiver
differently). IMO the thread could be running only when clock is
switched to external.

Thanks a lot,

Pavel
