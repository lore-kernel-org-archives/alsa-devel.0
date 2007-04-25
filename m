From: Daniel James <daniel@64studio.com>
Subject: Re: crash/reboot with rawmidi on ice1712 dual opteron
Date: Wed, 25 Apr 2007 10:12:46 +0100
Message-ID: <462F1B8E.1040708@64studio.com>
References: <461FD727.8080400@bome.com>	<s5hfy6zcmtc.wl%tiwai@suse.de>	<4626361D.3080801@bome.com>	<s5hmz0y0w6m.wl%tiwai@suse.de>	<462E05BB.4000300@bome.com>	<s5h8xch28o2.wl%tiwai@suse.de>	<462E099A.7000702@bome.com>	<s5h7is1284n.wl%tiwai@suse.de>	<462E103A.3080601@bome.com>	<s5hzm4xzw8w.wl%tiwai@suse.de>	<462E19E0.6040206@bome.com>	<s5hps5tzue1.wl%tiwai@suse.de>
	<462E43B6.7050401@bome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pythagoras.zen.co.uk (pythagoras.zen.co.uk [212.23.3.140])
	by alsa0.perex.cz (Postfix) with ESMTP id F1BCD24994
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2007 11:13:19 +0200 (CEST)
In-Reply-To: <462E43B6.7050401@bome.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian <alsa@bome.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Florian,

> IT WORKED! I fixed it in this way:
> 
> mpu401_uart.c:229
> 
> if (mpu->hardware != MPU401_HW_TRID4DWAVE
>     && mpu->hardware != MPU401_HW_ICE1712) {
> 	mpu->write(mpu, 0x00, MPU401D(mpu));
> 	/*snd_mpu401_uart_clear_rx(mpu);*/
> }
> 
> I don't know if this will work on non-AMD machines and if it will
> work on all ice1712 machines...

I can test it here - which version is your patch against?

Cheers!

Daniel
