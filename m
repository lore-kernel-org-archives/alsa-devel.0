From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 1/4] pxa2xx-i2s: Proper initialization
Date: Fri, 8 May 2009 21:20:58 +0200
Message-ID: <ea2442770905081220m5b1a7490pffd51132dc90e255@mail.gmail.com>
References: <4A037483.6030602@gmail.com> <20090508102953.GB5654@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DF9B32438D
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 21:20:59 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2785352qyk.16
	for <alsa-devel@alsa-project.org>; Fri, 08 May 2009 12:20:59 -0700 (PDT)
In-Reply-To: <20090508102953.GB5654@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, May 8, 2009 at 12:29 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Fri, May 08, 2009 at 01:53:39AM +0200, Karl Beldan wrote:
>
>> Reset FIFO logic and registers, and make sure REC and RPL functions and
>> FIFO service are disabled.
>
>> =A0static int __init pxa2xx_i2s_init(void)
>> =A0{
>> =A0 =A0 =A0 clk_i2s =3D ERR_PTR(-ENOENT);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* PXA Developer's Manual:
>> + =A0 =A0 =A0* If SACR0[ENB] is toggled in the middle of a normal operat=
ion,
>> + =A0 =A0 =A0* the SACR0[RST] bit must also be set and cleared to reset =
all
>> + =A0 =A0 =A0* I2S controller registers.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 SACR0 =3D SACR0_RST;
>> + =A0 =A0 SACR0 =3D 0;
>> + =A0 =A0 SACR1 =3D SACR1_DRPL | SACR1_DREC;
>> + =A0 =A0 SAIMR &=3D ~(SAIMR_RFS | SAIMR_TFS);
>
> I'd expect this to happen when the driver is probed rather than when the
> module is initialised. =A0Otherwise we'll end up writing to the hardware

Indeed, will resend.

-- =

Karl
