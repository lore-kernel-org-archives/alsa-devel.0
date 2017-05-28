From: Hedde Bosman <sgorpi@gmail.com>
Subject: Re: Steinberg MIDEX8 driver attempt
Date: Sun, 28 May 2017 23:38:56 +0200
Message-ID: <CALgXJ_CTnsCFwZP31BzAUE3eBwqiwfwqefuXVL==8LDoXntUdg@mail.gmail.com>
References: <CALgXJ_Dkb8A6Xks_9q7FpmFVEm=XxK6y-oSL4VAM46mOrx+ZmA@mail.gmail.com>
 <40be4d95-3b45-5138-fbbc-775c8d779c8d@ladisch.de>
 <CALgXJ_CGyDNEnK+hteujqPKSjAMWLLX_aEceig66MpWeurh=2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com
 [209.85.220.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A6E2266C21
 for <alsa-devel@alsa-project.org>; Sun, 28 May 2017 23:38:57 +0200 (CEST)
Received: by mail-qk0-f173.google.com with SMTP id u75so37045153qka.3
 for <alsa-devel@alsa-project.org>; Sun, 28 May 2017 14:38:57 -0700 (PDT)
In-Reply-To: <CALgXJ_CGyDNEnK+hteujqPKSjAMWLLX_aEceig66MpWeurh=2g@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 28, 2017 at 10:49 PM, Hedde Bosman <sgorpi@gmail.com> wrote:
> Hi Clemens,
>
> thanks for responding.
>
> On Sun, May 28, 2017 at 10:16 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Hedde Bosman wrote:
>>> I've owned a MIDEX8 for some years now and am now attempting a driver
>>> for it. [...]
>>> it looks a bit like the standard usb midi class, but it requires some
>>> periodic (i guess timer) messages on endpoint 0x02
>>
>> Why "requires"?  What happens if you do not send them?
>
> Without sending those, the midi in does not seem to work.
>
>>
>>> Not all (interrupt) urbs that are submitted will complete (within 25
>>> ms at least).
>>
>> And why would that be a problem?
>
> I am not sure about the inner workings of the device. However, it
> seems to be a timing signal, that might be used to time-stamp midi in
> packets. I haven't been able to determine the exact impact, but did
> notice that sometimes the midi-in stops responding. If that is
> related, I cannot tell.
>
>>
>>> Sometimes after sending a few messages, an empty urb shows up in
>>> wireshark. However, in code, there's an if-statement that should allow
>>> only messages of length > 0 to be submitted (line 568, if (num_read >
>>> 0)).
>>
>> Try adding a check before the actual usb_submit_urb() call, but nothing
>> would protect against your code accidentally changing the
>> transfer_buffer_length of an active URB field later.
>
> I will try and report back later.

Even with such a check before usb_submit_urb, I still see an empty urb
appear on the timing endpoint (after which the midi in doesn't work
anymore). What seems to happen (during operations) is the following:
1. Several midi-in urbs are queued on EP 0x82, one is requested and
awaiting completion
2. After some time that midi-in urb is completed (due to a CC)
3. Another queued midi-in urb is requested (after 1.2 ms)
4. After 0.07 ms, a spurious timing-out urb appears on EP 0x02 (the
timing signal) with zero length data. (both are endpoint 2 but in
different directions)
5. Midi in stops working.

This happened even after adding a spinlock on any operations on EP
0x82 and 0x02 ... I'm lost here.

>
>>
>>> Might this have to do with issue 1?
>>
>> Not unless you have mixed up input and output URBs.
>
> afaik I did not. I am looking for better ways to debug though.
>
>>
>>
>> Regards,
>> Clemens
>
> Regards, Hedde
