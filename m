From: "R. Lemos" <rslemos@gmail.com>
Subject: Re: On mixer controls naming
Date: Mon, 13 Jan 2014 14:56:37 -0200
Message-ID: <CAM6_cxz3ZOOtF4c9rY6-v6J-7GpXL14VVa0ajAXBZEsPCz=+HQ@mail.gmail.com>
References: <CAM6_cxyGVC+Tzt=6AM=LXn2Eqt48AK4JMSJkfbR07pPgPwBtcA@mail.gmail.com>
 <52D3CA28.3070500@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 64C2C26072A
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 17:56:38 +0100 (CET)
Received: by mail-qa0-f51.google.com with SMTP id f11so2362662qae.38
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 08:56:37 -0800 (PST)
In-Reply-To: <52D3CA28.3070500@ladisch.de>
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

Unfortunately it doesn't work for Tone Control.

I've tried the following (after each alternative is the output of amixer):

===== "Master Playback Bass" =====
Simple mixer control 'Master Playback Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 255
  Mono: 0 [0%]
===== "Master Playback Tone" =====
Simple mixer control 'Master Playback Tone',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 255
  Mono: 0 [0%]
===== "Playback Tone - Bass" =====
Simple mixer control 'Playback Tone - Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 255
  Mono: 0 [0%]
===== "Playback Tone Control - Bass" =====
Simple mixer control 'Playback Tone Control - Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 255
  Mono: 0 [0%]
===== "Playback Tone Control" =====
Simple mixer control 'Playback Tone Control',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 255
  Mono: 0 [0%]
===== "Tone Control - Bass" =====
Simple mixer control 'Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 255
  Mono: 123 [48%]
===== "Tone Control Playback - Bass" =====
Simple mixer control 'Tone Control Playback - Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 255
  Mono: 0 [0%]
===== "Tone Playback Control - Bass" =====
Simple mixer control 'Tone Playback Control - Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 255
  Mono: 0 [0%]


In each tested alternative capture channel shows up as mono (instead
of the expected behavior of showing nothing at all, as below). Each
control label also reverted to the full control name. Personally I
prefer the "Tone Control - Bass" alternative, which neatly shows up as
just "Bass". It would be perfect, were not the availability of a
capture channel for this control.


Note: previous amixer output elided to remove the the following common
working part for the "Master Playback Volume" and "Master Playback
Switch":

Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 255
  Mono: Playback 194 [76%] [on]



On Mon, Jan 13, 2014 at 9:12 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> R. Lemos wrote:
>> The other control I've named "Tone Control - Bass", as indicated in
>> writing-an-alsa-driver.pdf. But alsamixer shows it under both
>> "Playback" and "Capture" views.
>>
>> How can I restrict this latter control to just playback?
>
> For a control to be classified as a playback control, its name must
> have one of the suffixes " Playback Enum", " Playback Switch",
> " Playback Route", or " Playback Volume".
>
>
> Regards,
> Clemens



-- 
[]'s
Rodrigo
Powered by carbohydrates
