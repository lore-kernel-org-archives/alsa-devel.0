From: Monty Montgomery <xiphmont@gmail.com>
Subject: UHCI dropped audio samples / DMA starvation fix
Date: Wed, 4 Apr 2012 15:43:10 -0400
Message-ID: <CACrD=+9OSMrf1ghQdvQ7xP7gpXUvT2jkgNh+1qQ5Efem7wsZaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1220424746
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Apr 2012 21:43:12 +0200 (CEST)
Received: by laap9 with SMTP id p9so724639laa.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Apr 2012 12:43:10 -0700 (PDT)
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
Cc: tiwai@suse.de, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hello Clemens and Takashi (and list),

I've been living with USB audio dropping partial frames on UHCI
controllers for quite a few years.  I've finally found the cause
(DMA starvation) and have a lightweight fix.

problem summary:

Playback (but not capture) on UHCI controllers randomly loses samples;
they are skipped completely during playback.  This happens anywhere
from a few times a second to once an hour or so. These are not ALSA
underruns; the UHCI host controller itself is reporting hard DMA
starvation errors. ALSA ignores these error and continues as if nothing
happened, and the UHCI linux driver does not log this error anywhere.

UHCI overlaps sending on the USB bus with DMAing the data from memory.
It does not have all the data it needs to transmit a complete packet
before it begins doing so.  If the data it needs is in a dirty cache
line on a CPU, the flush triggers after DMA is already started; the
UHCI host controller has to wait for the flush before accessing it,
and if the flush happens too late, UHCI aborts the packet.  This is
happening regularly on all the UHCI controllers I've tried thusfar.

My guess is that this issue never attracted much attention because a)
every one knows isoch transfers are 'unreliable' and b) other transfer
types automatically retry so they eventually succeed without any
obvious sign that something went wrong (and they're usually smaller
than one cacheline and so unaffected anyway).

Fix:

The fix for usbaudio is dead easy.  Call:

clflush_cache_range(urb->transfer_buffer, urb->transfer_buffer_length);

as the last step of prepare_playback_urb() and
prepare_nodata_playback_urb().  This completely corrects the DMA
starvation behavior on my machines here.

Note that the clflush_cache_range() has nothing to do with
maintaining coherency.  The call is only to force the flush ahead of
time to avoid the fatal latency spikes from on-demand flushes
when DMA is already running.

The drawback to this fix is that it's in one high level driver (ALSA
USB audio) instead of inside UHCI where it really belongs.
Unfortunately, the URB abstraction gives us no reliable way to do it
in the HCD, because other drivers don't necessarily pass a valid
CPU-side buffer address when using URB_NO_TRANSFER_DMA_MAP.

Should I whip up some patches for usb audio for 2.6.x and 3.3.x and
leave it at that, or should we discuss a bit more 'why isn't the
kernel doing this for us?'

Monty
