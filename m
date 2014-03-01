From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 18/39] firewire-lib: Add a fallback at
	RCODE_CANCELLED
Date: Sat, 1 Mar 2014 15:20:50 +0100
Message-ID: <20140301152050.5de701a3@stein>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
 <20140228212535.7606e0d8@stein> <5311517B.5060905@sakamocchi.jp>
 <20140301111013.483fd7df@stein> <5311D0FC.7020302@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BF6A265334
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 15:20:54 +0100 (CET)
In-Reply-To: <5311D0FC.7020302@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mar 01 Takashi Sakamoto wrote:
[...]
>> I wonder:  Now that firewire-lib's use cases are expanded far
>> beyond LaCie Speakers and Griffin FireWave, do we need to implement
>> deferred transactions in firewire-lib too?
> 
> Yes. I confirmed some devices use deffered transaction for AV/C 
> CONTROL request.
> But I still pending this issue, because of the way to handle the 
> 'unspecified interval'.

Are these devices already supported or reported to work with FFADO?
If yes, then the interval is probably typically less than FFADO's built-in
FCP transaction timeout, i.e. 200 (or 400?) ms.

> I plan to solve this issue for my future work.

OK.

>> A related question:  Since FFADO applies 200 ms or more as FCP
>> transaction timeout, shouldn't firewire-lib's fcp.c increase
>> FCP_TIMEOUT_MS from 125 to 200 or more as well?
> 
> For this developing, I've spent much time with my test devices.
> But I've never experienced disadvantages under FCP_TIMEOUT_MS=125msec.
> So feel no importance.
> 
> If you feel this importance, please post your patch with proper reasons.

This is mostly a question to the ffado-devel subscribers.  125 ms is of
course enough for devices which comply with the specification in this
regard.  The question is whether FFADO developers know of devices (or
suspect devices) which exceed the standard 100 ms and need more like 200
ms.

In any case, this question is unrelated to your patch (apart from the
unlikely worst-case timeout which you noted in the changelog).

>> This is about case b) and, now that I think about it, also about case
>> a) in my list further above.
> 
> The case a) is for ctype=reserved. Current ALSA Firewire drivers don't 
> utilize it.
> So I have never considered about this case.

Of course; the kernel is never going to emit a reserved ctype.  And
if malicious or faulty userspace does, the specified target behavior is
exactly the desired behavior.

> For the case b), I'm optimistic because current fcp_avc_transaction() 
> don't return till the first AV/C response comes (or AV/C request is
> error). This means that the driver basically don't send any AV/C
> transaction at the same time.
> 
> Furthermore, my drivers basically generate some AV/C transaction in
> driver's probe/remove state or starting/stopping playback/capture of
> PCM samples/MIDI messages. So I believe that FFADO/ALSA rarely transfer
> some AV/C transactions at the same time.
> 
> In these reasons, I'm optimistic for device's ignorance of AV/C request.

>From what I understood so far, I agree.  (And besides, the specified
behavior of ignoring the command and not sending a response is of course
better than, for example, execution of a command but failure to send
the response.)
-- 
Stefan Richter
-=====-====- --== ----=
http://arcgraph.de/sr/
