From: Daniel Mack <zonque@gmail.com>
Subject: Re: [Alsa-user] Ticks when playing to USB DAC at high
	sample rates
Date: Thu, 22 Nov 2012 22:08:41 +0100
Message-ID: <50AE9459.8030203@gmail.com>
References: <3884466.olklcBH31l@quintet> <509A235A.7000004@gmail.com>
 <509A240E.2000802@gmail.com> <1604587.9oeL4nKNxL@quintet>
 <50AE7FB3.9080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F3052615EE
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 22:08:47 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so3435506bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 13:08:47 -0800 (PST)
In-Reply-To: <50AE7FB3.9080500@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeffrey Barish <jeff_barish@earthlink.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 22.11.2012 20:40, Daniel Mack wrote:
> On 07.11.2012 18:05, Jeffrey Barish wrote:
>> On Wed 07 November 2012 10:04:14 Daniel Mack wrote:
>>> On 07.11.2012 10:01, Daniel Mack wrote:
>>>> On 07.11.2012 00:54, Jeffrey Barish wrote:
>>>>> I guess that snd_usb_pcm_prepare is called by the core usb system to
>>>>> prepare the snd driver.  Anyway, snd_usb_pcm_prepare calls
>>>>> configure_endpoint with a substream.  Then configure_endpoint calls
>>>>> snd_usb_endpoint_set_params with the data endpoint that corresponds to
>>>>> the substream.  snd_usb_endpoint_set_params calls data_ep_set_params
>>>>> with the data ep and data_ep_set_params sets nurbs to 2 for the data
>>>>> endpoint.
>>>>>
>>>>> snd_usb_endpoint_set_params has code to call sync_ep_set_params when the
>>>>> endpoint is type sync.  sync_ep_set_params sets nurbs to 4 (why?). 
>>>>> However, snd_usb_endpoint_set_params never invokes the call to
>>>>> sync_ep_set_params because ep->type is always data.  Back up:
>>>>> snd_usb_endpoint_set_params is called from configure_endpoint.  It is
>>>>> called from an if block contingent on the substream's having a sync
>>>>> endpoint.  It does.  However, the call to snd_usb_endpoint_set_params
>>>>> passes subs->data_endpoint as the first argument, so
>>>>> snd_usb_endpoint_set_params simply repeats the operations it performed
>>>>> as a result of the previous invocation.  I presume that the first
>>>>> argument to the second call to snd_usb_endpoint_set_params should be
>>>>> subs->sync_endpoint.> 
>>>> Eh. You clearly spotted a bug here. The rally interesting thing is that
>>>> that it didn't bite us earlier, as it's in since 3.6.
>>>>
>>>>>  I
>>>>>
>>>>> made that change.  Now freqm does change.  However, I am getting tons of
>>>>> ticks.  Now it sounds as if the payload size is always wrong.
>>>>>
>>>>> Oh, 44.1 kHz works.  48 kHz works.  88.2 and 96 don't work.
>>>>
>>>> That's a different issue. Would you like to prepare a patch for the
>>>> issue above please?
>>
>> I don't know how to prepare a patch, so I'm inclined to fix the remaining 
>> problem before stopping to figure out the patch problem.
>>
>> I didn't get your previous email.  I hope that it contained some suggestions 
>> on what to look for to solve the remaining problem.  Please send it again.  
>> The problem seems to be related to timing considering that the driver works 
>> perfectly 5-10% of the time, but timing of what?  I don't know what to look 
>> for.
> 
> So with the first problem sorted out, I guess the other one is related
> to to inexactly reported data feedback from the device. Some explanation
> about the current code.
> 
> The code in the lower half in snd_usb_handle_sync_urb(), endpoint.c does
> some auto-detection of the feedback rate format. This is done in order
> to cope with all the many devices use have all sorts of rate formats.
> When called for the first time after a stream start, it shifts the
> received value until it matches the nominal sampling frequency with an
> accuracy of +50% or -25%. Once the shift value is determined, it is
> saved for later reference. In case the values get badly of of bounds
> over subsequent calls, the code falls back to the auto-detection mode again.
> 
> In other words: if the device reports a bogus value in the very first
> feedback packet, but stays inside the limits of the thresholds that
> would make it fall back to auto-detection, the shift value will always
> be wrong for the duration of that stream, resulting in bogus data rates
> produced by the driver.
> 
> This is where I would have a look. Add some printk()s in the "if
> (unlikely(ep->freqshift == INT_MIN))" case and dump the values that are
> detected, for both a working and non-working case.

Btw - if that is the case, and the device stabilizes after a while, one
way to fix that problem is to simply ignore the first x packets that are
received. And there's already a quirks framework for that: initalize
ep->skip_packets from snd_usb_endpoint_start_quirk().


Daniel
