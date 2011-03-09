From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Query about Playback device name
Date: Wed, 09 Mar 2011 12:45:43 +0100
Message-ID: <4D776867.9040905@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5681@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id CAEC5103819
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:44:21 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5681@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Irfan Shaikh wrote:
> aplay uses following device
> "aplay -Dplug:mcasp3 411.2Kbps-44.1Khz-16bits-2CH-PCM.wav"
> 
> I want to use same device i.e "plug:mcasp3" in my plaback application
> 
> Can i use following section of code to use "plug:mcasp3" as playback device?
> 
>     alsaParams->playback_device = strdup("plug:mcasp3");
>     if (snd_pcm_open(&alsaParams->playback_handle,
>                      alsaParams->playback_device,

Yes.

> SASKEN BUSINESS DISCLAIMER:

*** DISCLAIMER ***
This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any disclaimers in those e-mails.
Additionally, disclaimers in those e-mails will incur legal processing
fees of $42 per line; you have agreed to this by reading this disclaimer.


Regards,
Clemens
