From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Firmware problem
Date: Wed, 19 Dec 2007 09:33:16 +0100
Message-ID: <1198053196.6226.1227354877@webmail.messagingengine.com>
References: <8b67d60712181251u3356bb72l9db08abf846cae9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id C05E2244E6
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 09:33:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8b67d60712181251u3356bb72l9db08abf846cae9b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian McMenamin <lkmladrian@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> My user - yes there is one - of the aica sound driver on the Dreamcast
> is having a problem with formware loading.
> 
> This is what he has sent me - anyone know what is wrong?
> 
> When loading snd-aica it gives:
> [   55.119676] ALSA sound/sh/aica.c:641: ALSA Driver for Yamaha AICA
> Super Inter
> 
> then after like 15 or 20 seconds it will give:
> FATAL: Error inserting snd_aica
> (/lib/modules/2.6.24-rc4/kernel/sound/sh/snd-aica.ko): Unknown symbol
> in module, or unknown parameter (see dmesg)

There isn't anything related to this in dmesg, so I guess this error
message is wrong.

This delay looks like the kernel timed out while waiting for userspace
to provide the firmware.

I think the snd-aica driver should output a big error message when
request_firmware() fails.


Regards,
Clemens
