From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] fm801: move to pcim_* and devm_* functions
Date: Wed, 7 Jan 2015 15:40:26 +0200
Message-ID: <CAHp75Ve6+Gb5Cm+Xz04kaL6_jScQDAbH02QTA5Abb2mOyi5s1w@mail.gmail.com>
References: <1420587617-28521-1-git-send-email-andy.shevchenko@gmail.com>
 <s5h8uhfdq0g.wl-tiwai@suse.de>
 <CAHp75Veya0h7E_dDCXEsUvqFp+=LCk_4PDbV_REUMc1_Ro9W=Q@mail.gmail.com>
 <s5hoaqaygnt.wl-tiwai@suse.de>
 <CAHp75Ve-KigYCKP0oCz6E6ZmgTKf7+0Y5UtJjPUWyZoK5JBjMQ@mail.gmail.com>
 <s5hlhleybt7.wl-tiwai@suse.de>
 <CAHp75VdR3nU6K7abpzfUPZrG45R9j0YRYeUV8E4YBAq7Qi3sgA@mail.gmail.com>
 <s5hh9w2yawo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f43.google.com (mail-yh0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E27E2604BB
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 14:40:27 +0100 (CET)
Received: by mail-yh0-f43.google.com with SMTP id z6so623926yhz.2
 for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2015 05:40:26 -0800 (PST)
In-Reply-To: <s5hh9w2yawo.wl-tiwai@suse.de>
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

On Wed, Jan 7, 2015 at 3:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 7 Jan 2015 15:27:35 +0200,
> Andy Shevchenko wrote:

Regarding to the original patch, is it okay now to apply?

[]

> I meant the release of regions allocated in
> pcim_iomap_regions_request_all().  The function requests all regions,
> not only for MMIO ones:
>
> int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
>                                    const char *name)
> {
>         int request_mask = ((1 << 6) - 1) & ~mask;
>         int rc;
>
>         rc = pci_request_selected_regions(pdev, request_mask, name);
>         if (rc)
>                 return rc;
>
>         rc = pcim_iomap_regions(pdev, mask, name);
>         if (rc)
>                 pci_release_selected_regions(pdev, request_mask);
>         return rc;
> }
>
> The regions allocated via pcim_iomap_regions() are released via
> pcim_iomap_release() properly.  But what about the former one, the
> regions allocated via pci_request_selected_regions()...?

Looks like it requires it's own release function to be implemented, yes.
Good catch.

-- 
With Best Regards,
Andy Shevchenko
