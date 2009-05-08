From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: AC97 reset fail after suspend
Date: Fri, 8 May 2009 15:52:41 +0200
Message-ID: <200905081552.42189.marek.vasut@gmail.com>
References: <200905080148.20137.sleep_walker@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 27CD11038F7
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 15:52:40 +0200 (CEST)
Received: by fxm18 with SMTP id 18so1567412fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 08 May 2009 06:52:39 -0700 (PDT)
In-Reply-To: <200905080148.20137.sleep_walker@suse.cz>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomas 'Sleep_Walker' Cech <sleep_walker@suse.cz>
Cc: Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Friday 08 of May 2009 01:48:19 Tomas 'Sleep_Walker' Cech wrote:
> Hi,
>
> I've got following error on Palm LifeDrive and PalmTX after suspend &
> resume:
>
> pxa2xx_ac97_try_warm_reset: warm reset timeout (GSR=0x0)
> pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x0)
> pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
> pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x44)
> WM9712 AC97 reset failed
> could not reset AC97 codec
>
> That completely disable whole AC97 communication, so touchscreen, sound and
> battery doesn't work any longer.
>
> I also tried this with Treo680 (code will be sent soon). HW is very
> similar, only codec is different - LD/T5/TX use WM9712, Treo680 use WM9713.
> On Treo680 there is no problem with that.
>
> Thanks for any hint about that.
>
> Tomas 'Sleep_Walker' Cech
>
> Attaching config for LD/TX and dmesg output.

added LAK in CC
