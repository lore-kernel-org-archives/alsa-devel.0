From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_open fails with -16 error
Date: Mon, 17 Oct 2011 13:12:24 +0200
Message-ID: <4E9C0D98.7090403@ladisch.de>
References: <4E97D849.1080502@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 2006E103874
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 13:12:01 +0200 (CEST)
In-Reply-To: <4E97D849.1080502@sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: irfan shaikh <irfan.shaikh@sasken.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

irfan shaikh wrote:
>                In my application i am closing and reopening my device to
> configure some hw_params for audio frequency change.

You should just set new hw_params on the same device.

> Close of PCM device is success, but reopen the same device fails
> 
> I get an below error
> snd_pcm_open() FAIL with return value -16 {Device or resource busy}

IIRC this could happen when using dmix on some old alsa-lib version.

> I have even tried to configure the HW params in run time to avoid above
> closing and opening of device.
> But run time HW params configuartion failed.

Thank you very much for keeping the error code a secret.

> Is there any way to change HW params at run time ? {My PCM device are in
> RUNNING state and i want to change HW params at run time}

Stop the device first.


Regards,
Clemens


> SASKEN BUSINESS DISCLAIMER: This message may contain ...

This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any disclaimers in those e-mails.
Additionally, disclaimers in those e-mails will incur legal processing
fees of $42 per line; you have agreed to this by reading this disclaimer.
