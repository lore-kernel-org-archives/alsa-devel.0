From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH v4 5/6] core: add support for
 compress_offload
Date: Wed, 14 Dec 2011 10:47:28 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CC365D76@bgsmsx502.gar.corp.intel.com>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<1323766980-9350-6-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCB50B01@bgsmsx502.gar.corp.intel.com>
	<1323785540.1641.73.camel@vkoul-udesk3>
	<3CA6C6D9F70D314CA34352990B57DA1507CCB50B87@bgsmsx502.gar.corp.intel.com>
	<1323798820.1641.320.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 26C89243BA
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 06:18:26 +0100 (CET)
In-Reply-To: <1323798820.1641.320.camel@vkoul-udesk3>
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
To: "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-12-13 at 23:23 +0530, Vinod Koul wrote:
> On Tue, 2011-12-13 at 21:32 +0530, Nallasellan, Singaravelan wrote:
> > > 
> > > Again, please read the related discussion on the list.
> > > 
> > > Compressed devices will not have direction associated with them . They can be
> > > opened in any mode depending on the mode the DSP supports.
> > > So /dev/snd/comprC0D0 can be either playback or capture device.
> > > So a device can be ONLY opened with O_WRONLY or O_RDONLY.
> > > 
> > Nice, Does it look like a hack hack hack...
> Care to elaborate your comment?
> 
There are few assumptions here:
1) User of this device should use only these flags
2) No one should change the file permission after the device is created.
3) No one should write to the ring buffer of the capture stream in the
case of mmap. If someone wants to process the data in the ring buffer
itself for capture stream, it is not allowed. The user should copy the
the content from ring buffer and then process it. May be a good idea. 

4) Looks like minor numbers are used to differentiate the multiple
streams. 
Anyhow, the device should be opened for capture and playback
separately. 
What do we loose if we use separate devices for capture and playback for
each stream supported?

5) Anyway, I think the device entries should be created for each stream
with a different minor number.

Why dont we use the similar device node creation method as PCM? 
May be I missed some relevant discussion here. Can you guys provide more
info?

> 
> > > > O_NONBLOCK is not tested here for non-blocking support.
> > > Why should it be?
> > > 1) Any blocking and non blocking should be handled in user space
> > > 2) Nevertheless, that is not supported, HINT: read the documentation
> > > 
> > This is not as per the write system call definition as I understand.
> > Look like we redefine the
> > system call here. Support it in the standard way.
> Your argument is entirely bogus.
> What do you mean by that? Noone is changing a system call.
> For this device O_NONBLOCK is not supported thats it!!! How does that
> violate a system call. 
> There are many other flags which some device support and some don't.
> 
> > > Yes currently write is allowed only once and we *normally* expect a START call. I am
> > > not sure why someone would need to call "smaller"
> > > writes multiple times. Remember this is compressed offload where we ideally want
> > > larger chunks of data otherwise there is no point in using this.
> > The code allows this to happen.  Is there any minimum size documented anywhere? 
> That's whatever dsp supports
> 
> 
> > > > What is the maximum number of fragments supported?
> > > Whatever dsp supports
> > IMHO, compress-core needs to query it from each driver and allocate memory 
> > only if the supported fragments is greater than requested fragments. 
> user library should query the format and other details supported at
> open. So these checks are anyway made their.
> Nevertheless, this can be taken care in core as well but there is always
> a question of how much check to do.
IMO, the kernel code should ensure the sanity of the values. It should
not assume that you will always do the right thing.  
> 
> > > 
> > > > Can we check the fragments to that limit?
> > > Yes, can be checked here as well but I prefer to do these checks in userspace library
> > Think the driver needs to check and return error if it is not within the maximum
> > supported by the driver.
> Where is driver coming here?

As you mentioned, the driver will specify the max number of fragments
supported. Now the compress-core has to query the value and validate the
user values. Other option is to send the parameters to the driver and
let it verify the sanity of the values and return the right error code
the core. 
> 
> -- 
> ~Vinod
> 
