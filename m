From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 2.6.34-rc5 v2] HID: Prodikeys PC-MIDI HID
 Driver
Date: Mon, 10 May 2010 09:48:56 +0200
Message-ID: <4BE7BA68.90600@ladisch.de>
References: <4BE6E4FA.10204@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <4BE6E4FA.10204@yahoo.co.uk>
Sender: linux-input-owner@vger.kernel.org
To: Don Prince <dhprince.devel@yahoo.co.uk>
Cc: linux-input@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Don Prince wrote:
> A specialised HID driver for the Creative Prodikeys PC-MIDI USB Keyboard.
> 
> The Prodikeys PC-MIDI is a multifunction keyboard comprising a qwerty 
> 
> keyboard, multimedia keys and a touch sensitive musical keyboard.
> 
> The specialised HID driver adds full support for the musical keyboard 
> 
> and extra multimedia keys which are not currently handled by the default 
> 
> HID driver.
> 
> The specialised HID driver interfaces with Alsa, and presents the midi 
> 
> keyboard as a Rawmidi device. Sustain duration, octave shifting and the  
> 
> midi output channel can be read/written form userspace  via sysfs.

Thunderbird does this when it reads the text from another mail (neither
directly typed in nor pasted from the clipboard); the patch itself is
fine.

> Signed-off-by: Don Prince <dhprince-devel@yahoo.co.uk>

for the ALSA parts:
Acked-by: Clemens Ladisch <clemens@ladisch.de>


You should send the patch not only to the list but also to the HID
maintainer.


Regards,
Clemens
