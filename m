From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/9] sound: Add sanity checks for
	invalid EPs
Date: Wed, 11 Oct 2017 15:03:29 +0200
Message-ID: <20171011130329.GI27734@kroah.com>
References: <20171011103646.11879-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id A1998266CA1
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 15:03:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171011103646.11879-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrey Konovalov <andreyknvl@google.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 12:36:37PM +0200, Takashi Iwai wrote:
> Hi,
> 
> this is a revised patch set to cover the codes that may submit URBs
> containing invalid EPs without validation, which result in the kernel
> warning from the USB core.  The first patch adds a new helper for
> simplifying the EP check, and the rest applies it at needed places.
> 
> The original issues were spotted by syzkaller, and I put a few others
> for covering more similar cases.
> 
> The only updated code in v2 is about the first patch to add
> usb_urb_ep_type_check() helper (in addition to tested-by tag from
> Andrey).  Typos were fixed and it's called also from usb_submit_urb()
> as Greg suggested, too.
> 
> USB devs: does this look OK now?
> 
> If yes, and if I get acks, I can take the patches to sound tree.  Or I
> don't mind if you take all to usb tree, too.  Or maybe better, I'll
> prepare an immutable branch based on 4.4.14-rc (rc4 for now) in case
> you want to pull into both trees.  Let me know your wish.

Whole series looks good to me, feel free to take them in your tree if
that's the easiest:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

No need for a branch, merges in this area should be rare...

thanks,

greg k-h
