From: "John Crowley" <jcrowley@screenpc.com>
Subject: How does usbaudio synchronize on playback?
Date: Thu, 13 Nov 2008 11:10:56 -0500
Message-ID: <0MKp8S-1L0ep82OqE-0006QQ@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 96CF12414D
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 17:13:43 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

All:

How is the playback data in usbaudio.c synchronized between the application
writing data to the runtime->dma_area buffer and the prepare_playback_urb
function copying this into URBs? 
 
To start, a series of no-data URBs are sent out. The completion routine for
each URB then calls prepare_playback_urb, which copies more data into the
URB, and this URB is then passed to the USB system to be sent to the device.

 
prepare_playback_urb copies data from the runtime->dma_area to the
urb->transfer_buffer area. It maintains subs->hwptr_done to record what data
has been copied, and wraps at runtime->buffer_size since this is a circular
buffer. It also recognizes when runtime->period_size has been exceeded and
invokes snd_pcm_period_elapsed to tell the application that more playback
data is needed. 
 
What I don't understand is how does prepare_playback_urb ensure that more
playback data has actually been written into the buffer? 
 
In our case, we are streaming audio over a WAN, so we increased the number
of URBs to 16, with up to 32 packets per URB, to get a lot of data going
on-the-fly over a high latency link.  
 
The problem is that we are getting erroneous data, and suspect that it is
caused by this synchronization issue. When the initial no-data URBs are
completed, the prepare_playback_urb logic copies a lot of data from the
buffer into new URBs -- but apparently no playback data has been written
into the buffer yet by the application. If we insert logic to arbitrarily
slow down the prepare_playback_urb logic, then the data appears to be
correct. But this is a (very) weak solution. 
 
We also tried to save the runtime->control->appl_ptr value in order to
calculate how much new application data is available, but discovered that
appl_ptr is evidently not being updated (always zero). (running 2.6.23
kernel). 
 
Are we missing a key concept? Is there a way to reliably determine how much
data the application has actually written into the buffer? 
 
Thanks for your help ...


John Crowley
ScreenPC, Inc.
101 Merritt 7, 5th Fl
Norwalk, CT  06851
Office:  203.842.0460 ext 602
Cell:      203.856.2396

This message and any accompanying attachments contains information from
ScreenPC,Inc. that is confidential and/or privileged. The information is
intended to be for the use of the individual or entity named above. If you
are not the intended recipient, be aware that any disclosure, copying,
distribution or use of the contents of this information is prohibited. If
you have received this email in error, please notify the sender immediately
by reply email and destroy all copies of the original email.



No virus found in this outgoing message.
Checked by AVG. 
Version: 7.5.549 / Virus Database: 270.9.2 - Release Date: 11/11/2008 12:00
AM
