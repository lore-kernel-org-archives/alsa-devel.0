From: Karim Yaghmour <karim@opersys.com>
Subject: Re: USB Audio problems
Date: Thu, 20 Nov 2003 00:50:03 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBC560B.7040104@opersys.com>
References: <3FBBC461.1020006@opersys.com>
Reply-To: karim@opersys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FBBC461.1020006@opersys.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Well, it seems that I'm going to have to answer my own self ... :)

The following is what I've been able to find using additional tracing
info. Also there's a fix for usbaudio.c.

Basically, it's as I said before: the usbaudio driver uses URBs
without even checking if they're in use or not. Surprisingly, it
does this with one channel, but not the other. Here's what I get
in the traces when I separated the events by channel:
Channel A (the hex data is the value of *subs):
-----------------------------------------------------------------------------------
...
Complete URB           11,242,322,467     0     48     Completing URB 3: 0xC1F6040C
Complete URB           11,242,326,465     0     48     Completing URB 4: 0xC1F6040C
Complete URB           11,242,330,493     0     48     Completing URB 0: 0xC1F6040C
Complete URB           11,242,334,460     0     48     Completing URB 1: 0xC1F6040C
Complete URB           11,242,338,640     126     48     Completing URB 2: 0xC1F6040C
Start URB              11,242,338,945     126     45     Sending URB 0: 0xC1F6040C
Start URB              11,242,339,159     126     45     Sending URB 1: 0xC1F6040C
Start URB              11,242,339,342     126     45     Sending URB 2: 0xC1F6040C
Start URB              11,242,339,495     126     45     Sending URB 3: 0xC1F6040C
Abuse URB              11,242,339,617     126     45     Abusing URB 3: 0xC1F6040C
Deactivate URB         11,242,356,553     126     50     Deactivating URB 0: 0xC1F6040C
Complete URB           11,242,357,621     0     48     Completing URB 3: 0xC1F6040C
Complete URB           11,242,357,834     0     48     Completing URB 4: 0xC1F6040C
Complete URB           11,242,358,323     0     48     Completing URB 0: 0xC1F6040C
Complete URB           11,242,358,933     0     48     Completing URB 1: 0xC1F6040C
URB Active Mask        11,242,359,787     126     57     Active Mask NOT set for 1: 0xC1F6040C
Deactivate URB         11,242,359,970     126     50     Deactivating URB 2: 0xC1F6040C
Complete URB           11,242,360,611     0     48     Completing URB 2: 0xC1F6040C
URB Active Mask        11,242,361,008     126     57     Active Mask NOT set for 3: 0xC1F6040C
URB Active Mask        11,242,361,100     126     57     Active Mask NOT set for 4: 0xC1F6040C
Start URB              11,242,362,442     126     45     Sending URB 0: 0xC1F6040C
Start URB              11,242,362,656     126     45     Sending URB 1: 0xC1F6040C
Start URB              11,242,362,839     126     45     Sending URB 2: 0xC1F6040C
Start URB              11,242,362,991     126     45     Sending URB 3: 0xC1F6040C
Start URB              11,242,363,144     126     45     Sending URB 4: 0xC1F6040C
Complete URB           11,242,376,479     0     48     Completing URB 0: 0xC1F6040C
Complete URB           11,242,380,477     0     48     Completing URB 1: 0xC1F6040C
Complete URB           11,242,384,474     0     48     Completing URB 2: 0xC1F6040C
Complete URB           11,242,388,472     0     48     Completing URB 3: 0xC1F6040C
Complete URB           11,242,392,469     0     48     Completing URB 4: 0xC1F6040C
...
-----------------------------------------------------------------------------------

In this first channel, the deactivation function was never called at any
point prior to sending being initiated. Hence, a URB already in use was
reused without proper deactivation. Looking at the timestamps above, it
is clear that when sending is initiated on URB 3, this one is in its 4ms
playing period and would be interupted.

