From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: ich10 usb_host vs snd_usb_audio Hercules
	-	irq	broadcast.
Date: Fri, 24 Jul 2009 20:44:31 +0200
Message-ID: <4A6A010F.6050803@fisher-privat.net>
References: <4A68A52D.8050409@fisher-privat.net> <4A69766B.7090209@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 36643246EB
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 20:44:34 +0200 (CEST)
In-Reply-To: <4A69766B.7090209@ladisch.de>
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

Clemens Ladisch schrieb:
> Alexey Fisher wrote:
>> i found some time to investigate the issue with my "Hercules USB 5.1 
>> Cannel Audio Adapter". The issue is pretty tricky and depend to host 
>> hardware, in my situation this is Intel DG45ID board.
>>
>> Symptoms are: if i use this sound adapter after some time i'll get:
>> irq 16: nobody cared ... Disabling IRQ #16.
> 
> The USB audio driver does not manage USB interrupts; this is probably
> a problem with the USB controller driver or, more likely, with the
> interrupt routing.

Ok, i found how to reproduse it withous sound card... this is about 
lowspeed devices..
thank you,
Alexey
