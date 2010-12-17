From: louis@museresearch.com
Subject: Re: Handling non-buffer-sized MMAP requests
Date: Fri, 17 Dec 2010 10:56:28 -0800
Message-ID: <6d88c8ff7e2badeb57f085af0e782dac.squirrel@master.museresearch.com>
References: <6e2495d80bd7915f371b984cc4b4a503.squirrel@master.museresearch.com>
	<4D05DFB9.3080407@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.museresearch.com (master.museresearch.com [69.59.28.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 913221037FC
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 19:56:37 +0100 (CET)
In-Reply-To: <4D05DFB9.3080407@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, louis@museresearch.com
List-Id: alsa-devel@alsa-project.org

Hi Clemens,
  Thanks for your reply

>> routine.  ALSA sometimes reports more samples available for input than
>> my
>> buffer can take, or asks for more samples than I have available.  Is
>> this
>> a buffer overrun/underrun?
>
> Yes.  (And this should happen only when you've disabled stopping on
> an xrun, so you've asked for it.  :-)

Ok, I found some old code which was enabling this behavior.  However, when
I took it out, I was still getting more input requests from ALSA than I
would expect (e.g. I expect in, out, in out, etc.  I get something like
in, out, in, in, out sometimes).  I am calling snd_pcm_link, which should
make the requests go in the correct order, right?

>> If I restart the streams in the case that too
>> much input is available (on the assumption that it's an xrun) it seems
>> to
>> happen at the drop of a hat and makes things worse.  If I discard the
>> excess input, that doesn't work well either.
>>
>> What is the appropriate way to deal with this situation?
>
> The best way would be to prevent this situation from happening, i.e.,
> read the captured data from the buffer before it overflows.

I'm not sure what you mean here.  I thought the whole reason it was
overflowing was that the CPU was too slow to keep up with the demand. 
What is the alternative?

> (In the case of capturing, latency does _not_ depend on the buffer size,
> so you should make the buffer as big as possible.)

Could you elaborate on this?  How does the input buffer work if the size
has no effect on the latency?

Thanks for your time,
Louis
