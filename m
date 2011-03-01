From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_prepare FAILS
Date: Tue, 01 Mar 2011 14:48:22 +0100
Message-ID: <4D6CF926.3000608@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5669@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C76C1103854
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 14:47:14 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5669@EXGMBX01.sasken.com>
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
> err=snd_pcm_prepare(handle);
> if (err < 0)
>      RSE_TRACE_ERROR(MP_ALSA_TRACE,("Can't recovery from underrun, prepare failed: %s\n", snd_strerror(err)));
> 
> Output : Can't recovery from underrun, prepare failed: Device or resource busy

This error comes from the device driver (whatever it is).


Regards,
Clemens


> SASKEN BUSINESS DISCLAIMER: ...

EVEN MORE IMPORTANT DISCLAIMER:
This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any disclaimers in those e-mails.
Additionally, disclaimers in those e-mails will incur legal processing
fees of $42 per line; you have agreed to this by reading this disclaimer.
