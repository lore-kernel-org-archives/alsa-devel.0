From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 6/9] ALSA: usb: caiaq: use
	usb_fill_int_urb()
Date: Fri, 22 Jun 2018 12:14:29 +0200
Message-ID: <20180622101428.wcdnlexsbcvltqpu@linutronix.de>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
 <20180619215521.13688-7-bigeasy@linutronix.de>
 <2f8cbd9b-55ad-d543-d26a-c4452717b121@zonque.org>
 <20180621211639.a7vym5mikaejvlgw@linutronix.de>
 <156bfc42-650f-1ac0-73d5-085556ae318c@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CDA92676DF
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 12:14:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <156bfc42-650f-1ac0-73d5-085556ae318c@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, tglx@linutronix.de, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 2018-06-22 12:01:13 [+0200], Daniel Mack wrote:
> Hmm, there is no such thing as usb_fill_iso_urb() in my tree, are you going
> to add that?

Yes.

> The only part that needs attention is the interval parameter, which is
> passed to usb_fill_int_urb() as 1 now, and hence urb->interval will also be
> 1, just like the open-coded version before. Unless I miss anything, your
> conversion should work, but I haven't tested it yet.

It should work in most cases. The point is that the argument expects
bInterval (from the endpoint) which has a different encoding on FS vs
HS/SS for INTR endpoints but not for ISOC endpoints and I got this wrong
initially.

> But I agree the function name is misleading, so we should probably get a
> usb_fill_iso_urb() and use it where appropriate. AFAICS, it will be
> identical to usb_fill_bulk_urb(), as the endpoint type is encoded in the
> pipe. Maybe it's worth adding a check?

What check?
it should be identical to INTR without the speed check (always the HS
version should be used). I need to check if it makes sense to extend the
parameters to cover ->number_of_packets and so on.
Any way, I plan to first RFC the function, land it upstream and then
convert the users.

> Thanks,
> Daniel

Sebastian
