From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Creative X-Fi USB 5.1 Driver
Date: Wed, 4 Feb 2009 19:13:00 -0500
Message-ID: <75b66ecd0902041613y671a18a3td84fc388e9523b42@mail.gmail.com>
References: <mailman.2424.1233760765.1965.alsa-devel@alsa-project.org>
	<975548.87386.qm@web35605.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id D2AA31038B8
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 01:13:01 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so2544437rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 04 Feb 2009 16:13:00 -0800 (PST)
In-Reply-To: <975548.87386.qm@web35605.mail.mud.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mandar Joshi <emailmandar@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 4, 2009 at 11:57 AM, Mandar Joshi <emailmandar@yahoo.com> wrote:
>>>Does this mean thet the X-Fi,Crystalizer features of the USB X-Fi are implemented purely in software?
> I think this might be the case.
> I started SniffUSB under WindowsXP and tried changing the settings using
> the audio console software provided by Creative.
>
> When changing the Speaker selection (2.1/4.1/5.1), data is sent over usb to the device.
> However, when I try to change the settings for the X-Fi Crystalizer or EAX or CMSS-3D or Graphic Equalizer
> nothing gets sent to the device but the audio output does change and I am able to hear the corresponding effects.
>
> And as mentioned in my previous post, the lsusb output doesn't show any effect descriptors or feature units
>
> If this is in fact true that all the xtreme fidelity(X-Fi) stuff is happening in software alone, my purchase has been
> a total waste!! Does anybody on this list have a USB X-Fi 5.1 that they can use to verify my observations?

Yes, all the effects are done in software.  Even on many PCI cards
Creative implements the effects in the Windows driver.

Lee
