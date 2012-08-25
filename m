From: Bruno Wolff III <bruno@wolff.to>
Subject: Re: Logitech USB headset not working in 3.6-rc3
Date: Sat, 25 Aug 2012 06:54:23 -0500
Message-ID: <20120825115423.GA14327@wolff.to>
References: <20120824190808.GC20043@zod.bos.redhat.com>
 <5038007E.5060505@gmail.com>
 <20120825111749.GA17048@wolff.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120825111749.GA17048@wolff.to>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Josh Boyer <jwboyer@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 25, 2012 at 06:17:49 -0500,
   Bruno Wolff III <bruno@wolff.to> wrote:
>
>I see this behavior on three different computers. Rebooting into an old
>enough kernel gets things working again. The older kernels also have 
>older initramfs images. I could rebuild those to see if there is some 
>issue there instead of the kernels themselves?

I tested one of the older kernels (where the headset still worked) with a 
rebuilt initramfs and the headset still worked. So it likely isn't an issue 
with something in the initramfs images.
