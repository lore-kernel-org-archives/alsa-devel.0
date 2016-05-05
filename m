From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/5] ALSA: pcm: Fix poll error return codes
Date: Thu, 5 May 2016 11:39:34 +0200
Message-ID: <cb0c26e2-d594-844d-62b3-36e6f2f830f6@ladisch.de>
References: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1462370351-15388-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <572A8534.4020207@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 34909261AFF
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 11:40:28 +0200 (CEST)
In-Reply-To: <572A8534.4020207@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, tiwai@suse.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On May 4 2016 22:59, Charles Keepax wrote:
>>  	if (PCM_RUNTIME_CHECK(substream))
>> -		return -ENXIO;
>> +		return POLLIN | POLLRDNORM | POLLERR;
>
> [...]
> On the other hand, I think POLLOUT, POLLIN, POLLWRNORM and POLLRDNORM
> should not be included in the value. PCM_RUNTIME_CHECK() ensures PCM
> substream or PCM runtime is NULL. This means that subsequent I/O
> operations are failed, at least for handling PCM frames.
>
> I think it better to return 'POLLERR | POLLHUP'.

To expand on this: POLLIN/POLLOUT imply that it is possible to read/
write data without blocking.  Sockets and pipes combine POLLHUP with
POLLIN because the read() (or recv()) returns 0 bytes without blocking
to indicate the end of the stream.

But in this situation, snd_pcm_read*/write* will always fail, so it is,
strictly speaking, indeed not appropriate to set POLLIN/OUT.

On the other hand, PCM devices do include the POLLIN/OUT bits when they
are in a wrong state.  (This is probably to catch programs that do not
check the error bits; with POLLIN/OUT set, these programs will try to
read/write, and will then get the error code.)

So for consistency, the bits should be included.  (Or the other error
case fixed to remove these bits.)


Regards,
Clemens
