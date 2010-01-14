From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_avail_update returns 0
Date: Thu, 14 Jan 2010 16:05:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001141604100.4324@eeebox2.perex-int.cz>
References: <3baf3d761001140641x41854ecax4012d8342ea22aaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5009B103872
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 16:05:41 +0100 (CET)
In-Reply-To: <3baf3d761001140641x41854ecax4012d8342ea22aaf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Singaravelan Nallasellan <singaravelann@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Jan 2010, Singaravelan Nallasellan wrote:

> Hi,
>
> Our audio driver uses the indirect PCM data transfer mechanism to
> transfer the buffer pointers and the size of the buffer to the Audio
> engine which DMAs the PCM data to the sound card.
>
> The driver uses the .ack callback to receive the buffer pointer and
> the size. It also sends it to the audio engine.
>
> We are facing a problem when we play long wav file using our driver.
>
> The application has written the PCM data and the ring buffer is full.
> snd_pcm_avail_update returns 0 sporadically. But the .ack callback was
> not called. The playback is stuck. It is not progressing.
>
> I have tried with pulseaudio (0.9.15) and with my own player. Both
> gives the same result.
>
> I would appreciate if somebody could provide some pointer to identify
> the cause of this issue. Let me know if anybody needs more info.

No idea. You may put some debug printk lines to snd_pcm_lib_write1() 
routine if all correspoding write sequences ends with ->ack callback 
call.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
