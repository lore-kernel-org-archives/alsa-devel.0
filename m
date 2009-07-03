From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Zoom2: Update twl4030_setup_data
	parameters
Date: Fri, 3 Jul 2009 08:50:03 +0300
Message-ID: <200907030850.03832.peter.ujfalusi@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B5214663B@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id BAC8710388F
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 07:50:35 +0200 (CEST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B5214663B@dlee01.ent.ti.com>
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

On Friday 03 July 2009 03:04:07 ext Candelaria Villareal, Jorge wrote:
> Add support for EXTMUTE in Zoom2 machine driver. This is necessary
> to further reduce pop noise problem. Signal EXTMUTE is connected to
> signal GPIO 153 in Zoom2 board.
>
> In addition, change ramp delay value to 3 (218/161/109 ms). With
> previous ramp delay value, pop noise was louder. With a longer value
> the beep tone can be observed.
>
> Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>

Looks nice,

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
