From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/5] ALSA: snd-usb: implement new endpoint
 streaming model
Date: Thu, 03 Nov 2011 17:42:32 +0100
Message-ID: <4EB2C478.90609@ladisch.de>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-2-git-send-email-zonque@gmail.com>
	<4EB11ADD.2090701@ladisch.de> <4EB153BF.2090204@gmail.com>
	<4EB1669E.5040701@ladisch.de> <4EB2B186.60405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 68A4C24417
	for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2011 17:41:37 +0100 (CET)
In-Reply-To: <4EB2B186.60405@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On 11/02/2011 04:49 PM, Clemens Ladisch wrote:
> > Example with queue length = 2:
> >
> > 1) startup:
> >     driver queues both capture URBs
> > 2) 1st capture URB completes:
> >     driver queues 1st playback URB and requeues 1st capture URB
> > 3) 2nd capture URB completes:
> >     driver queues 2nd playback URB and requeues 2nd capture URB
> >     (all URBs are now queued)
> > 4) 1st capture URB completes:
> >     1st playback URB is still busy
> >     (The playback URB might have been scheduled for a later frame, and
> >     even for the same frame, there is no guarantee that the completions
> >     for different endpoints happen in the same order as the queueing.)
> 
> I see. However, this really never happened in my tests so far.

This depends on how the HC drivers organize their internal data
structures.  (Most HCs have one global interrupt handler and check the
endpoint queues in the order in which the endpoints are listed in the
device's descriptors, or by number.  However, xHCI allows multiple
interrupts, so completion can arrive in random order, or even
concurrently.)

> What would be a way to fix this? Queue less capture urbs than available
> slots for playback urbs?

There is still that delay in the first playback URB (IIRC EHCI uses
10 ms), and there is no guaranteed upper bound on interrupt latencies.

Generally speaking, a playback URB can be submitted only when both
itself and the corresponding capture URB have been completed.

In my misc/ua101.c driver, I store 'free' playback URBs and capture
frame counts in FIFOs, and submit playback URBs from a tasklet that is
triggered from both completion handlers.


Regards,
Clemens
