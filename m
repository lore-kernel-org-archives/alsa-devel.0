From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] ALSA: hda - change the pintbl to undef tbl for Dell
 with alc289
Date: Thu, 15 Aug 2019 10:42:58 +0200
Message-ID: <20190815084258.GB3512@kroah.com>
References: <20190815083001.3793-1-hui.wang@canonical.com>
 <20190815083001.3793-2-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190815083001.3793-2-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 15, 2019 at 04:30:01PM +0800, Hui Wang wrote:
> We have another Dell laptop which needs the DELL4_MIC_NO_PRESENCE,
> and this laptop has different pincfg definitions from existing
> ones in the pintbl, rather adding a new entry, let us change
> the exiting tbl to undef tbl. It will cover all Dell laptops
> with alc289 codec and the pins of 0x19 and 0x1b are undef by default.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
