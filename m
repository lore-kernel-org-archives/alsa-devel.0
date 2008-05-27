From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: bandwidth issue with usb-audio in alsa
Date: Tue, 27 May 2008 11:47:26 -0400
Message-ID: <9e4733910805270847pfd54b8flb13ab01e90f6e63a@mail.gmail.com>
References: <483C0847.1080405@singhkunal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FF5324431
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 17:47:28 +0200 (CEST)
Received: by rn-out-0910.google.com with SMTP id k32so1449368rnd.21
	for <alsa-devel@alsa-project.org>; Tue, 27 May 2008 08:47:26 -0700 (PDT)
In-Reply-To: <483C0847.1080405@singhkunal.com>
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
To: Kunal Singh <kunal@singhkunal.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/27/08, Kunal Singh <kunal@singhkunal.com> wrote:
> Hi,
>
>         I have some update on the issue which I had reported earlier. In my last e-mail, I had not mentioned that iPod is connected to the target through a USB (HS) Hub. When I connect the
>  same hub to my Desktop and read its configuration using "usbview" - I see that "interval" for this hub is mentioned
>  as "256 msec". (I have two hubs and I get all the results same with both the hubs).
>
>         With 36 URBs, the gap between two set of transactions is appx 220 msec (220+36 => 256). So, I am wondering
>  if the problem which I am seeing is because the external hub. I can not connect iPod directly to my target board,
>  because this board does not support enough current (as needed by iPod).

Some USB 2.0 hubs are single TT (transaction translator). If the hub
is single TT all low speed USB devices share that TT. The pause could
be caused by other things using the TT.

USB audio, keyboards, older devices, all USB 1.0 all use the TT.
Single vs multi-TT is the source of a most USB audio problems. Get a
USB 2.0 hub that supports multi-TT.  Of course the vendors don't
specify on the box single or multi-TT. Search on the web or email
their support group.

>         Can some one suggest, where is the problem - is it with the host controller driver?
>
>  Regards,
>  Kunal Singh
>
>  -----------------------------
>
>
>  Kunal Singh wrote:
>
>  Hi,
>
>   My Platform
>   -------------
>   I am trying to stream audio data from a USB-device (an iPod) to my
>  arm-based embedded device (running kernel 2.6.23). The USB-device confirms
>  to usb digital audio (subclass - streaming) class. The endpoint buffer size
>  196 bytes and transfer period is 1 msec. So, I should be reading data every
>  msec.
>
>   Problem
>   -----------
>   I am facing some bandwidth issues. The data is not being captured fast
>  enough.
>
>   I notice that once one set of URBs are captured (one set equal to
>  MAX_URBS), there is a significant delay in capturing the next set of URBs.
>
>      I have set MAX_URBS equal to 32.
>      When I connect a USB-Analyzer and analyze the timings, I can see that
>  32 URBs are captured at a interval of 1 msec each. After that there is a
>  break of around 250 msec. And then again 32 URBs captured in sequence.
>
>       If I change the MAX_URBs to any other value N, N URBs get captured at
>  interval of 1 msec each, and then there is a break.
>
>       Can some one suggest a way to improve this problem. Is there some
>  configuration or parameter which I can change, so that URBs get submitted
>  fast enough? May be as soon as the old one has retired.
>
>  Thanks and Regards,
>  Kunal
>  www.singhkunal.com
>
>
>
> _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
>  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Jon Smirl
jonsmirl@gmail.com
