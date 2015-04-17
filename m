From: Anoop Rajan <anoop@librewireless.com>
Subject: Support for Synchronous Audio
Date: Fri, 17 Apr 2015 08:07:54 +0000
Message-ID: <1429258074046.61439@librewireless.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0107.outbound.protection.outlook.com [207.46.100.107])
 by alsa0.perex.cz (Postfix) with ESMTP id B9832260524
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 10:07:57 +0200 (CEST)
Content-Language: en-IN
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

Hi All,


My self Anoop, an audio frame work developer, but a newbie to linux ALSA.

We have requirements to play synchronous multi-room audio with very minimal node to node latency(<100 us).( Node to node latency: How much one speaker is out of sync with other).  Right now we have logic in  user space to synchronize the audio using time stamps derived from a common clock, but the node to node latency is over 1ms. Though I make sure that I start the PCM  from user layer synchronously, the actual I2S out is out of sync(in consistent values ranging from 100 to 1ms). I beleive the un-deterministic path delay from user to ALSA buffer, big ALSA buffer(8k Samples), scheduling variances(high priority/interrupt preemption)   all might have added to this increased latency.

Rather than fine tuning the above discrepancies , I was thinking about some designs to pass the audio frames with time stamps  to kernel layer and to implement some logic in kernel (before pushing to DMA) to present the audio at exact stamped time to have a better node to node latency.

Before doing that I was trying to find out what ALSA supports for this requirement and from web could see various comments regarding this (proposal to  snd_pcm_start_at()<http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/082091.html>) and further proposed discussions on Audio mini summit, but I couldn't find further information's on it.

Would you please guide me. Does ALSA provides some means to achieve minimal Node to Node latency? would you please provide some pointers/documents to me to understand better.

Thanks,

Anoop
