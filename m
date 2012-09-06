From: Daniel Mack <zonque@gmail.com>
Subject: Re: UAC2 clock selector for AudioBox 1818VSL
Date: Thu, 06 Sep 2012 22:53:01 +0200
Message-ID: <50490D2D.3060207@gmail.com>
References: <76bd1b6473c857ddd3160280e278e4fb.squirrel@master.museresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id F043D261616
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 22:53:08 +0200 (CEST)
Received: by bkuw5 with SMTP id w5so870160bku.38
 for <alsa-devel@alsa-project.org>; Thu, 06 Sep 2012 13:53:08 -0700 (PDT)
In-Reply-To: <76bd1b6473c857ddd3160280e278e4fb.squirrel@master.museresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: louis@museresearch.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 06.09.2012 22:20, louis@museresearch.com wrote:
> Hi!
>   I'm attempting to get the "Clock Selector" mixer control to work with
> the PreSonus AudioBox 1818VSL (a UAC2 device).
>
> The control shows up in amixer as an enumerated value, but I don't seem to
> be able to set it (I've tried amixer, alsactl, and setting it
> programmatically). The possible values are correct (listing Internal
> Clock, S/PDIF Clock, and ADAT Clock as possible options); It just doesn't
> appear to take my setting, by which I mean amixer doesn't update the
> settings, I still have the occasional click when the sampling rates match
> over S/PDIF and I attempt to use external sync. No error is returned.
> 
> After digging around USB specs and ALSA's usb/mixer.c and being unfamiliar
> with both the USB audio spec and the inner workings of ALSA, I thought
> it'd be best to ask the list about this: How would I check to see if ALSA
> is asking the device to change clock source at all?

Hmm. A clock selector is handled like any other control entity on the
hardware. Some thoughts:

- Are you able to control other settings like the volume?

- It's fairly common for devices to not accept a new clock source
setting if they can't lock to the external source within some time. Did
you connect anything to the digital inputs?

- Are you able to control that setting with the native Mac OS X driver?
(IOW, without installing a 3rd-party driver)

Also, please send the output of "lsusb -v" for that device.


Daniel
