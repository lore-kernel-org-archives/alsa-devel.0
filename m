From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH v3 1/2] ALSA: ASoC: add DT bindings
	for	cs4270
Date: Tue, 31 Jul 2012 03:54:39 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA4CA5F@DBDE01.ent.ti.com>
References: <1343222915-26108-1-git-send-email-zonque@gmail.com>
 <5016F1B7.6070109@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A14D265B52
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 05:54:41 +0200 (CEST)
In-Reply-To: <5016F1B7.6070109@freescale.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 31, 2012 at 02:12:31, Timur Tabi wrote:
> Daniel Mack wrote:
> > Signed-off-by: Daniel Mack <zonque@gmail.com>
> > Cc: Timur Tabi <timur@freescale.com>
> > ---
> 
> Both patches:
> 
> Acked-by: Timur Tabi <timur@freescale.com>
> 
> I am seeing something a little weird, though, although I doubt it's
> related to these patches.  Audio works, even though I see this on the boot
> log:
> 
> cs4270 0-004f: found device at i2c address 4F
> cs4270 0-004f: hardware revision 3
> Freescale MPC8610 HPCD ALSA SoC machine driver
> soc-audio soc-audio: ASoC machine snd-soc-mpc8610hpcd should use
> snd_soc_register_card()
> soc-audio soc-audio: Failed to register card
> platform soc-audio: Driver soc-audio requests probe deferral
> ...
> ALSA device list:
>   No soundcards found.
> soc-audio soc-audio: ASoC machine snd-soc-mpc8610hpcd should use
> snd_soc_register_card()

I believe you are registering "soc-audio" as a device.
 
In the "soc-audio" driver probe (souns/soc/soc-core.c - soc_probe()), 
this message is printed.

This is as per the commit below

commit fe4085e84f17a57a533a210a626e0cc9ead381f9
Author:     Mark Brown <broonie@opensource.wolfsonmicro.com>
AuthorDate: Fri Mar 2 13:07:41 2012 +0000
Commit:     Mark Brown <broonie@opensource.wolfsonmicro.com>
CommitDate: Fri Mar 2 16:21:25 2012 +0000

    ASoC: core: Log a warning when machines use soc-audio

    snd_soc_register_card() has been available and strongly preferred since
    2.6.38 but we're still seeing new drivers using it and the conversion rate
    for older machines has been low. Help address both issues by logging a
    warning when the soc-audio device probes.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Acked-by: Liam Girdwood <lrg@ti.com>


> soc-audio soc-audio:  cs4270-hifi <-> e0016000.ssi mapping ok
> soc-audio soc-audio:  cs4270-hifi <-> e0016000.ssi mapping ok
> 
> Is there a connection between the message "ASoC machine
> snd-soc-mpc8610hpcd should use snd_soc_register_card()", the requests for
> probe deferral, and the "No soundcards found." message?
> 
> -- 
> Timur Tabi
> Linux kernel developer at Freescale
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


Regards, 
Gururaja
