From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi driver -> kernel
Date: Tue, 18 Dec 2007 13:16:38 +1300
Message-ID: <47671166.2050405@audioscience.com>
References: <200709051300.35503.linux@audioscience.com>
	<s5hzm01tn8w.wl%tiwai@suse.de> <47141823.4000307@audioscience.com>
	<s5hbqaqrppa.wl%tiwai@suse.de> <47397615.4000201@audioscience.com>
	<475886C3.9070301@audioscience.com> <s5hve71dzqx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id A7938245A2
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 01:16:56 +0100 (CET)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JT700KOCY3S6G00@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 18 Dec 2007 13:16:42 +1300 (NZDT)
In-reply-to: <s5hve71dzqx.wl%tiwai@suse.de>
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
Cc: Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

thanks for looking over our code. Some of your comments are addressed below.

Takashi Iwai wrote:

> One thing I noticed is the function definition/declaration style.
> 
> void HPI_GetErrorText(
> 	u16 wError,
> 	char *pszErrorText
> )
> {
> 	...
> 
> It's uncommon.  Normally, it's in a single line, and the line starting
> with the opening brace.  See CodingStyle as reference.

Yes. We find that this style leaves room for doxygen comments on each
function parameter and keep within 80 columns. In hpifunc.c this is not
evident because we are stripping all the comments out for now.

> (Besides, the hungarian style is hated by many people.  Let's avoid it
>  as much as possible.)

> Also, in general, the removal of all HpiOs_*() is a good goal.
> The kernel guys really hate wrappers like that.  Let's use native
> API.

I think all the thin wrappers have been removed. What remain are

1) Spinlock wrappers, the comments in the code tell why
/* The reason for all this evilness is that ALSA calls some of a drivers
 * operators in atomic context, and some not.  But all our functions channel
 * through the HPI_Message conduit, so we can't handle the different context
 * per function
 */

2) LockedMem wrappers.  These provide tracking for the DMA areas
Need to keep track of all the info about the mem area so it can be freed
again at the end

E.g. pci_free_consistent(pMemArea->pdev, pMemArea->size,
			pMemArea->cpu_addr, pMemArea->dma_addr);



> Other things I noticed:
> 
> - The ioctl of hpi chrdev is dangerous: it may cause Oops when
>   accessing to a non-existing adapter.  

A bug to fix

> I feel the chrdev should be
>   rather bound to the existing ALSA device, e.g. using hwdep instead.
>   Then the whole story about registration would become more straight.

...yes I'm interested.
Currently HPI userspace lib just works whether ALSA or plain HPI driver
is loaded. How would this work with your scenario?

> - Replace semaphore with mutex as much as possible.

OK, will look at it. BTW is there an easy way to find out at what kernel
version a given API was added/removed/changed?
> 
> - Don't use bitfields for data communication.  It's higly unportable.
>   Use explit bit shift and mask instead.

Only hpi_version structure I think?  Not used by kernel driver at all,
we can make it disappear.


> - The way of clean up like hpimod_cleanup() is uncommon.
>   (Above all, passing just a digit is a bad style...)

OK.
So replace this with checks like this?:

if (asihpi_class) class_device_destroy(asihpi_class...
if (chrdev_registered) unregister_chrdev(...
if (asihpi_pci_driver) pci_unregister_driver(...

> 
> - Remove HPI_UNUSED().  We don't check unused parameters.

OK.

> - Global variables should have some unique prefix.  The kernel code is
>   monolithc C, so they are really global and has no name space.

Did you have a list?
There are a few function names that don't start with HPI.

> - HPI_GetErrorText() is dangerous.  It may overflow easily.
>   Don't use strcat() unless you are really sure.  Use variants with
>   the size limit.

Valid point.

We can get rid of it from kernel driver entirely by using just error
number instead.

regards

Eliot Blennerhassett
AudioScience Inc.
