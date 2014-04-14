From: Richard Storer <rstorer@ntlworld.com>
Subject: Re: snd-usb-audio issues??
Date: Mon, 14 Apr 2014 13:50:42 +0100
Message-ID: <CAA0fz9Y=EhoWBr5qMRabqf6acG-3yRCqtQcbOo9Xnn3yT3f4Vw@mail.gmail.com>
References: <CAA0fz9ZctzKNpcMCqR==rDdnGAk6yLf2Or_z=zi4XG7-QcHBmQ@mail.gmail.com>
 <534BD57F.6000006@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id B072B260799
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 14:50:44 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id k15so7981017qaq.15
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 05:50:42 -0700 (PDT)
In-Reply-To: <534BD57F.6000006@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My Sound Blaster is assigned to card1 (-c1) because the Pi already has
built-in audio playback capability.

root@raspberrypi:~# amixer scontents -c1
Simple mixer control 'PCM',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 85 [85%] [-7.50dB] [on]
Simple mixer control 'Mic',0
  Capabilities: cvolume cvolume-joined penum
  Capture channels: Mono
  Limits: Capture 0 - 15
  Mono: Capture 9 [60%] [13.50dB]
Simple mixer control 'CMSS LED',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Power LED',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]

Richard S.

On 14/04/2014, Clemens Ladisch <clemens@ladisch.de> wrote:
> Richard Storer wrote:
>> My first issue is for some reason booting Linux with my device already
>> attached to the USB port produces no audio output, however capture is
>> functioning.
>> I've tried mute, unmute via alsamixer but it seems like the amplifier
>> circuit inside hasn't turned itself on properly.
>> The cure for this (and 100% reproducible) would be to unplug / replug
>> the USB cable or simply connect to USB after Linux has fully loaded.
>
> Are there any mixer controls that have a different value in these
> situations?  (See the output of "amixer scontents" for your device.)
>
>> While Line-In capture does function on this device the signal levels
>> are extremely low.
>> Unfortunately there is no Line-In mixer control for my device
>
> What is the output of "amixer scontents" for your device?
>
>
> Regards,
> Clemens
>
