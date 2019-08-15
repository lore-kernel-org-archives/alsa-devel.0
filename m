From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] ALSA: hda - Add a new match function for only undef
 configurations
Date: Thu, 15 Aug 2019 10:42:46 +0200
Message-ID: <20190815084246.GA3512@kroah.com>
References: <20190815083001.3793-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190815083001.3793-1-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 15, 2019 at 04:30:00PM +0800, Hui Wang wrote:
> With the existing pintbl, we already have many entries in it. it is
> better to figure out a new match to reduce the size of the pintbl.
> 
> For example, there are over 10 entries in the pintbl for:
> 0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
> 
> If we define a new tbl like below, and with the new adding match
> function, we can remove those over 10 entries:
> SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
> 	{0x19, 0x40000000},
> 	{0x1a, 0x40000000},),
> 
> Here we put 0x19 and 0x1a in the tbl just because these two pins are
> undefined on Dell laptops with the codec alc255, and these two pins
> will be overwritten by ALC255_FIXUP_DELL1_MIC_NO_PRESENCE.
> 
> In summary: the new match will check vendor id and codec id first,
> then check the pin_cfg defined in the tbl, only all pin_cfgs in the
> tbl are undef and the corresponding pin_cfgs on the laptop are undef
> too, this match returns true.
> 
> This new match function has lower priority than existing match
> functions, so the existing tbls still work as before after applying this
> patch.
> 
> My plan is to change the existing tbl to undef tbl for MIC_NO_PRESENCE
> fixups gradually.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  sound/pci/hda/hda_auto_parser.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
