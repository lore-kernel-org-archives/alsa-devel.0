From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] New Aztech Sound Galaxy driver.
Date: Tue, 11 Sep 2007 21:21:16 +0200
Message-ID: <46E6EAAC.1070804@gmail.com>
References: <46E1DD43.6060403@gmail.com>
	<20070911210704.e738bd61.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id AEDF524333
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 21:21:24 +0200 (CEST)
In-Reply-To: <20070911210704.e738bd61.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Ram Kromberg <ramkromberg@mail.com>
List-Id: alsa-devel@alsa-project.org

On 09/11/2007 09:07 PM, Krzysztof Helt wrote:

>> 5. I38-MMSN852 = AZT2316R + CS4231A-KL, with EEPROM
>>
> 
> I got this one. It has also AZT3320 chip.

Yep -- hardware midi, hooked up to the onboard MPU-401. Sounds really thin, 
but it's okay to play with.

> 1. There is a problem with freeing resources in the probe function. If the probe
> ends with error, removal of the driver does not release requested regions

Yes, dumb cut & paste error from when it was split off into its own 
function; please change the four "return err;" exits in (that version of) 
snd_galaxy_probe() with "goto error;"

> 2. After a while I found the free irq (it took quite long with this 
> manual settings). The driver loaded, the /proc/asound/* files showed 
> GALAXY something but the alsamixer ended with message that there was no
> mixer device.

It took quite long for you to look at /proc/interrupts and see which ones of 
four possible IRQs was unclaimed (the only thing autoprobing does)? Strange.

I don't see the mixer problem here, with the same card. Might it be a 
testing fluke caused by the unloading bug above?

Rene.
