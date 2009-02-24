From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: clarification on mmap
Date: Tue, 24 Feb 2009 13:15:53 +0530
Message-ID: <98769532B4BB14429434178695419EAE31FD0613@bgsmsx501.gar.corp.intel.com>
References: <200902211659.48009.linux@dadeos.co.uk>
	<s5hvdr1337t.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE31FCFB62@bgsmsx501.gar.corp.intel.com>
	<s5hy6vxxjfy.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE31FCFCB0@bgsmsx501.gar.corp.intel.com>
	<s5h63j1lzvo.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE31FD01A2@bgsmsx501.gar.corp.intel.com>
	<s5hwsbgqqmk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 5524D1037F0
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 08:46:04 +0100 (CET)
In-Reply-To: <s5hwsbgqqmk.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The exact issue I am facing is - if the data is mmaped or not I would want to know that the dma_area is filled and how much is filled so that I can setup the dma to transfer it to the hardware.

Can you suggest a way to do this?

Will the following help?

1. If the data is not mmaped, can I setup the transfer in .ack call to transfer the data copied from dma_area to hardware?
2. If the data is mmaped; In the .pointer call back, I get the exact hw pointer of how much has been played out. Here can I setup another transfer from dma_area?
3. How can I know internally in the driver if the application has mmaped the buffer or using the method of sending user buffers?

Thanks,
Harsha


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Tuesday, February 24, 2009 12:16 PM
To: Harsha, Priya
Cc: alsa-devel@alsa-project.org
Subject: Re: clarification on mmap

At Tue, 24 Feb 2009 10:24:19 +0530,
Harsha, Priya wrote:
> 
> Thanks Takashi. Then what would be the best way to know when the
> mmaped buffer has been filled. So that I can take action to send it
> to the hardware? 

In the current ALSA design, mmap transfer is completely asynchronous.
The driver doesn't take care when app_ptr is updated.  It's checked
only when the hw_ptr is updated in snd_pcm_period_elapsed().  So, in
general, what the card driver needs is to provide the ISR calling
snd_pcm_period_elapsed() appropriately and, if possible, to provide
the accurate PCM pointer callback to give the updated hw_ptr.

In mmap mode, other any transfer to the hardware is supposed to be
done by the hardware (DMA) more or less automatically.  If you need to
do it by yourself, mmap isn't always the right answer.

> Should I use the runtime->control->appl_ptr or
> runtime->status->appl_ptr to get the position the app has filled? 

appl_ptr exists only in runtime->control.


HTH,

Takashi

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Tuesday, February 24, 2009 12:55 AM
> To: Harsha, Priya
> Cc: alsa-devel@alsa-project.org
> Subject: Re: clarification on mmap
> 
> At Mon, 23 Feb 2009 22:21:24 +0530,
> Harsha, Priya wrote:
> > 
> > Thank you. Can I use .ack callback to know that the mmaped buffer
> > has been filled by the user?
> 
> Not really.  It's just for explicit read/write modes.
> 
> > How would I know how much the user has
> > written into the buffer that time?
> 
> You can check appl_ptr at any time.  This corresponds to the position
> the app has filled.
> 
> 
> Takashi
> 
> > Would I need to have the pointers
> > calculated and tracked myself or is there a field in the structures
> > that I can read and find out? 
> > 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de] 
> > Sent: Monday, February 23, 2009 8:57 PM
> > To: Harsha, Priya
> > Cc: alsa-devel@alsa-project.org
> > Subject: Re: clarification on mmap
> > 
> > At Mon, 23 Feb 2009 18:59:11 +0530,
> > Harsha, Priya wrote:
> > > 
> > > Hi,
> > > 
> > > I have a question on mmap. If I give my .info to be _MMAP and
> > > _MMAP_VALID. Will ALSA framework internally take care of mmap-ing
> > > the kernel buffer that has been pre-allocated in the .probe call? Do
> > > I need to do anything special to mmap a kernel buffer into user
> > > space? Just accessing the runtime->dma_area would allow me to access
> > > user data right? 
> > 
> > Yes.  The buffers allocated via preallocator are supposed to be
> > mmappable, so you can simply pass _MMAP* flag there.
> > 
> > 
> > Takashi
> > 
> 
