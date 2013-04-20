From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: PCM buffering ussues ( or probably the lack of
 understanding )
Date: Sat, 20 Apr 2013 13:17:21 +0200
Message-ID: <51727941.20003@metafoo.de>
References: <5172401E.8020708@quicknet.nl> <51724930.3020406@metafoo.de>
 <5172750A.4030805@quicknet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 213272650EA
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 13:38:31 +0200 (CEST)
In-Reply-To: <5172750A.4030805@quicknet.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: marcelg <marcelsbox@quicknet.nl>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/20/2013 12:59 PM, marcelg wrote:
> Lars Peter,
> 
> Thanks for your reply.
> 
> Some things are more clear now, however one issue I still wonder.
> 
> 
> Quote
> 
> "
>> Suppose I want to have some buffering inside my pcm driver, how will I be
>> able to get some samples in advance before starting playback ? Can I just
>> call pcm_period_elapsed() a few times in  a row to get the buffer filled
>> before starting the actual playcback, or does this cause side effects ?
>>
> Why'd you want to do that?
> "
> 
> 
> If Alsa is not having an internal buffer as you pointed out. An my driver
> for example advertises
> min periods = 1  and max_periods = 10.   Then it means my drivers is capable
> of buffering up to 10 periods.
> 
> However what I notice is that the Alsa layer pcm_copy()  always supplies
> "period_bytes" after each call to period_elapsed()
> 
> This would imply that even my driver is able to buffer 10 periods, it never
> receives more data as one period, because I call period_elapsed()
> as soon as the data is consumed.


The ALSA core keeps track of how many bytes are available in your buffer. It
will supply your driver with as many bytes as there is space in the buffer.
So if you start playback you should see it supplying you more than one
period worth of bytes. Once the buffer is full you'll naturally only get one
new period of each period that has elapsed.

But as I said before if you don't do anything other then copying data to
your buffer in the copy callback, you should probably get rid of the copy
callback altogether and let ALSA take care of writing the data to your
buffer. This will also allow you to use for example mmap.

- Lars
