From: Bruno Wolff III <bruno@wolff.to>
Subject: Re: Logitech USB headset not working in 3.6-rc3
Date: Sat, 25 Aug 2012 06:17:49 -0500
Message-ID: <20120825111749.GA17048@wolff.to>
References: <20120824190808.GC20043@zod.bos.redhat.com>
 <5038007E.5060505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5038007E.5060505@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Josh Boyer <jwboyer@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 25, 2012 at 00:30:22 +0200,
   Daniel Mack <zonque@gmail.com> wrote:
>
>So what does "isn't working anymore" refer to precisely? Are there any
>more dmesg entries generated once the stream is started?

When I try to play music, the progress bar for the song doesn't advance and 
there is no audbile sound. I am able to use sound preferences to change 
the configuration for the device. (The headset has a few different output 
modes and the like.)

I saved dmesg output in a file, tried to start a song, saved dmesg output 
to another file. diff reported the two files as identical. So trying to 
play music doesn't seem to trigger dmesg output.

I see this behavior on three different computers. Rebooting into an old
enough kernel gets things working again. The older kernels also have 
older initramfs images. I could rebuild those to see if there is some 
issue there instead of the kernels themselves?
