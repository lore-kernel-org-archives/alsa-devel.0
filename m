From: "John Crowley" <jcrowley@screenpc.com>
Subject: Re: How does usbaudio synchronize on playback?
Date: Fri, 14 Nov 2008 19:38:11 -0500
Message-ID: <0MKpCa-1L19De1pXw-0007uk@mrelay.perfora.net>
References: <491D37E9.9070901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.195])
	by alsa0.perex.cz (Postfix) with ESMTP id C93CE103817
	for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2008 01:41:06 +0100 (CET)
In-Reply-To: <491D37E9.9070901@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Clemens Ladisch' <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the quick reply ... I've been digging through the code some more.
Sorry for the excessive length of this response ....

Some additional questions, comments, and tests below, and this is a
completely new area for me, so sorry if I'm being especially obtuse.

Let me know if anyone can point to some documentation or books that I can
reference to get into this area.

Regards to all,

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

 

> -----Original Message-----
> From: Clemens Ladisch [mailto:clemens@ladisch.de] 
> Sent: Friday, November 14, 2008 3:34 AM
> To: John Crowley
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] How does usbaudio synchronize on playback?
> 
> John Crowley wrote:
> > [...]
> > What I don't understand is how does prepare_playback_urb 
> ensure that 
> > more playback data has actually been written into the buffer?
> 
> It doesn't; the ALSA framework does.
> 
> When the driver calls snd_pcm_period_elapsed(), ALSA calls 
> the .pointer callback and checks if an underrun has happened. 
>  Underrun detection works this way because most sound card 
> hardware reads the data out of the buffer asynchronously.
> 
QUESTION:  Understand about the .pointer callback, and from printk traces
that seems to be functioning as expected.

I dug several layers into snd_pcm_period_elapsed(), and it eventually does a
wake_up() on what I presume is the producer application so that it can write
some more data into the ring buffer.

But I still have the original problem -- How to tell when the data has
actually been written into the buffer?

As I understand it, the wake_up() will just allow the application process to
become runnable again, but (especially on a heavily loaded machine) it may
not be scheduled immediately.  Also, even if it is executed synchronously,
how can you tell how much data has been written into the buffer?  Will it
always write 1 period, 1 milli-second, ???

I put a printk on runtime->control->appl_ptr (which I had hoped to use to
address this problem), but using speaker-test this never changed from zero.
Using Firefox to stream music, it was being updated.  Any idea of what's
happening here?  If appl_ptr was updated consistently, this whole issue
would be resolved.

Also, how does the application itself know where to write the next series of
frames if appl_ptr was not updated?  I'm assuming that the application is
maintaining it's own counters.

> > The problem is that we are getting erroneous data, and 
> suspect that it 
> > is caused by this synchronization issue. When the initial 
> no-data URBs 
> > are completed, the prepare_playback_urb logic copies a lot of data 
> > from the buffer into new URBs
> 
> The initial URBs should complete one by one, not all at once 
> (this is the only reason why the driver uses these initial 
> URBs in the first place).
> 

CONTEXT:  This is probably the nub of the problem -- we have a very
different situation.

If there is a real USB device attached, the data will stream out of the
buffer at a relatively slow rate -- some number of frames per milli-second
in the case of regular speakers.  In this situation, waking up the producer
to write some more data to the buffer has plenty of time to occur.

But we are using USBIP to stream audio data to a device across a network.
The actual device has some buffer space, so we put in a deep queueing
mechanism to have a lot of URBs on-the-fly, and let the terminal device
buffer a few seconds worth (and feed that out to the physical USB device at
the appropriate rate).  This smooths over any network glitches, and when the
buffer at the client is filled, it simply does not Confirm receipt of the
last URB until it has space available to start accepting more data.

TEST CASES:

a) if we setup just 2 URBs, everything works OK.

b) if we setup 16 URBs (32 packets per URB), the sound is totally garbled.
Clearly some packets are out of order, some are duplicated.

c) if we setup 16 URBs (32 packets per) and put an msleep(6) at the end of
the prepare_playback_urb then the sound is perfect again.

THEORY:

With just 2 URBs in use, there is enough natural delay in the round-trip
time that the application has plenty of time to write new data into the
buffer before prepare_playback_urb tries to use it.  In (b) the
synchronization problem shows up -- we're pulling data from areas of the
buffer which have not yet been re-populated by the producing application.

Case (c) just introduces an artificial delay into the process.  A setting of
6 ms is totally arbitrary -- other values may also work.

But this is not really a clean or reliable solution.  I'd much, much rather
have a solid synchronization between the producer and consumer to handle
this.  (A reliably updated appl_ptr would be perfect.)

> > but apparently no playback data has been written into the 
> buffer yet 
> > by the application.
> 
> This should result in an underrun and the stream being 
> stopped, except if your application has disabled this behaviour.
> 

COMMENT:  I suspect that to ALSA, all looks OK.  But with a lot of URBs in
process, several can complete in rapid sequence and in this case we have
tried to pull data from the buffer before it was actually written by the
application.

>From ALSAs point of view, the ultimate USB device requires data at a certain
rate (say a 48K sampling rate).  But all of our intermediary machinery is
actually trying to pull data in a bursty fashion, and sometimes at a much
faster rate.

> 
> Best regards,
> Clemens
> 
> -- 
> > This message and any accompanying attachments contains information 
> > from ScreenPC,Inc. that is confidential and/or privileged. The 
> > information is intended to be for the use of the individual 
> or entity 
> > named above. If you are not the intended recipient, be 
> aware that any 
> > disclosure, copying, distribution or use of the contents of this 
> > information is prohibited. If you have received this email 
> in error, 
> > please notify the sender immediately by reply email and 
> destroy all copies of the original email.
> 
> *** DISCLAIMER ***
> This e-mail contains public information intended for any 
> subscriber of this mailing list and for anybody else who 
> bothers to read it; it will be copied, disclosed and 
> distributed to the public.  If you think you are not the 
> intended recipient, please commit suicide immediately.
> These terms apply also to any e-mails quoted in, referenced 
> from, or answering this e-mail, and supersede any disclaimers 
> in those e-mails.
> Additionally, disclaimers in those e-mails will incur legal 
> processing fees of $42 per line; you have agreed to this by 
> reading this disclaimer.
> *** END OF DISCLAIMER ***
> 
> No virus found in this incoming message.
> Checked by AVG. 
> Version: 7.5.549 / Virus Database: 270.9.2/1785 - Release 
> Date: 11/13/2008 9:12 AM
>  
> 

No virus found in this outgoing message.
Checked by AVG. 
Version: 7.5.549 / Virus Database: 270.9.3 - Release Date: 11/13/2008 12:00
AM
