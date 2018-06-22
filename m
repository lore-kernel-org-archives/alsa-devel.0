From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 6/9] ALSA: usb: caiaq: use
	usb_fill_int_urb()
Date: Fri, 22 Jun 2018 12:01:13 +0200
Message-ID: <156bfc42-650f-1ac0-73d5-085556ae318c@zonque.org>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
 <20180619215521.13688-7-bigeasy@linutronix.de>
 <2f8cbd9b-55ad-d543-d26a-c4452717b121@zonque.org>
 <20180621211639.a7vym5mikaejvlgw@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 1647A2673CB
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 12:01:15 +0200 (CEST)
In-Reply-To: <20180621211639.a7vym5mikaejvlgw@linutronix.de>
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, tglx@linutronix.de, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Thursday, June 21, 2018 11:16 PM, Sebastian Andrzej Siewior wrote:
> On 2018-06-21 22:19:32 [+0200], Daniel Mack wrote:
>> On Tuesday, June 19, 2018 11:55 PM, Sebastian Andrzej Siewior wrote:
>>> Using usb_fill_int_urb() helps to find code which initializes an
>>> URB. A grep for members of the struct (like ->complete) reveal lots
>>> of other things, too.
>>
>> Acked-by: Daniel Mack <zonque@gmail.com>
> 
> nope, please don't.
> Takashi, please ignore the usb_fill_.* patches. I will be doing another
> spin with usb_fill_iso_urb() instead.

Hmm, there is no such thing as usb_fill_iso_urb() in my tree, are you 
going to add that?

The only part that needs attention is the interval parameter, which is 
passed to usb_fill_int_urb() as 1 now, and hence urb->interval will also 
be 1, just like the open-coded version before. Unless I miss anything, 
your conversion should work, but I haven't tested it yet.

But I agree the function name is misleading, so we should probably get a 
usb_fill_iso_urb() and use it where appropriate. AFAICS, it will be 
identical to usb_fill_bulk_urb(), as the endpoint type is encoded in the 
pipe. Maybe it's worth adding a check?


Thanks,
Daniel
