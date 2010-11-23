From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: bug in alsa-lib/snd_pcm_plugin_delay for capture?
Date: Tue, 23 Nov 2010 16:02:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011231601240.8433@eeebox2.perex-int.cz>
References: <AANLkTi=in6g2YxRKwkCi7H_v0jmJ9tOouc2FK-Rg8iDt@mail.gmail.com>
	<alpine.LNX.2.00.1011180927310.21207@eeebox2.perex-int.cz>
	<AANLkTikihnQxQa-1RednpZSpx5Rn5XEcZYJfcShh6HW7@mail.gmail.com>
	<alpine.LNX.2.00.1011221451250.8433@eeebox2.perex-int.cz>
	<AANLkTimuizeF+p23wrBg9CQFouhRHj2x6g7tD3bQ8g4=@mail.gmail.com>
	<alpine.LNX.2.00.1011231119271.8433@eeebox2.perex-int.cz>
	<AANLkTikOfbwCpeJprOOsNNSnLzZmv__EujTeTKoM8nPz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 38B64243C8
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 16:02:50 +0100 (CET)
In-Reply-To: <AANLkTikOfbwCpeJprOOsNNSnLzZmv__EujTeTKoM8nPz@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, wim.taymans@collabora.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Nov 2010, pl bossart wrote:

>> After rethinking, I believe that the right fix should be to add the
>> 'snd_pcm_mmap_capture_avail(pcm)' to the sd variable - delay(slave) - for
>> the capture direction. You should not bother with avail_update or the slave
>> avail values. The avail_update() capture loop just copied samples from the
>> producer (slave) to the consumer (pcm). It means that the avail becomes
>> lower for the producer (slave) and is increased for the consumer (pcm). The
>> delay(slave) already contains the avail(slave) value.
>>
>> So, the result should be 'delay(slave) + mmap_capture_avail(pcm)'.
>
> The attached patch implements your recoomendation and makes error
> messages go away in PulseAudio.

I applied your patch to the alsa-lib repo. Thank you for discovering and 
testing.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
