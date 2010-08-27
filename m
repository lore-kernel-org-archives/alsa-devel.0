From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: How to transfer more than 2 channels
	between	i.MX25 & AD1938 using SSI?
Date: Fri, 27 Aug 2010 13:45:12 +0200
Message-ID: <20100827114512.GC1473@pengutronix.de>
References: <4C752B37.40601@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 95354245A5
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 13:45:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C752B37.40601@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sven Zeisberg <sven.zeisberg@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Sven,

On Wed, Aug 25, 2010 at 04:39:51PM +0200, Sven Zeisberg wrote:
>   Hi,
> 
> has anybody succeeded to transfer more than 2 audio channels between 
> i.MX25 and a CODEC throught the i.MX25 SSI Port?
> 
> We have succeeded to set the CODEC (AD1938) as Master to the required 
> mode (TDM with 8 Timeslots and 32 Bit per Timeslot). However, as soon as 
> we start to play a wav file with aplay, we can see on the logic analyzer 
> that the data format on the SSI lines is reset to a stereo mode (2 
> channels with frame sync changing level between channels).
> 
> In the imx-ssi driver, I can see that .channel_max = 2 - therefore my 
> question: does this driver support more than two channels at all?

You have to call snd_soc_dai_set_tdm_slot() with the correct parameters.
This function is currently relatively untested, so expect bugs here. I
would try something like:

snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffff00, 0xfffff00, 8, 32);

slot_width is currently not handled in this function, this may be
wrong. I don't know whether a slot length of 32bit is supported at all
in the hardware.

I only tested this driver with 2 channels since I have no access to a
codec supporting something else.

Hope that helps

  Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
