From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: ALSA/usb-audio: snd_usb_autoresume possible recursive locking
 detected
Date: Wed, 26 Aug 2015 19:16:43 +0600
Message-ID: <20150826131643.GA1607@localhost>
References: <20150825133256.GA1804@localhost>
 <s5hbndvmqb9.wl-tiwai@suse.de>
 <s5h4mjnmnfh.wl-tiwai@suse.de>
 <20150825171523.GA1413@localhost>
 <s5ha8tfnrkz.wl-tiwai@suse.de>
 <CANCZXo7jFP_j9ymE9xO5kmRoZ0PWUMaj9LimY9ohEokTTnprGA@mail.gmail.com>
 <s5h6143nofh.wl-tiwai@suse.de>
 <20150826074002.GA1600@localhost>
 <s5hlhcymoo6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Description: mesg
Content-Disposition: inline
In-Reply-To: <s5hlhcymoo6.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08-26-15, Takashi Iwai wrote:
> 
> Ah, sorry, this was the missing refcount increment at resume.
> Below is the revised patch.  In the final form, it'll be split to a
> few parts, but now it's all folded for ease of testing.
> 

Hello Takashi,

sorry for delay, just made a test with the last patch and finally
dmesg is clear.

Thank you.
