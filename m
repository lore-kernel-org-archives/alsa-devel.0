From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] ALSA: hda/ca0132: Limit values for chip
 addresses to 32-bit
Date: Fri, 31 Mar 2017 17:52:58 -0700
Message-ID: <20170401005258.GC2130@google.com>
References: <20170316205223.16926-1-mka@chromium.org>
 <s5hy3w0wavc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f52.google.com (mail-pg0-f52.google.com [74.125.83.52])
 by alsa0.perex.cz (Postfix) with ESMTP id DB6102668F6
 for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2017 02:53:01 +0200 (CEST)
Received: by mail-pg0-f52.google.com with SMTP id 21so85191809pgg.1
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 17:53:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hy3w0wavc.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Grant Grundler <grundler@chromium.org>, linux-kernel@vger.kernel.org, Greg Hackmann <ghackmann@google.com>, Michael Davidson <md@google.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sven Hahne <hahne@zeitkunst.eu>
List-Id: alsa-devel@alsa-project.org

Sorry for the delayed reply,

El Mon, Mar 20, 2017 at 10:33:43AM +0100 Takashi Iwai ha dit:

> On Thu, 16 Mar 2017 21:52:23 +0100,
> Matthias Kaehlcke wrote:
> > 
> > With the previous unsigned long value clang generates warnings like
> > this:
> > 
> > sound/pci/hda/patch_ca0132.c:860:37: error: implicit conversion from
> >   'unsigned long' to 'u32' (aka 'unsigned int') changes value from
> >   18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
> >         spec->curr_chip_addx = (res < 0) ? ~0UL : chip_addx;
> >                              ~             ^~~~
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Thanks for the patch.  The changes look mostly OK, but...
> 
> > ---
> >  sound/pci/hda/patch_ca0132.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> > index 11b9b2f17a2e..7175e2b46fc4 100644
> > --- a/sound/pci/hda/patch_ca0132.c
> > +++ b/sound/pci/hda/patch_ca0132.c
> > @@ -857,7 +857,7 @@ static int chipio_write_address(struct hda_codec *codec,
> >  				  chip_addx >> 16);
> >  	}
> >  
> > -	spec->curr_chip_addx = (res < 0) ? ~0UL : chip_addx;
> > +	spec->curr_chip_addx = (res < 0) ? (u32)~0U : chip_addx;
> 
> ... I guess the cast to u32 is superfluous here?  That is, just
> replace UL to U should work, I suppose.  (Ditto for all other places.)

You are right, the cast is not needed. I'll send an updated version.

Cheers

Matthias
