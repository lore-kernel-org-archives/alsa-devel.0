From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_avail_update returns 0
Date: Thu, 14 Jan 2010 16:31:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001141624260.4324@eeebox2.perex-int.cz>
References: <3baf3d761001140641x41854ecax4012d8342ea22aaf@mail.gmail.com>
	<alpine.LNX.2.00.1001141604100.4324@eeebox2.perex-int.cz>
	<3baf3d761001140717j755c13bbg4f682ac6940911a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 58358103888
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 16:31:11 +0100 (CET)
In-Reply-To: <3baf3d761001140717j755c13bbg4f682ac6940911a2@mail.gmail.com>
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

> Thanks for the response.
>
> I am using mmap for the playback. What is the return value of
> snd_pcm_avail_update when the ring buffer is empty?

ring buffer size

> How does ALSA identify the  empty buffer?

hw_ptr == appl_ptr

> We incremented the hardware pointer continuously to large value more
> than the hw buffer size. ALSA core did not round of the hw_ptr
> properly. The firmware in the audio engine is now rounding of hw ptr
> in the audio engine itself. It will always report the hw ptr between 0
> and hw buffer size.

hw_ptr and appl_ptr are from range 0..boundary to detect xruns. The driver 
should not write to these values and should track own pointers.

> Moreover our driver uses the batch mode and updates the hardware
> pointer for every period. Is it the right way to do?

I'm not sure about what pointers you're talking. If it's hw_ptr and 
appl_ptr, then driver shouldn't write to these pointers. The 
snd_pcm_period_elapsed() function should be called to synchronize hw_ptr 
when playback of period is finished.

Maybe you can put your code to a public place so we can check it.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
