From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: snd_pcm_period_elapsed
Date: Sun, 16 May 2010 08:49:03 +0800
Message-ID: <AANLkTik_-NVvkO03xaBaAHloSf9XWjgtmxHuLbByBP41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BA0A624599
	for <alsa-devel@alsa-project.org>;
	Sun, 16 May 2010 02:49:05 +0200 (CEST)
Received: by pxi13 with SMTP id 13so1983991pxi.38
	for <alsa-devel@alsa-project.org>; Sat, 15 May 2010 17:49:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

>>> do snd_pcm_period_elapsed really handle the case when more than one period
>>> are elasped ?
>>>
>>> For au88x0 , each substream have four sets of hardware registers ,  it seem
>>> that the driver can recover lost interrupt with no underrun when using very
>>> small period size
>>>
>>>
>>> http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s07.html#pcm-interface-interrupt-handler-boundary <http://www.alsa-project.org/%7Etiwai/writing-an-alsa-driver/ch05s07.html#pcm-interface-interrupt-handler-boundary>
>>>
>>> On calling snd_pcm_period_elapsed()
>>>
>>> In both cases, even if more than one period are elapsed, you don't have to
>>> call snd_pcm_period_elapsed() many times. Call only once. And the pcm layer
>>> will check the current hardware pointer and update to the latest status.

>> Yes, the new code handles more alapsed periods, too. The in_interrupt
>> check is mainly for situations when period count == 1 and it compares
>> expected next hw_ptr for interrupt with hw_ptr computed from the hw_base
>> and actual position in the ring buffer.

>> 						Jaroslav

The value "delta" returned by vortex_adbdma_bufshift() seem to be the
number of sub-buffer(periods) elapsed
 ( the value can be 0 , 1 , 2 or 3 )

when aplay using very small period_size (e.g. 16 ) ,
the driver write message in system log when delta > 1 (i.e. more than
1 period have been elapsed )
but the sound is still ok since there are two more periods in the sub-buffer

But I cannot see any code in snd_pcm_period_elasped() add two period
size to hw_ptr
