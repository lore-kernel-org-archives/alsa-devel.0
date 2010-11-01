From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Balanced output support for Xonar: Patches for
 Virtuoso driver to add mixer option for balanced mono output (PCM179x dacs)
Date: Mon, 01 Nov 2010 16:59:54 +0100
Message-ID: <4CCEE3FA.8040706@ladisch.de>
References: <AANLkTimODNVWg7qgfcnmZ_CDYr4t5QvMenDknO1O8YhX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2BA2610381D
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 16:58:01 +0100 (CET)
In-Reply-To: <AANLkTimODNVWg7qgfcnmZ_CDYr4t5QvMenDknO1O8YhX@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Wisner-Carlson <christian@freedomofknowledge.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christian Wisner-Carlson wrote:
> I tested this thoroughly with an Asus Xonar Essence ST, although it
> should also work with the HDAV, Essence STX, and probably other cards.

D2/D2X, Xense.

> The patches that I am posting only give one control regardless of
> whether or not more than one DAC is connected. I have another patchset
> that gives individual control of all 4 dacs in the Xonar Essence ST+H6
> and HDAV+H6 setups (H6 is an optional daughterboard for surround sound).

BTW: any new information about the H6 problem?

> It allows for 4 balanced outputs, 8 unbalanced outputs, or any
> combination of balanced and unbalanced outputs. HOWEVER, it adds 4
> mixer controls and the code isn't very pretty.

The controller can route any stereo pair to each DAC, so it would be a
good idea to have one global control that also affects this routing so
that, e.g., configuring the card for 4 outputs works correctly when
playing 4-channel data.

Alternatively, having low-level controls for each detail of the hardware
is workable when somebody (i.e., you :-) writes a special graphical tool
to configure the Xonar outputs (any the other settings).

The Xense has one PCM1796 for the front channels and a CS4362A for the
other channels.  Like the stereo-only cards, this would result in an odd
number of channels in balanced mode, which is somewhat counterintuitive
because the controller would need to be fed an extra unused channel.

> Please tell me if this is not the correct way to post a patch, and
> tell me if it seems like a candidate to be merged.

Your mailer wrapped lines; see Documentation/email-clients.txt.
Also see Documentation/SubmittingPatches.

Overall, this patch looks good.  But I wouldn't want to apply it without
the followup patch that handles the D2's four DACs.

> @@ -532,6 +534,13 @@
>  		reg = PCM1796_OS_64;
>  	else
>  		reg = PCM1796_OS_32;
> +	
> +	if (data->monomode)
> +	        reg = reg | PCM1796_MONO;
> +	
> +	if (data->rightmono)
> +	        reg = reg | PCM1796_CHSL_RIGHT;
> +	
>  	for (i = 0; i < data->dacs; ++i)
>  		pcm1796_write_cached(chip, i, 20, reg);
>  }

This function's purpose is no longer to _only_ update the oversampling
setting; please rename it to, e.g., update_reg20.


Regards,
Clemens
