From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Tue, 26 Feb 2008 17:08:23 +0200
Message-ID: <43e8c7320802260708k7ad13632w83add5dfd76a31ac@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47C3C07B.2040104@ladisch.de>
	<43e8c7320802252353p2798488at87163c75a4511c4f@mail.gmail.com>
	<47C3CA77.5070104@ladisch.de>
	<43e8c7320802260038x17c2c350wade07dcd4f32cb3e@mail.gmail.com>
	<47C3D29B.9070708@ladisch.de>
	<43e8c7320802260120u241d2c83r97d7e00d4896992c@mail.gmail.com>
	<47C3F9BF.3080600@ladisch.de>
	<43e8c7320802260453m45c55ba5gb1756e288bf90808@mail.gmail.com>
	<47C42079.2030102@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 99B591038D7
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 16:08:28 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so1345146tia.8
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 07:08:26 -0800 (PST)
In-Reply-To: <47C42079.2030102@ladisch.de>
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

OK, I undertand

First of all, I am very happy with the patch you wrote, that just
solved the most annoying issue for me, that was the synchronization
problem.

Second, I did as you instructed with the USB sniffer. I opened the emu
control panel (the interface was set to 48kHz), saved the current log
file (as log1), set the rate to 96kHz, again saved the current log
file (as log2). I diff'ed the 2 files, resulting in a third section,
170 lines.
If you are interested in debugging the rate control, I can attach the
diff file (or the original logs, if necessary). Will this list allow
mail attachments? Of course, I am willing to test anything you like,
if you are willing to further debug this.

Thanks,
Adi

On Tue, Feb 26, 2008 at 4:21 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > I see, you say that the device knows what sample rate it is supposed
>  > to use, and that this rate should be automatically used.
>
>  Not automatically, the driver sets an alternate setting in set_format()
>  by calling usb_set_interface().
>
>  > ...
>
> > 2) I logically connect the device to the virtual machine, set the
>  > sampling rate to 96k through the creative supplied drivers,
>
>  Apparently, that driver uses some vendor-specific request to configure
>  the device.  To find out what exactly that driver does, you'd have to
>  use a tool like usbsnoop to record the USB requests.
>
>
>  Regards,
>  Clemens
>
