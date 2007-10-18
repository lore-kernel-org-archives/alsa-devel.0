From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: hda-intel: no soundcard with current linus' git
	tree
Date: Thu, 18 Oct 2007 16:21:59 +0200
Message-ID: <200710181621.59795.maximlevitsky@gmail.com>
References: <471538C2.80806@m3y3r.de>
	<200710180353.08638.maximlevitsky@gmail.com>
	<s5hd4vdc6d4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 32FD32479C
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 16:22:31 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so439624ugf
	for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2007 07:22:30 -0700 (PDT)
In-Reply-To: <s5hd4vdc6d4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Meyer <thomas@m3y3r.de>
List-Id: alsa-devel@alsa-project.org

On Thursday 18 October 2007 07:57:27 Takashi Iwai wrote:
> At Thu, 18 Oct 2007 03:53:08 +0200,
> Maxim Levitsky wrote:
> > 
> > From 0824b077b75c19253b45c5a455775c331acd54ee Mon Sep 17 00:00:00 2001
> > From: Maxim Levitsky <maximlevitsky@gmail.com>
> > Date: Thu, 18 Oct 2007 03:35:37 +0200
> > Subject: [PATCH] [HDA] [STAC] Since there is now a master volume control,
> > don't call the headphone output "Master", it isn't strictly correct anyway
> 
> I thought stac925x has no volume knob, so "Master" should be still
> applied for this codec?

Yes, you are right, but stac925x has only one DAC, and thus if it is connected to any line-out, it will be
'Front', but if it is connected to 'headphones' only, then why not to call it 'Headphone'

STAC  9200 has no volumeknob too, but it is handled seperartly
STAC  9202 and 9250 has no volumeknob too, but as I said they have just one DAC again


Best regards,
	Maxim Levitsky
> 
> 
> Takashi
> 
> > 
> > Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> > ---
> >  pci/hda/patch_sigmatel.c |    7 +------
> >  1 files changed, 1 insertions(+), 6 deletions(-)
> > 
> > diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
> > index 6dffa54..7f157a6 100644
> > --- a/pci/hda/patch_sigmatel.c
> > +++ b/pci/hda/patch_sigmatel.c
> > @@ -1907,12 +1907,7 @@ static int stac92xx_auto_create_hp_ctls(struct hda_codec *codec,
> >  			return err;
> >  	}
> >  	if (spec->multiout.hp_nid) {
> > -		const char *pfx;
> > -		if (old_num_dacs == spec->multiout.num_dacs)
> > -			pfx = "Master";
> > -		else
> > -			pfx = "Headphone";
> > -		err = create_controls(spec, pfx, spec->multiout.hp_nid, 3);
> > +		err = create_controls(spec, "Headphone", spec->multiout.hp_nid, 3);
> >  		if (err < 0)
> >  			return err;
> >  	}
> > -- 
> > 1.5.3.4
> > 
> 
