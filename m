From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] ALSA: Reduce delay for a blocking pcm_drain.
Date: Mon, 30 Sep 2013 16:13:38 +0200
Message-ID: <52498712.5080002@ladisch.de>
References: <1380340785-30427-1-git-send-email-dgreid@chromium.org>
 <CAN8cciamcg3wqiDV75oZ6dms-aNtN2o-QMWg0n59otibpmfV7A@mail.gmail.com>
 <CAN8ccia8VzuubtiOZETTN5DAm_LjmQdaxqDHQQ6iv8S_NvtSBg@mail.gmail.com>
 <CAN8ccibYW3XaXMSGqGpb5-8aip0OTLyG5pyURjX8KL=RcmaYqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2E646261A50
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 16:13:41 +0200 (CEST)
In-Reply-To: <CAN8ccibYW3XaXMSGqGpb5-8aip0OTLyG5pyURjX8KL=RcmaYqQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, Dylan Reid <dgreid@chromium.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
>> To test this I opened a pcm and set no period wakeups, played a few samples and
>> then called drain, which hung indefinitely.  Using a USB headset with a
>> max period size of 128k but only 15ms of the buffer filled, having the
>> drain time shorter without losing samples makes a blocking call
>> feasible.
>
> Do you mean that you tested on a patched version of USB audio driver since
> only three drivers support SNDRV_PCM_INFO_NO_PERIOD_WAKEUP

The flag is ignored if not supported.

In this test, the important part was the large period size.


Regards,
Clemens
