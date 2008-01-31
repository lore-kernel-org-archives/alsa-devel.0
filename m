From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: 1.0.16rc2 -build issues
Date: Thu, 31 Jan 2008 15:41:56 +0000
Message-ID: <200801311541.56880.gineera@aspect135.co.uk>
References: <Pine.LNX.4.61.0801291553220.11819@tm8103.perex-int.cz>
	<200801302103.45969.gineera@aspect135.co.uk>
	<s5hzlum1ayw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 04C452415F
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 16:22:04 +0100 (CET)
In-Reply-To: <s5hzlum1ayw.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 31 January 2008 11:38, you wrote:
> At Wed, 30 Jan 2008 21:03:45 +0000,
>
> Alan Horstmann wrote:
> > Unfortunately make didn't get much further, having more ??historic
> > kernel?? trouble in memalloc:
> >
> > memalloc.c: In function `snd_mem_proc_open':
> > memalloc.c:611: warning: implicit declaration of function `single_open'
> > memalloc.c: At top level:
> > memalloc.c:715: error: `single_release' undeclared here (not in a
> > function) memalloc.c:715: error: initializer element is not constant
> > memalloc.c:715: error: (near initialization for
> > `snd_mem_proc_fops.release') memalloc.c: In function `snd_mem_init':
> > memalloc.c:731: warning: assignment discards qualifiers from pointer
> > target type
>
> Then the patch below should work.  Give it a try.

Yup, that nailed it!  Make completes OK now, thanks.

I applied the memalloc.patch patch by hand.  If this is to be applied, notice 
that Line 200 #endif text string also presumably needs changing.

Alsa-lib was OK, but the configure was slightly messy in reporting 
'python-config' Command not found  before a more reasonable message and 
disabling python from the build.

If both the patches are to be applied, would you like me to retest the nightly 
build at some stage(which presumably won't need hgcompile)?  If so can you 
give the link again.

Thanks 

Alan

> ---
>
> diff -r e600ecb8fbd7 acore/memalloc.patch
> --- a/acore/memalloc.patch	Wed Jan 30 08:36:00 2008 +0100
> +++ b/acore/memalloc.patch	Thu Jan 31 12:39:11 2008 +0100
> @@ -189,7 +189,7 @@
>
>
>   #ifdef CONFIG_PROC_FS
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
>   /*
>    * proc file interface
>    */
> @@ -205,7 +205,7 @@
>   static int __init snd_mem_init(void)
>   {
>   #ifdef CONFIG_PROC_FS
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
>   	snd_mem_proc = create_proc_entry(SND_MEM_PROC_FILE, 0644, NULL);
>   	if (snd_mem_proc)
>   		snd_mem_proc->proc_fops = &snd_mem_proc_fops;
> @@ -216,7 +216,7 @@
>
>   static void __exit snd_mem_exit(void)
>   {
> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
>   	remove_proc_entry(SND_MEM_PROC_FILE, NULL);
>  +#endif
>   	free_all_reserved_pages();
