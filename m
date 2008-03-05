From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Alsa MMAP emulation
Date: Wed, 5 Mar 2008 09:30:33 -0800
Message-ID: <61445c750803050930j188415e0x3b7fb5cb7a7957b7@mail.gmail.com>
References: <47CE7A47.80009@xwaves.net> <47CEC173.2060005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id EACE7103858
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 18:30:37 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1530794wag.8
	for <alsa-devel@alsa-project.org>; Wed, 05 Mar 2008 09:30:36 -0800 (PST)
In-Reply-To: <47CEC173.2060005@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Mathieu Monney <zittix_all@xwaves.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 5, 2008 at 7:51 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Mathieu Monney wrote:
>  > I'm trying to get working Alsa with the PortAudio library on an embedded
>  > device (Nokia N810). The problem is that the sound driver is not an
>  > hardware driver for Alsa but a plugin which deals with the internal DSP
>  > of the device. This plugin doesn't support mmap'ing at all. So I was
>  > wondering if it is possible to configure Alsa a way such PortAudio can
>  > use mmap'ing on my DSP plugin ? I saw there is a mmap_emulation flag but
>  > the problem is that it seems to be only available on HW driver and not
>  > on alsa plugins.
>
>  In alsa-lib 1.0.15, this function was moved into the mmap_emul plugin.


So, the original plugin need not be modified? mmap_emul plugin has to
be used on top of it?

-pharaoh.
