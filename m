From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsa-lib: snd_pcm_delay and friends do not
 account for a write being currently in progress
Date: Thu, 03 Jun 2010 08:40:35 +0200
Message-ID: <4C074E63.90508@ladisch.de>
References: <1275514176.8032.42.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id E495910380A
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 08:40:39 +0200 (CEST)
In-Reply-To: <1275514176.8032.42.camel@satellite>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Lindgren wrote:
> In a multi-threaded application it is possible for snd_pcm_delay or an
> equivalent function to be called by one thread while another is sitting
> in snd_pcm_writei.

Alsa-lib is not thread safe.  In theory, you are not even allowed to
call snd_pcm_delay while another function on the same PCM device has not
yet returned.

> Suppose a sound card has a maximum buffer size of 0.1 second.  Then,
> suppose an application writes 0.5 second of audio.  snd_pcm_writei will
> immediately write the first 0.1 second to the ring buffer, then will
> incrementally write the remaining 0.4 second as the buffer drains.

It will write a chunk whenever it is woken up by the driver, which is
usually at period boundaries.

> During this time, snd_pcm_delay will return a constant fill level of 0.1
> second.

Depending on how big the granularity of the hardware's readable DMA
pointer is, but on most hardware, it will fluctuate between a full
buffer and one period less than that, not counting further fluctuations
due to scheduling delays.

> On the application side, the playback time counter will be calculated
> during this time as 0.5 seconds written to ALSA

This is wrong; as long as the write call has not returned, you do not
know how much has been written (and when an error occurs, writing can
stop before).

To keep track of the actual amount of data written, use non-blocking
mode and in a loop, write as much as possible in one call, then update
your write counter, then wait for some more free space in the buffer
with poll().


Regards,
Clemens
