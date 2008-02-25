From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Mon, 25 Feb 2008 20:32:38 +0200
Message-ID: <43e8c7320802251032j7541ac02t1459ef83d95dfd4e@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47BEDF9E.3000907@ladisch.de>
	<43e8c7320802220651r25ac78d7pecca63f3e1d48249@mail.gmail.com>
	<47BEEF4D.4050507@ladisch.de>
	<43e8c7320802220815y332a82f4kac19999cc15fd276@mail.gmail.com>
	<47BEF8FE.4030408@ladisch.de>
	<43e8c7320802220846g7d7c8b61jb29e8ca3028d2c24@mail.gmail.com>
	<47BEFFFC.8030301@ladisch.de>
	<43e8c7320802220902j3a4ff3a1wdae77ec25f2d3785@mail.gmail.com>
	<47C2B822.7000507@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 983971037FE
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 19:32:42 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so975731tia.8
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 10:32:40 -0800 (PST)
In-Reply-To: <47C2B822.7000507@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for the update.
I tested your patch and 44.1kHz, 48kHz and 96kHz seem to work
correctly. Unfortunately, I am not able to test any rate higher than
96kHz, because I cannot modify this interface's sampling rate under
Linux (and if I modify it on another computer [a virtual machine], the
interface will reset to 44.1kHz whenever I "unplug the USB cable" AND
it is set to a rate higher than 96kHz).

I don't know if there's any way around this, but I currently don't see
any way of using this interface at >96kHz in Linux.

Best regards,
Adi

On Mon, Feb 25, 2008 at 2:44 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > I *think* the 0202 USB is also in the same situation.
>
>  OK, I made a quirk for both:
>  <http://hg.alsa-project.org/alsa-kernel/rev/247195dfda43>
>
>  Please also test with a sample format where packets are sent every four
>  microframes, i.e., > 96 kHz.
>
>
>  Regards,
>  Clemens
>
