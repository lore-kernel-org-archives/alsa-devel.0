From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: ASoC: cs4271: init/timing problem
Date: Wed, 1 Apr 2015 12:08:10 -0500
Message-ID: <alpine.DEB.2.10.1504011206320.13828@heelrod-desktop>
References: <551A5FC9.4010109@gmail.com>
 <alpine.DEB.2.10.1503311600000.13828@heelrod-desktop>
 <551BC102.6010403@gmail.com> <551BCE01.2070007@gmail.com>
 <9FF9C0F5-716B-4F31-AFAC-17B1C8991AB8@cirrus.com>
 <551C10B8.5080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077473.ppops.net (mx0a-001ae601.pphosted.com [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 30FCF265382
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 19:08:10 +0200 (CEST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by m0077473.ppops.net (8.14.7/8.14.7) with SMTP id t31Gw9Pa001961
 for <alsa-devel@alsa-project.org>; Wed, 1 Apr 2015 12:08:09 -0500
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
 by mx0a-001ae601.pphosted.com with ESMTP id 1tfw4tsk5b-1
 for <alsa-devel@alsa-project.org>; Wed, 01 Apr 2015 12:08:09 -0500
Received: from ex3.ad.cirrus.com (ex3.ad.cirrus.com [141.131.36.34])
 by mail1.cirrus.com (Postfix) with ESMTP id 9C27934036
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 12:08:29 -0500 (CDT)
In-Reply-To: <551C10B8.5080409@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

> >> I just lowered the clock-frequency to 50 kHz and I face the same
> >> problem, but it very much depends on the hardware. On some devices I
> >> don't face the problem at all and on others I can reproduce it very
> >> reliable. If I add a mdelay(20), or use the loop I postet earlier, the
> >> issue is gone on all devices.
> > Are there any other devices on the I2C bus? Lets take this off the ALSA list until there
> > is a determination that it is an ASoC issue which it does not appear to be right now.
> 
> Well I think it is. There is a delay needed in sound/soc/codec/cs4271.c
> at line 569, in certain cases, because the call to regmap_update_bits on
> line 570 fails sometimes. If I add a delay of a few us on line 569, the
> call never fails.
> 
> But let me just send in a patch so we really know what we are talking
> about, then.
> 
can you try something like this?

gpio_direction_output(cs4271->gpio_nreset, 0);
-udelay(1);
gpio_set_value(cs4271->gpio_nreset, 1);
/* Give the codec time to wake up */
-udelay(1);

gpio_direction_output(cs4271->gpio_nreset, 0);
+mdelay(1);
gpio_set_value(cs4271->gpio_nreset, 1);
/* Give the codec time to wake up */
+mdelay(1);

See if that helps instead of adding another delay.
