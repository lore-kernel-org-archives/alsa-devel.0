From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Linking ALSA sequencer kernel clients to their
	device
Date: Thu, 11 Feb 2016 10:17:03 +0100
Message-ID: <56BC518F.7060902@ladisch.de>
References: <20160211075035.GA23857@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 513CA2605F2
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 10:17:03 +0100 (CET)
In-Reply-To: <20160211075035.GA23857@mail.zuhause>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Koegler <martin.koegler@chello.at>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Koegler wrote:
> In my domain, people use multiple identical USB-MIDI keyboards - each
> is assigned a different functions. They expect to kept this mapping
> across reboots.
>
> The sound card number are dynamic, therefore they can change after
> reboots. The only stable device ID is the sysfs path of the used USB
> port.
>
> This means, that I need to associate a kernel sequencer client number
> with a sysfs device.
>
> rawmidi devices expose the card number via IOCTLs, which allows to
> find the corresponding device in sysfs.
>
> The sequencer provides no identifing data. Chromium works around this
> issue by scanning rawmidi as well as sequencer devices and matching
> them by using assumtions, how the kernel register sequencer devices.

This information wouldn't be wrong in the commit message.

> So I thought about exposing the missing information via sysfs:

The ioctl API (and the library API on top of it) already exists.  Why
do you want to introduce another kind of API that cannot be used for
virtual devices?

Just add the card number to snd_seq_client_info.  (For kernel drivers;
user clients might have the PID here while we're at it.)


Regards,
Clemens
