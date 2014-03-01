From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 18/39] firewire-lib: Add a fallback at
	RCODE_CANCELLED
Date: Sat, 01 Mar 2014 21:22:20 +0900
Message-ID: <5311D0FC.7020302@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
 <20140228212535.7606e0d8@stein> <5311517B.5060905@sakamocchi.jp>
 <20140301111013.483fd7df@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 58EC526530C
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 13:22:29 +0100 (CET)
In-Reply-To: <20140301111013.483fd7df@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

 > This 125 ms part of the calculation made me wonder what the split
 > transaction timeout of FCP transactions is (I didn't remember), so I
 > looked it up and wrote down what I found.  So, all of the rest of my
 > reply was not really a direct comment to your patch but merely a loosely
 > related side note.

I think it's not a proper action in this ML...

My intent of this comment is for a notice about time till returining 
from fcp_avc_transaction().
It might be much time against developer's expectation.


 > Correction:  CONTROL or NOTIFY.  (In contrast, STATUS or SPECIFIC INQUIRY
 > or GENERAL INQUIRY commands can only be performed in immediate
 > transactions.  See AV/C v4.2 table 19.  Likewise, already AV/C v1.0 
allows
 > INTERIM response only to CONTROL or NOTIFY commands.)

I confirm my mistake, thanks for your correction ;)


 > I wonder:  Now that firewire-lib's use cases are expanded far beyond 
LaCie
 > Speakers and Griffin FireWave, do we need to implement deferred
 > transactions in firewire-lib too?

Yes. I confirmed some devices use deffered transaction for AV/C CONTROL 
request.
But I still pending this issue, because of the way to handle the 
'unspecified interval'.

I plan to solve this issue for my future work.
This series of patch is the most I can do, now.


 > A related question:  Since FFADO applies 200 ms or more as FCP 
transaction
 > timeout, shouldn't firewire-lib's fcp.c increase FCP_TIMEOUT_MS from 125
 > to 200 or more as well?

For this developing, I've spent much time with my test devices.
But I've never experienced disadvantages under FCP_TIMEOUT_MS=125msec.
So feel no importance.

If you feel this importance, please post your patch with proper reasons.


 > This is about case b) and, now that I think about it, also about case a)
 > in my list further above.

The case a) is for ctype=reserved. Current ALSA Firewire drivers don't 
utilize it.
So I have never considered about this case.

For the case b), I'm optimistic because current fcp_avc_transaction() 
don't return
till the first AV/C response comes (or AV/C request is error). This 
means that
the driver basically don't send any AV/C transaction at the same time.

Furthermore, my drivers basically generate some AV/C transaction in driver's
probe/remove state or starting/stopping playback/capture of PCM samples/MIDI
messages. So I believe that FFADO/ALSA rarely transfer some AV/C 
transactions
at the same time.

In these reasons, I'm optimistic for device's ignorance of AV/C request.

Anyway, I appreciate your advices. Thank you to spend time for my 
developing.


Takashi Sakamoto
o-takashi@sakamocchi.jp
