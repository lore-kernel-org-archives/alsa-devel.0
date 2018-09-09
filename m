From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 03/11] compat_ioctl: remove translation for
	sound ioctls
Date: Sun, 9 Sep 2018 05:16:50 +0100
Message-ID: <20180909041632.GE19965@ZenIV.linux.org.uk>
References: <20180908142837.2819693-1-arnd@arndb.de>
 <20180908142837.2819693-3-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DE5B2675CD
 for <alsa-devel@alsa-project.org>; Sun,  9 Sep 2018 06:18:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180908142837.2819693-3-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 08, 2018 at 04:28:09PM +0200, Arnd Bergmann wrote:
> The SNDCTL_* and SOUND_* commands are the old OSS user interface.
> 
> I checked all the sound ioctl commands listed in fs/compat_ioctl.c
> to see if we still need the translation handlers. Here is what I
> found:
> 
> - sound/oss/ is (almost) gone from the kernel, this is what actually
>   needed all the translations
> - The ALSA emulation for OSS correctly handles all compat_ioctl
>   commands already.
> - sound/oss/dmasound/ is the last holdout of the original OSS code,
>   this is only used on arch/m68k, which has no 64-bit mode and
>   hence needs no compat handlers
> - arch/um/drivers/hostaudio_kern.c may run in 64-bit mode with
>   32-bit x86 user space underneath it. This rare corner case is
>   the only one that still needs the compat handlers.
> 
> By adding a simple redirect of .compat_ioctl to .unlocked_ioctl in the
> UML driver, we can remove all the COMPATIBLE_IOCTL() annotations without
> a change in functionality. For completeness, I'm adding the same thing
> to the dmasound file, knowing that it makes no difference.

> diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
> index 7f9dbdbc4eb7..0278a642a622 100644
> --- a/arch/um/drivers/hostaudio_kern.c
> +++ b/arch/um/drivers/hostaudio_kern.c
> @@ -298,6 +298,7 @@ static const struct file_operations hostaudio_fops = {
>  	.write          = hostaudio_write,
>  	.poll           = hostaudio_poll,
>  	.unlocked_ioctl	= hostaudio_ioctl,
> +	.compat_ioctl	= hostaudio_ioctl,

Umm...  OK, seeing that it's not going to be used on s390...  It's still
not quite right, though, and I'm afraid that places where we have the
same ->unlocked_ioctl and ->compat_ioctl need an audit - there probably
had been other folks who'd stepped into the same.
