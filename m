From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Tue, 9 Nov 2010 18:13:50 +0530
Message-ID: <AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
	<AANLkTin58toyQJ0f3M3abszE0zgV+t9R29rsFKin74vk@mail.gmail.com>
	<alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E143E10384A
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 13:43:51 +0100 (CET)
Received: by ewy26 with SMTP id 26so683738ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 04:43:51 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 9, 2010 at 5:31 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Tue, 9 Nov 2010, Manu Abraham wrote:
>
>> testbox ~ # arecord -Dhw:2,0
>> Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
>
>> Any idea, why saa7231_hw_params is not getting invoked ?
>
> Your hw probably does not support directly 8-bit sample at 8000Hz, one
> channel. Use 'plughw:2,0' device instead 'hw:2,0' to let alsa-lib do all
> stream format conversions.

That didn't make any difference at all.

I just tried that, I get something like this :

testbox ~ # arecord -Dplughw:2,0
Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
ALSA lib pcm_params.c:2150:(snd1_pcm_hw_refine_slave) Slave PCM not usable
arecord: set_params:957: Broken configuration for this PCM: no
configurations available


[  719.292194] saa7231_capture_open (0): ()
[  719.292390] saa7231_hw_free (0): DEBUG: Removing IRQ event ..
[  719.292393] saa7231_remove_irqevent (0): Removing IRQ Event:43 ......
[  719.292395] saa7231_hw_free (0): DEBUG: Stream exiting ..
[  719.292397] saa7231_hw_free (0): DEBUG: Freeing ptable ...
[  719.292398] saa7231_capture_close (0): DEBUG: Closing stream
[  777.191250] saa7231_capture_open (0): ()
[  777.191441] saa7231_hw_free (0): DEBUG: Removing IRQ event ..
[  777.191444] saa7231_remove_irqevent (0): Removing IRQ Event:43 ......
[  777.191446] saa7231_hw_free (0): DEBUG: Stream exiting ..
[  777.191448] saa7231_hw_free (0): DEBUG: Freeing ptable ...
[  777.191450] saa7231_capture_close (0): DEBUG: Closing stream
[ 6928.076343] saa7231_capture_open (0): ()
[ 6928.076559] saa7231_hw_free (0): DEBUG: Removing IRQ event ..
[ 6928.076562] saa7231_remove_irqevent (0): Removing IRQ Event:43 ......
[ 6928.076565] saa7231_hw_free (0): DEBUG: Stream exiting ..
[ 6928.076567] saa7231_hw_free (0): DEBUG: Freeing ptable ...
[ 6928.076568] saa7231_capture_close (0): DEBUG: Closing stream

Best Regards,
Manu
