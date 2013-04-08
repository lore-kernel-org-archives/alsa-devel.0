From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [RFC] revoke(2) and generic handling of things like
 remove_proc_entry()
Date: Mon, 08 Apr 2013 15:16:10 +0200
Message-ID: <5162C31A.6040209@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Al Viro wrote:
> BTW, snd_card_disconnect() doesn't do anything to existing mappings; smells
> like a bug, and there we do have ones with non-trivial ->mmap().  Could
> ALSA folks comment?

I don't know of any hotplug sound driver that maps memory from a device.
All hotplug buses (PCIe, USB, FireWire) involve DMAing from/to main
memory.

When a sound device is unplugged, sample transfers just stop, but the
buffer itself stays as long as the device node is kept opened.  (In the
case of a capture device, that actually makes sense.)


Regards,
Clemens
