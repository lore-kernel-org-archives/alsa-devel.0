From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: AC97 atmel
Date: Thu, 11 Jun 2009 14:51:11 +0200
Message-ID: <4A30FDBF.4030809@atmel.com>
References: <4A30C6C6.9090205@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 09EE824656
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 14:51:29 +0200 (CEST)
In-Reply-To: <4A30C6C6.9090205@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

Sorry to bother you again, but I've tried to compile the ac97c.c driver =

based on =

http://www.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git and =

doing so I've got some errors:

   CC      sound/atmel/ac97c.o
sound/atmel/ac97c.c: In function 'atmel_ac97c_prepare_dma':
sound/atmel/ac97c.c:127: error: implicit declaration of function =

'dw_dma_cyclic_prep'
sound/atmel/ac97c.c:128: warning: assignment makes pointer from integer =

without a cast
sound/atmel/ac97c.c:135: error: dereferencing pointer to incomplete type
sound/atmel/ac97c.c:138: error: dereferencing pointer to incomplete type
sound/atmel/ac97c.c:142: error: dereferencing pointer to incomplete type
sound/atmel/ac97c.c: In function 'atmel_ac97c_playback_hw_params':
sound/atmel/ac97c.c:257: error: implicit declaration of function =

'dw_dma_cyclic_free'
sound/atmel/ac97c.c: In function 'atmel_ac97c_playback_trigger':
sound/atmel/ac97c.c:477: error: implicit declaration of function =

'dw_dma_cyclic_start'
sound/atmel/ac97c.c:489: error: implicit declaration of function =

'dw_dma_cyclic_stop'
sound/atmel/ac97c.c: In function 'atmel_ac97c_playback_pointer':
sound/atmel/ac97c.c:564: error: implicit declaration of function =

'dw_dma_get_src_addr'
sound/atmel/ac97c.c: In function 'atmel_ac97c_capture_pointer':
sound/atmel/ac97c.c:585: error: implicit declaration of function =

'dw_dma_get_dst_addr'
sound/atmel/ac97c.c: In function 'filter':
sound/atmel/ac97c.c:851: error: 'struct dma_chan' has no member named =

'private'
make[2]: *** [sound/atmel/ac97c.o] Error 1
make[1]: *** [sound/atmel] Error 2
make: *** [sound] Error 2

But if I use the linux-ketchup it will compile ok.

dw_dma_cyclic_prep is in drivers/dma/dw_dma.c on the linux-kecthup, but =

I can't find it on the git tree...
Am I missing something?

Regards,
Sedji
Sedji Gaouaou a =E9crit :
> Hi,
> =

> I have a patch which adds support for ATMEL AT91.
> I would like to know on which branch should I base my patch (linux =

> ketchup or =

> http://www.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git).
> =

> Regards,
> Sedji
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =
