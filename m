From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH 1/3] ASoC: soc_jack - add function to
	determine jack type
Date: Tue, 1 Feb 2011 18:49:11 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C0FE9A4D@bgsmsx501.gar.corp.intel.com>
References: <1296234579-6622-1-git-send-email-priya.harsha@intel.com>
	<20110131120826.GD5123@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 627F3103967
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 14:19:18 +0100 (CET)
In-Reply-To: <20110131120826.GD5123@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


>> given the mic bias value. For any codec that would give
>> the mic bias value on a jack insertion, this function would
>> return the type of jack based on mic bias range
>
>I think this is too minimal as an API for this.  There's two things I'm
>missing here.  The major one is that there's no handling of debounce -
>jack insertion is a very slow and very analogue process relative to CPUs
>so taking a single reading is likely to give false measurements.
I believe this should be part of codec driver that would make sure that it has
determined the right adc value and then call the function to find the jack type. 
In the sn95031 codec, this is handled in hardware with programmable debounce
values. The default value  takes care of ensuring that the adc value is read is for
right jack event.
Later, I will add a kcontrol for the same to enable programming it.
>
>The other is that there's no facility for either scaling the voltages
>with micbias (obviously the specific voltages read are going to vary
>depending on what the micbias voltage on a given system is) 
I can add a field "system_micbias" field and the ranges fields to snd_soc_jack
structure. The machine driver can set these details when it creates a jack. The
new API can give the jack or button type based on this range. This way its
scalable. Will this help? Let us know, if there is a better way

>adding other things that can be detected.  For example, some systems
>have buttons on their headset which pull micbias to ground via varying
>resistances with individual buttons being detected by measuring the
>different voltages resulting from the different resistances.
>
>It'd be worth taking a look at the sec_jack stuff that Samsung have used
>in at least some of their Android devices:
>
>  http://android.git.kernel.org/?p=kernel/samsung.git;a=blob;f=include/linux/sec_jack.h
>
>It's quite hard coded in code terms but it covers things like the
>debounce.
Thanks for the link.

-Harsha
