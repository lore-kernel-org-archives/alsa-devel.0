From: Christian Wisner-Carlson <christian@freedomofknowledge.org>
Subject: Re: Balanced output support for Xonar: Patches for
 Virtuoso driver to add mixer option for balanced mono output (PCM179x dacs)
Date: Wed, 3 Nov 2010 00:50:13 -0400
Message-ID: <AANLkTinEWKjLX2eVABVVTXP=mZyb_hphh8N0OzoHETyD@mail.gmail.com>
References: <AANLkTimODNVWg7qgfcnmZ_CDYr4t5QvMenDknO1O8YhX@mail.gmail.com>
	<4CCEE3FA.8040706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2BF88244D0
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 05:50:13 +0100 (CET)
Received: by fxm1 with SMTP id 1so155601fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Nov 2010 21:50:13 -0700 (PDT)
In-Reply-To: <4CCEE3FA.8040706@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> It allows for 4 balanced outputs, 8 unbalanced outputs, or any
>> combination of balanced and unbalanced outputs. HOWEVER, it adds 4
>> mixer controls and the code isn't very pretty.
>
> The controller can route any stereo pair to each DAC, so it would be a
> good idea to have one global control that also affects this routing so
> that, e.g., configuring the card for 4 outputs works correctly when
> playing 4-channel data.

Currently, routing is set up by void oxygen_update_dac_routing(struct
oxygen *chip) in oxygen_mixer.c.
However,  it only allows for five different routing configurations,
which it statically defines internally as int reg_values[5].
Do you mind (ie, would you mind merging/using it) if I defined a new struct:
struct oxygen_routing_table = {
	u8 channels;
	unsigned int dac0;
	unsigned int dac1;
	unsigned int dac2;
	unsigned int dac3;
}
that would be passed to oxygen_update_dac_routing() as a new field of
struct oxygen? This would allow for
arbitrary routing configurations for the dacs (needed to implement 4
channel balanced output) and would
not require many changes to the driver as a whole. Where should I
define this struct? (ie, in what file?)

Thanks,
Christian Wisner-Carlson
