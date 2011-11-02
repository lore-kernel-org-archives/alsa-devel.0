From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/5] ALSA: snd-usb: implement new endpoint
 streaming model
Date: Wed, 02 Nov 2011 16:49:50 +0100
Message-ID: <4EB1669E.5040701@ladisch.de>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-2-git-send-email-zonque@gmail.com>
	<4EB11ADD.2090701@ladisch.de> <4EB153BF.2090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E9C3710392F
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 16:48:54 +0100 (CET)
In-Reply-To: <4EB153BF.2090204@gmail.com>
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
> On 11/02/2011 11:26 AM, Clemens Ladisch wrote:
>> Daniel Mack wrote:
>>> +void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
>>>  		...
>>> +		snd_printk(KERN_ERR "Unable to find an urb for playback (nurbs %d)\n",
>>> +			   ep->nurbs);
>>
>> AFAICS the driver tries for all URBS to be queued at all times.
> 
> Hmm, no, not for the "implicit feedback" case. In this mode, we don't
> queue any output urbs on startup but wait for the capture urbs to arrive
> and then queue from there. So this should be ok, right?

Example with queue length = 2:

1) startup:
   driver queues both capture URBs
2) 1st capture URB completes:
   driver queues 1st playback URB and requeues 1st capture URB
3) 2nd capture URB completes:
   driver queues 2nd playback URB and requeues 2nd capture URB
   (all URBs are now queued)
4) 1st capture URB completes:
   1st playback URB is still busy
   (The playback URB might have been scheduled for a later frame, and
   even for the same frame, there is no guarantee that the completions
   for different endpoints happen in the same order as the queueing.)


Regards,
Clemens
