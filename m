From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: Replace snd_malloc_pages() and
 snd_free_pages() with standard helpers
Date: Sun, 25 Nov 2018 00:12:33 +0900
Message-ID: <20181124151233.GC11722@sakamocchi.jp>
References: <20181123203526.5008-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 93DEA267865
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2018 16:12:39 +0100 (CET)
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so4555878pfm.4
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2018 07:12:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181123203526.5008-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Nov 23, 2018 at 09:35:26PM +0100, Takashi Iwai wrote:
> snd_malloc_pages() and snd_free_pages() are merely thin wrappers of
> the standard page allocator / free functions.  Even the arguments are
> compatible with some standard helpers, so there is little merit of
> keeping these wrappers.
> 
> This patch replaces the all existing callers of snd_malloc_pages() and
> snd_free_pages() with the direct calls of the standard helper
> functions.  In this version, we use a recently introduced one,
> alloc_pages_exact(), which suits better than the old
> snd_malloc_pages() implementation.  Then we can avoid the waste of
> pages by alignment to power-of-two.
> 
> Also, the __GFP_COMP flag that has been always added in the old
> implementation is dropped for most of callers now.  The only one that
> may still need it is the PCM buffer allocation which can be quite
> large.  The rest are single page allocations, so no sense to keep that
> flag.
> 
> With these conversions, snd_malloc_pages() and snd_free_pages() are
> dropped altogether from the whole tree.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/sound/memalloc.h        |  4 ---
>  sound/core/memalloc.c           | 54 +++------------------------------
>  sound/core/pcm.c                | 14 ++++-----
>  sound/usb/usx2y/usX2Yhwdep.c    |  3 +-
>  sound/usb/usx2y/usbusx2y.c      |  3 +-
>  sound/usb/usx2y/usx2yhwdeppcm.c |  6 ++--
>  6 files changed, 19 insertions(+), 65 deletions(-)

Usage of 'alloc_pages_exact()' function and '__GFP_COMP' flag looks good
to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Messages from 01.org can be ignored because the past patches can
suppress it.


Regards

Takashi Sakamoto
