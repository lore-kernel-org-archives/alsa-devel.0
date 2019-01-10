From: ard <ard@kwaak.net>
Subject: Re: Pioneer DDJ-SX3 usb audio quirks
Date: Thu, 10 Jan 2019 16:07:47 +0100
Message-ID: <20190110150747.GS12622@kwaak.net>
References: <20190109155848.GQ12622@kwaak.net> <s5h5zuwyb9w.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kwaak.net (gw-fsck-sorbs.kwaak.net [82.197.218.155])
 by alsa0.perex.cz (Postfix) with ESMTP id DE69F2674BA
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 16:08:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h5zuwyb9w.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Jan 10, 2019 at 12:58:35PM +0100, Takashi Iwai wrote:
> On Wed, 09 Jan 2019 16:58:48 +0100,
> ard wrote:
> > 
> > Since this is a copy paste of the roland octo capture with fixes for the numbers I know, I am still wondering about this:
> > Should I use .ifnum=1 for every snd_usb_audio_quirk?
> > And in eacht audioformat should I use .iface = 0? 
> 
> Just put the value you take for .ifnum to .iface field.  They must be
> same.

Thanks! I figured as much. You know it's now on to the next
problem :-).

[   14.576174] usb 3-1.1.3: 0:1 : invalid sync pipe. is_playback 1, ep 86, bSynchAddress 00

The timing is done by implicit feedback. As in: there is no other
traffic than 5MB/s of 10 channels iso in and 12 channels iso out
for playing a single channel.

I assume I have to add a case to: set_sync_ep_implicit_fb_quirk
in sound/usb/pcm.c, as I fail to see a construction that automagically
connects a 12 channel output to a 10 channel input with the
USB_ENDPOINT_USAGE_IMPLICIT_FB flag added to the ep_attr field.

I will try just the flag added to the iso in endpoint for now.

Regards,
Ard van Breemen

-- 
.signature not found
