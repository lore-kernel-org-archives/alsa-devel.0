From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Wed, 24 Feb 2010 11:49:47 +0800
Message-ID: <4f3252891002231949i1cfd6dd3h7c5e4b3dc7ba8bc8@mail.gmail.com>
References: <20100216233825.GB23623@sirena.org.uk>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
	<4f3252891002202001gb6df8cg6c023c52e7d8394a@mail.gmail.com>
	<20100221192951.GD30380@tango.0pointer.de>
	<4B83A912.1050501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f193.google.com (mail-px0-f193.google.com
	[209.85.216.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B0152432C
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 04:49:48 +0100 (CET)
Received: by pxi31 with SMTP id 31so2364715pxi.26
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 19:49:47 -0800 (PST)
In-Reply-To: <4B83A912.1050501@ladisch.de>
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
List-Id: alsa-devel@alsa-project.org

2010/2/23 Clemens Ladisch <clemens@ladisch.de>

> Lennart Poettering wrote:
>
>
>  Only mixer controls with interface PCM (not MIXER) have (sub-)
> device numbers, and at the moment this is used only for controls that
> are associated with the streams of hardware-mixing-capable cards.
>
>
> Regards,
> Clemens
>

Just implementing those IFACE_PCM control for the driver is not enough for
any practical use

Will need an API which allow the application to change the hardware per
stream volume in optimized way by calling one api ? ( e.g. those API is need
for if wine want to implement the real hardware acclerated dsound for those
hardware mixing sound cards which support at least 16 voices )
