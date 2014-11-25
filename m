From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 26/29] ALSA: oxfw: Add support AMDTP
	in-stream
Date: Wed, 26 Nov 2014 07:41:36 +0900
Message-ID: <547505A0.9000409@sakamocchi.jp>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>	<1414328610-12729-27-git-send-email-o-takashi@sakamocchi.jp>	<54691544.2020501@ladisch.de>	<546DC356.8010207@sakamocchi.jp>	<54733889.8050303@ladisch.de>
 <54746395.4070807@sakamocchi.jp> <54747039.6030105@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C3D12659E5
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 23:41:44 +0100 (CET)
In-Reply-To: <54747039.6030105@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Nov 15 2014 21:04, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> If I rewrite your pseudo code, like this:
>>
>>>    void start_some_substream(...)
>>>    {
>>>        if (atomic_inc_and_test(substreams)) {
>>>            mutex_lock();
>>>            // lots of stuff to start DMA ...
>>
>>              if (wait_for_first_packet() == ETIMEDOUT) {
>>                  stop_dma();
>>                  release_streams();
>>                  mutex_unlock();
>>                  return ETIMEDOUT;
>>              }
>>>            mutex_unlock();
>>>        }
>>>        ...
>>>    }
> 
> This is an even better example of why atomic_t is incorrect:  when the
> startup fails, the second call to start_some_substream() at the same
> time, which just sees that substreams>0, cannot notice the error, and
> thinks its own substream has been started successfully.

Yes. The reference counter is invalid in this pseudo code which I
showrf. I left your insistence about 'atomic_inc_and_test()' what it is.

More precisely, current implementations (bebob/fireworks/dice) are (or
should be for oxfw) like:

void start_some_substream(...)
{
    mutex_lock();

    if (atomic_read(substreams) == 0)
        goto end;

    if (streams_are_running())
        goto end;

    if (!start_isochronous_context_and_dma()) {
        release_isochronous_context_and_dma();
        release_streams();
        goto end;
    }

    if (wait_for_first_packet() == ETIMEDOUT) {
        release_isochronous_context_and_dma();
        release_streams();
    }
end:
    mutex_unlock();
    return err;
}

I believe that the reference counter with atomic_t is valid regardless
of inner/outer the lock (mutex). For this critical section, it's just a
importance that some substreams already subscribe the stream or not,
instead of the number of substreams.

If the reference counter is non-zero, it means that 'a stream is
requested to run for some substream, even if the substreams are not for
current caller'.

I don't show in the pseudo code; when the streams are already running
but the sampling transfer frequency is not the same as the one which the
caller requested, then the streams are stopped once and set sampling
transfer frequency and restart them.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
