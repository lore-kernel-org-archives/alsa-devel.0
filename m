From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Re: Tascam US122 on Arm
Date: Wed, 3 Oct 2007 14:37:06 -0600
Message-ID: <8e4fc8270710031337x66778c0bn7bd3c42e93f97ddc@mail.gmail.com>
References: <200709300116.50747.st@iss.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E860244B8
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Oct 2007 22:37:07 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so4636546fka
	for <alsa-devel@alsa-project.org>; Wed, 03 Oct 2007 13:37:07 -0700 (PDT)
In-Reply-To: <200709300116.50747.st@iss.tu-darmstadt.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ST <st@iss.tu-darmstadt.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/29/07, ST <st@iss.tu-darmstadt.de> wrote:
> So my question is now, is the 250Mhz ARM really to slow or is there any chance
> that there is an error in either the usb stack or the driver exposed only on
> the ARM architecture? Things speaking for the latter are:
> *Error allways in the 65536-65540 value.
> *Error happens most of the times after about 50secs.

I've had usb-related error messages with the Tascam US-428 on my AMD
64x2 4600.  It looks like you've got a 32-bit error code integer being
forced into an unsigned 16-bit integer, or some function is returning
-1 in a 16-bit integer (which would be 65535 if unsigned), and the
driver is putting it in a 32-bit integer without sign extension and
incrementing it as though it is the number of the usb frame.  Look
through the driver code to see where that value is assigned to a
variable, and find out what function is doing it.  Basically, since
it's happening right after the limits of a 16-bit integer, I'd say
it's either an overflow error, or an error code is being returned in
the wrong kind of variable (signed vs. unsigned).  In my case, what
solved my USB error messages was disabling PowerNow CPU frequency
scaling.

Mike Bourgeous