Channel B:
-----------------------------------------------------------------------------------
...
In the second channel, I had this:
Complete URB           11,242,319,446     0     48     Completing URB 4: 0xC1F6058C
Complete URB           11,242,323,474     0     48     Completing URB 0: 0xC1F6058C
Complete URB           11,242,327,472     0     48     Completing URB 1: 0xC1F6058C
Deactivate URB         11,242,330,767     126     50     Deactivating URB 0: 0xC1F6058C
Complete URB           11,242,331,500     0     48     Completing URB 2: 0xC1F6058C
Complete URB           11,242,331,713     0     48     Completing URB 0: 0xC1F6058C
Deactivate URB         11,242,331,896     126     50     Deactivating URB 1: 0xC1F6058C
Complete URB           11,242,332,537     0     48     Completing URB 1: 0xC1F6058C
URB Active Mask        11,242,332,720     126     57     Active Mask NOT set for 2: 0xC1F6058C
Deactivate URB         11,242,332,812     126     50     Deactivating URB 3: 0xC1F6058C
Complete URB           11,242,333,514     0     48     Completing URB 3: 0xC1F6058C
Deactivate URB         11,242,333,697     126     50     Deactivating URB 4: 0xC1F6058C
Complete URB           11,242,334,643     0     48     Completing URB 4: 0xC1F6058C
Start URB              11,242,335,833     126     45     Sending URB 0: 0xC1F6058C
Start URB              11,242,336,047     126     45     Sending URB 1: 0xC1F6058C
Start URB              11,242,336,199     126     45     Sending URB 2: 0xC1F6058C
Start URB              11,242,336,382     126     45     Sending URB 3: 0xC1F6058C
Start URB              11,242,336,535     126     45     Sending URB 4: 0xC1F6058C
Complete URB           11,242,357,987     0     48     Completing URB 0: 0xC1F6058C
Complete URB           11,242,358,628     0     48     Completing URB 1: 0xC1F6058C
Complete URB           11,242,359,168     0     48     Completing URB 2: 0xC1F6058C
Complete URB           11,242,361,557     126     48     Completing URB 3: 0xC1F6058C
Complete URB           11,242,365,555     0     48     Completing URB 4: 0xC1F6058C
Complete URB           11,242,369,522     0     48     Completing URB 0: 0xC1F6058C
...
-----------------------------------------------------------------------------------

In no occurence did the second channel reuse a URB prior to deactivating it.
Hence, there are no errors that ever occur on this channel.

To make a long story short, the most important issue here is to check whether
the URB is active before using it. If it is, then it must be unlinked first.

Here's my modified start_urbs() function from usbaudio.c:
static int start_urbs(snd_usb_substream_t *subs, snd_pcm_runtime_t *runtime)
{
     unsigned int i;
     int err;

     for (i = 0; i < subs->nurbs; i++) {
         snd_assert(subs->dataurb[i].urb, return -EINVAL);
         /* Deactivate URB prior to using it. K.Y. */
         if (test_and_clear_bit(i, &subs->active_mask)) {
             set_bit(i, &subs->unlink_mask);
             usb_unlink_urb(subs->dataurb[i].urb);
         }
         if (subs->ops.prepare(subs, runtime, subs->dataurb[i].urb) < 0) {
             snd_printk(KERN_ERR "cannot prepare datapipe for urb %d\n", i);
             goto __error;
         }
     }
     if (subs->syncpipe) {
         for (i = 0; i < SYNC_URBS; i++) {
             snd_assert(subs->syncurb[i].urb, return -EINVAL);
             if (subs->ops.prepare_sync(subs, runtime, subs->syncurb[i].urb) < 0) {
                 snd_printk(KERN_ERR "cannot prepare syncpipe for urb %d\n", i);
                 goto __error;
             }
         }
     }

     subs->running = 1;
     for (i = 0; i < subs->nurbs; i++) {
         trace_std_formatted_event(event_start_urb, i,  (unsigned int) subs);
         if ((err = usb_submit_urb(subs->dataurb[i].urb, GFP_KERNEL)) < 0) {
             trace_std_formatted_event(event_abuse_urb, i,  (unsigned int) subs);
             snd_printk(KERN_ERR "cannot submit datapipe for urb %d, err = %d\n", i, err);
             goto __error;
         }
         set_bit(i, &subs->active_mask);
         clear_bit(i, &subs->unlink_mask);
     }
     if (subs->syncpipe) {
         for (i = 0; i < SYNC_URBS; i++) {
             if ((err = usb_submit_urb(subs->syncurb[i].urb, GFP_KERNEL)) < 0) {
                 snd_printk(KERN_ERR "cannot submit syncpipe for urb %d, err = %d\n", i, err);
                 goto __error;
             }
             set_bit(i + 16, &subs->active_mask);
         }
     }
     return 0;

  __error:
     // snd_pcm_stop(subs->pcm_substream, SNDRV_PCM_STATE_XRUN);
     deactivate_urbs(subs, 0);
     return -EPIPE;
}

Using this code, I haven't had any more errors at all.

In order to use this, just remove all the trace_* functions. This new
function just checks if a URB is already in use prior to using it and
clears it. Also, it clears the unlink_mask after the call to
usb_submit_urb in order for it to be "clearable" by deactivate_urbs().
Without this last clear_bit(), URBs can only be cleared once by
deactivate_urbs() and it takes a new init_substream_urbs() to set the
entire mask back to 0. I don't see how this makes any sense.

Feedback is welcome.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
