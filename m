From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Fri, 8 May 2009 16:55:01 +0300
Message-ID: <20090508165501.954a61e7.jhnikula@gmail.com>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
	<1241763077-6851-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090508094044.0c85e86a.jhnikula@gmail.com>
	<200905081456.50445.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 2414F1038F3
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 15:53:35 +0200 (CEST)
Received: by ewy23 with SMTP id 23so2071886ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 08 May 2009 06:53:34 -0700 (PDT)
In-Reply-To: <200905081456.50445.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 May 2009 14:56:50 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> But I have debugged this further and I believe I know what is going
> on: The sequence for disable according to the documentation:
> HS_POP_SET:RAMP_EN = 0
> HS_POP_GAIN:HSL_GAIN, HSR_GAIN = 0
> HS_POP_SET:VMID_EN = 0
> 
> Now what is missing from this is that after setting the
> HS_POP_SET:RAMP_EN = 0 it will take RAMP_DELAY time for the VMID to
> reach 0. Since we are not waiting between RAMP_EN = 0 and VMID_EN =
> 0, the VMID has been cut, which causes the 'tuck' on the headset
> output.
> 
I was looking the power-up phase and there, as far as I understand,
RAMP_DELAY is HW driven and no SW delays required like in power-down
path, code does power-up path correctly but still there is a pop. This
made me thinking the idea below.

I don't have TWL4030 TRM but AFAIK, the TPS65950 is the same chip and
I was looking HS power sequencing from page 691 in TPS65950 TRM.

http://focus.ti.com/docs/prod/folders/print/tps65950.html
http://www.ti.com/litv/pdf/swcu050d

> Anyways, this seams quite bad. I will think about it over the
> weekend...
> 
> Any ideas?
> 
Would it be possible that pop is not caused by the HS output but
inside the chip, like from DAC?

One nice method to hunt these is to use gpio to trigger scope at the
beginning of sequencing and toggle it at each step so it would be easy
to see what step is causing the strong pop and what kind of delays
are required to mask it.


-- 
Jarkko
