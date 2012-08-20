From: "Sarawadi, Ravishankar" <c_rsaraw@quicinc.com>
Subject: Query on PCM lib: wait_for_avail() API
Date: Mon, 20 Aug 2012 17:34:26 +0000
Message-ID: <8AC98CC4185DF0498CE0734E6435A7C6B9D982@NASANEXD02C.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 by alsa0.perex.cz (Postfix) with ESMTP id 5921A265E54
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 19:34:28 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Greetings,

I recently started working with ALSA architecture.
I am very excited to be part of ALSA group and this is my first query as ALSA developer.

This is in regards to function wait_for_avail() defined in pcm_lib.c
If audio path is broken the wait_time inside this function is 10 seconds.
wait_time = msecs_to_jiffies(wait_time * 1000);

I have a use case where I need to force exit out of this wait when audio hardware path is broken.
Waiting for 10 seconds is too long and causing synchronization issues.

My Use-case:

1       PCM Audio playback is going on. PCM write is a blocking call. Waiting on DSP WRITE-DONE event.

2       Audio hardware path failure

3       PCM driver notified of hardware path failure.

4       Meanwhile DSP ring buffer gets full as buffers are not getting consumed.

5       Next WRITE is blocked on wait_for_avail() buffer call.

6       PCM close from driver as part process to handle audio path failure is blocked on Step 5


I am trying to figure out a way to exit out of this wait forcefully by some external trigger.
Another option is to reduce this wait time to less than 5 seconds.

Could someone please recommend the best way to handle this use case?

Thanks,
RaviShankar (Ravi)
