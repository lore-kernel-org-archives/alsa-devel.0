From: Adish Kuvelker <adkuvi@gmail.com>
Subject: DMA Physical Addr Issue.
Date: Mon, 19 Jul 2010 17:35:59 +0530
Message-ID: <AANLkTilhwORMM9UVYAm-ENDwcMjV8lHse6_Lu3k-gtAr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CE0EF1037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 14:06:00 +0200 (CEST)
Received: by vws9 with SMTP id 9so4531290vws.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2010 05:05:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I have allocated the DMA memory using the function
"snd_pcm_lib_preallocate_pages_for_all" passing SNDRV_DMA_TYPE_DEV and
"card->dev" as inputs to the function. Later, in the hw_params call
out function I allocate pages to the requested DMA memory region using
the function "snd_pcm_lib_malloc_pages".

I play a wav file "Noise.wav" from command line by giving the following command

./aplay --file-type wav -f dat Noise.wav

And, when I print the DMA region physical address in the "prepare"
call out through "dma_addr" member of the runtime structure I get a
weird decimal value of "-1036562432" as the physical address.

Can anyone point where I might be going wrong in the whole DMA memory
allocation?

Regards;
Aadish
