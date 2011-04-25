From: Greg KH <gregkh@suse.de>
Subject: Re: 2.6.38.4 broke my audio
Date: Sun, 24 Apr 2011 17:01:26 -0700
Message-ID: <20110425000126.GA18681@suse.de>
References: <20110424113037.11af0b04@omega.digital-domain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 770561037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Apr 2011 02:03:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110424113037.11af0b04@omega.digital-domain.net>
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
Cc: stable@kernel.org, alsa-devel@alsa-project.org, Emmanuel Benisty <benisty.e@gmail.com>, Andrew Clayton <andrew@digital-domain.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 24, 2011 at 11:30:37AM +0100, Andrew Clayton wrote:
> Hi guys.
> 
> Just upgraded to .4 from .3 and found my audio was _really_ quiet. All
> the mixers looked sane.
> 
> A quick check of the changelog and a revert of:
> 
> commit 58541cc27531727f7120683a7cb123ee3ada4bd4
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Mon Mar 28 12:05:31 2011 +0200
> 
>     ALSA: hda - Fix pin-config of Gigabyte mobo
>     
>     commit c6b358748e19ce7e230b0926ac42696bc485a562 upstream.
>     
>     Use pin-fix instead of the static quirk for Gigabyte mobos 1458:a002.
>     
>     Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=677256
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> made it normal again.

Takashi, do you have a fix for this, or should I revert this from the
.38 stable tree?  It looks like we now have 2 reports of this problem.

thanks,

greg k-h
