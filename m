From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add EXTMUTE to reduce
	pop-noise effect
Date: Thu, 2 Jul 2009 12:34:57 +0300
Message-ID: <200907021234.58110.peter.ujfalusi@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B52037758@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 11641246BF
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 11:35:05 +0200 (CEST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B52037758@dlee01.ent.ti.com>
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
To: "ext Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 02 July 2009 03:17:43 ext Candelaria Villareal, Jorge wrote:
> According to TRM, an external FET controlled by a 1.8V output signal
> can be used to reduce the pop-noise heard when the audio amplifier is
> switched on. It is suggested that GPIO6 of TWL4030 be used, but any
> other gpio can be used instead. This is indicated in machine driver
> with the following twl4030_setup_data members:
>
> -hs_extmute. Set to 1 if board has support for EXTMUTE.
>
> -set_hs_extmute. Set to a callback funcion to control an external gpio
> line. Set to NULL if MUTE[GPIO6] pin is used.
>
> Codec driver takes care of enabling and disabling this output during
> the headset pop attenuation sequence.
>
> Also add a delay to let VMID settle in ramp up sequence.

I can not see any problems with this patch, but unfortunately I can not test 
it since none of my hardware supports the extmute on the headset output...

Thank you!

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
