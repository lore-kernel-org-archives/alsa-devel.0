From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: usb: Parse UAC2 extension unit like
 for UAC1
Date: Tue, 19 Mar 2013 20:26:22 +0100
Message-ID: <5148BBDE.3020002@gmail.com>
References: <20130319161214.GB7539@pvv.ntnu.no> <s5h7gl3l3ls.wl%tiwai@suse.de>
 <20130319181038.GC7539@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id AF3F92615D7
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 20:26:29 +0100 (CET)
Received: by mail-bk0-f48.google.com with SMTP id jf20so405473bkc.21
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 12:26:29 -0700 (PDT)
In-Reply-To: <20130319181038.GC7539@pvv.ntnu.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19.03.2013 19:10, Torstein Hegge wrote:
> On Tue, Mar 19, 2013 at 06:08:15PM +0100, Takashi Iwai wrote:
>> At Tue, 19 Mar 2013 17:12:14 +0100,
>> Torstein Hegge wrote:
>>>
>>> UAC2_EXTENSION_UNIT_V2 differs from UAC1_EXTENSION_UNIT, but can be handled in
>>> the same way when parsing the unit. Otherwise parse_audio_unit() fails when it
>>> sees an extension unit on a UAC2 device.
>>>
>>> UAC2_EXTENSION_UNIT_V2 is outside the range allocated by UAC1.
>>>
>>> Signed-off-by: Torstein Hegge <hegge@resisty.net>
>>
>> Does this bug hit on any existing device with 3.9-rc kernel?
>> If it does, it'd be nice to have a bit actual description.
> 
> The bug was reported on a Focusrite Scarlett 8i6 USB with a 3.5.0 kernel [1],
> where the unhandled subtype causes the card creation to fail:
> 
> [ 1144.857836] usb 2-1.2: new high-speed USB device number 4 using ehci_hcd
> [ 1144.951520] usb 2-1.2: New USB device found, idVendor=1235, idProduct=8002
> [ 1144.951531] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 1144.951538] usb 2-1.2: Product: Scarlett 8i6 USB 
> [ 1144.951543] usb 2-1.2: Manufacturer: Focusrite
> [ 1144.951547] usb 2-1.2: SerialNumber: 00006B8B
> [ 1144.956590] usbaudio: unit 51: unexpected type 0x09
> [ 1144.956640] snd-usb-audio: probe of 2-1.2:1.0 failed with error -5
> 
> Still waiting for him to report back with a 3.9-rc kernel.
> 
> [1] http://thread.gmane.org/gmane.linux.alsa.user/37289/focus=37294

The 3.9-rc kernel doesn't change anything about that, but two error path
cleanup patches in the mixer code seem to have at least some effect.
I'll post them in a while.

I frankly think we should merge both this and my patches to 3.9, and
maybe even mark the for @stable.


Daniel
