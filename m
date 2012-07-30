From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 1/2] ALSA: ASoC: add DT bindings for
	cs4270
Date: Mon, 30 Jul 2012 23:06:46 +0200
Message-ID: <5016F766.2050409@gmail.com>
References: <1343222915-26108-1-git-send-email-zonque@gmail.com>
 <5016F1B7.6070109@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F9592652FD
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 23:06:48 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so1850899wib.2
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 14:06:50 -0700 (PDT)
In-Reply-To: <5016F1B7.6070109@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 30.07.2012 22:42, Timur Tabi wrote:
> Daniel Mack wrote:
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: Timur Tabi <timur@freescale.com>
>> ---
> 
> Both patches:
> 
> Acked-by: Timur Tabi <timur@freescale.com>

Thanks.

> I am seeing something a little weird, though, although I doubt it's
> related to these patches.  Audio works, even though I see this on the boot
> log:

I also fail to see a relation here. Does it happen without the two
patches as well?


Daniel


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
> soc-audio soc-audio:  cs4270-hifi <-> e0016000.ssi mapping ok
> soc-audio soc-audio:  cs4270-hifi <-> e0016000.ssi mapping ok
> 
> Is there a connection between the message "ASoC machine
> snd-soc-mpc8610hpcd should use snd_soc_register_card()", the requests for
> probe deferral, and the "No soundcards found." message?
> 
