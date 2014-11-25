From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 26/29] ALSA: oxfw: Add support AMDTP
	in-stream
Date: Tue, 25 Nov 2014 13:04:09 +0100
Message-ID: <54747039.6030105@ladisch.de>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>	<1414328610-12729-27-git-send-email-o-takashi@sakamocchi.jp>	<54691544.2020501@ladisch.de>	<546DC356.8010207@sakamocchi.jp>
 <54733889.8050303@ladisch.de> <54746395.4070807@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id F349C2605F5
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 13:04:10 +0100 (CET)
In-Reply-To: <54746395.4070807@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Nov 24 2014 22:54, Clemens Ladisch wrote:
>> In theory, it would be possible to use atomic_t to synchronize multiple
>> streams, but this requires that
>> 1. two CPUs that start a stream at the same time do not both think they
>>    are the first, ... and
>> 2. when one CPU is still starting a stream, code on all other CPUs must
>>    be able to work correctly, without synchronization.  [...]
>
> If I rewrite your pseudo code, like this:
>
>>    void start_some_substream(...)
>>    {
>>        if (atomic_inc_and_test(substreams)) {
>>            mutex_lock();
>>            // lots of stuff to start DMA ...
>
>              if (wait_for_first_packet() == ETIMEDOUT) {
>                  stop_dma();
>                  release_streams();
>                  mutex_unlock();
>                  return ETIMEDOUT;
>              }
>>            mutex_unlock();
>>        }
>>        ...
>>    }

This is an even better example of why atomic_t is incorrect:  when the
startup fails, the second call to start_some_substream() at the same
time, which just sees that substreams>0, cannot notice the error, and
thinks its own substream has been started successfully.


Regards,
Clemens
