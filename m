From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/5] ALSA: pcm: Fix poll error return codes
Date: Sat, 7 May 2016 03:11:35 +0900
Message-ID: <572CDE57.6050604@sakamocchi.jp>
References: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1462370351-15388-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <572A8534.4020207@sakamocchi.jp>
 <cb0c26e2-d594-844d-62b3-36e6f2f830f6@ladisch.de>
 <20160505114602.GF1646@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 7103E264F2D
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2016 20:11:38 +0200 (CEST)
In-Reply-To: <20160505114602.GF1646@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hi Charles and Clemens,

Sorry to be late.

On May 5 2016 20:46, Charles Keepax wrote:
> On Thu, May 05, 2016 at 11:39:34AM +0200, Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> On May 4 2016 22:59, Charles Keepax wrote:
>>>>  	if (PCM_RUNTIME_CHECK(substream))
>>>> -		return -ENXIO;
>>>> +		return POLLIN | POLLRDNORM | POLLERR;
>>>
>>> [...]
>>> On the other hand, I think POLLOUT, POLLIN, POLLWRNORM and POLLRDNORM
>>> should not be included in the value. PCM_RUNTIME_CHECK() ensures PCM
>>> substream or PCM runtime is NULL. This means that subsequent I/O
>>> operations are failed, at least for handling PCM frames.
>>>
>>> I think it better to return 'POLLERR | POLLHUP'.
>>
>> To expand on this: POLLIN/POLLOUT imply that it is possible to read/
>> write data without blocking.  Sockets and pipes combine POLLHUP with
>> POLLIN because the read() (or recv()) returns 0 bytes without blocking
>> to indicate the end of the stream.
>>
>> But in this situation, snd_pcm_read*/write* will always fail, so it is,
>> strictly speaking, indeed not appropriate to set POLLIN/OUT.
>>
>> On the other hand, PCM devices do include the POLLIN/OUT bits when they
>> are in a wrong state.  (This is probably to catch programs that do not
>> check the error bits; with POLLIN/OUT set, these programs will try to
>> read/write, and will then get the error code.)
>>
>> So for consistency, the bits should be included.  (Or the other error
>> case fixed to remove these bits.)

I agree with the Clemens's view. So this patch is OK to me.

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

But if we have the intention for including POLLIN/OUT, it's better to
add some comments about it.

> Thanks for the explaination guys. I definitely agree that all
> the return values should be consistent. I am happy to change the
> values if people prefer but I guess the decision really rests
> with Takashi and if he is happy to change the returns to
> POLLERR | POLLHUP, as I guess there is the potential for some
> user-space fall out. Perhaps I should do this as a seperate patch
> on top of this chain, so we can review explicitly.

I guess that this patch can be applied to ALSA PCM core separately from
the others for ALSA Compress core. So it's better to post two series;
one includes this patch, another includes the rest.

> I have had a look and both tinyalsa and alsalib look like they
> would handle the change correctly.

In the same time, it's better for us to consider that
userspace applications can be programmed directly to use
kernel/userspace interface without these I/O libraries.


Regards

Takashi (not-maintainer) Sakamoto
