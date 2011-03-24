From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: driver silence callback
Date: Fri, 25 Mar 2011 10:11:43 +1300
Message-ID: <4D8BB38F.5030301@audioscience.com>
References: <4D8A910D.6030604@audioscience.com> <4D8AF100.90209@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 3566010380E
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 22:11:46 +0100 (CET)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LIK00FQPYVKUP50@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 25 Mar 2011 10:11:45 +1300 (NZDT)
In-reply-to: <4D8AF100.90209@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Clemens,

On 24/03/11 20:21, Clemens Ladisch wrote:
> When underrun detection is disabled, this mechanism can be used to fill
> some part of the buffer with silence immediately after the hardware has
> read from this part of the buffer, so that in case of an underrun, not
> the old data but silence is played.
> 
> In other words, the silence callbacks initializes the buffer, while the
> copy callback later fills the same part of the buffer with actual data.

Aha.  My silence callback was sending silence to the fifo, then the copy
callback can do nothing but append audio *after* the silence.
No wonder the audio was choppy!

>> In the case of my (older) hardware, once audio has been written via the
>> copy callback, it is gone (into a fifo), there is no way to overwrite
>> with silence.
> 
> Ensure that on a FIFO underrun, silence is played.  This might be the
> default on your hardware anyway.  :)

Yes, our hardware can't operate otherwise.   If I write 1000 frames to
the stream, it will play those and then stop.  i.e. output silence.

I think I still need a silence callback that does nothing, otherwise I
can't use the copy callback. (snd_pcm_lib_writev_transfer will fail and
call snd_BUG_ON)

--
Eliot
