From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Error in configuring playback device
Date: Tue, 15 Mar 2011 15:07:00 +0100
Message-ID: <4D7F7284.3000002@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56A2@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 0D231103850
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 15:05:20 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB56A2@EXGMBX01.sasken.com>
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
> Can i alwayse close the device handle before opening it if pointer to playback handle exists
> 
> if(playback_handle)
>       snd_pcm_close(playback_handle);
> snd_pcm_open(playback_handle);

This will work, as long as you ensure that playback_handle is always set
to NULL when the device is actually closed.

> SASKEN BUSINESS DISCLAIMER: ... 

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
