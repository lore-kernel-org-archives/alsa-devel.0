From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Steinberg MIDEX8 driver attempt
Date: Sun, 28 May 2017 22:16:50 +0200
Message-ID: <40be4d95-3b45-5138-fbbc-775c8d779c8d@ladisch.de>
References: <CALgXJ_Dkb8A6Xks_9q7FpmFVEm=XxK6y-oSL4VAM46mOrx+ZmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EE6F266C21
 for <alsa-devel@alsa-project.org>; Sun, 28 May 2017 22:18:33 +0200 (CEST)
In-Reply-To: <CALgXJ_Dkb8A6Xks_9q7FpmFVEm=XxK6y-oSL4VAM46mOrx+ZmA@mail.gmail.com>
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
To: Hedde Bosman <sgorpi@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hedde Bosman wrote:
> I've owned a MIDEX8 for some years now and am now attempting a driver
> for it. [...]
> it looks a bit like the standard usb midi class, but it requires some
> periodic (i guess timer) messages on endpoint 0x02

Why "requires"?  What happens if you do not send them?

> Not all (interrupt) urbs that are submitted will complete (within 25
> ms at least).

And why would that be a problem?

> Sometimes after sending a few messages, an empty urb shows up in
> wireshark. However, in code, there's an if-statement that should allow
> only messages of length > 0 to be submitted (line 568, if (num_read >
> 0)).

Try adding a check before the actual usb_submit_urb() call, but nothing
would protect against your code accidentally changing the
transfer_buffer_length of an active URB field later.

> Might this have to do with issue 1?

Not unless you have mixed up input and output URBs.


Regards,
Clemens
