From: Daniel Mack <zonque@gmail.com>
Subject: Re: Usb audio - unsuported sampling rates
Date: Tue, 10 Jul 2012 08:53:54 +0200
Message-ID: <4FFBD182.9040503@gmail.com>
References: <CADPOxSii6AGmyBmEYkBSs24Zd7fwasutf=HxTrB0xNqo4vuhXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5F13924538
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 08:53:58 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so3407177bkc.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Jul 2012 23:53:58 -0700 (PDT)
In-Reply-To: <CADPOxSii6AGmyBmEYkBSs24Zd7fwasutf=HxTrB0xNqo4vuhXg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: gordon.dilan@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 10.07.2012 07:25, Gordon Dilan wrote:
> I'm using an usb mic which(according to it's producer should support up to
> 48kHz sampling rate). The problem is ALSA allows me to use only 16 kHz for
> this device. I do not want to resample the data, I want to sample it at
> 48kHz in order to be able to record some high pitch sounds 18-20kHz.
> 
> I would want to try to do any modifications necessary in order to try
> support 48kHz, but I'm not sure where to start.

[...]

> Some more information:
> lsusb
> Bus 001 Device 007: ID 1415:2000 Nam Tai E&E Products Ltd. or OmniVision
> Technologies, Inc. Sony Playstation Eye
> 
> lsusb -t

Please also provide the output of 'lsusb -v'.

> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/2p, 480M
>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>         |__ Port 2: Dev 7, If 0, Class=vend., Driver=ov534, 480M
>         |__ Port 2: Dev 7, If 1, Class=audio, Driver=snd-usb-audio, 480M
>         |__ Port 2: Dev 7, If 2, Class=audio, Driver=snd-usb-audio, 480M
> 
> 
> At the moment I'm looking inside ALSA's source code to try to see from
> where this limitation of 16000kHz for my device appears, but I have to
> admit that I'm kind of lost.
> Any pointers on what direction should I go to try make my desired rate
> supported would be greatly appreciated!

The device is queried for its supported sample rates during probe using
class-specific commands. If it doesn't return all rates that are
actually supported, we need to add a quirk and override this list.

The list of known sample rates is included in
/proc/asound/card1/stream0. What does that show for you?



Daniel
