From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH v5] [resend] radio-sf16fmr2: convert to
	generic TEA575x interface
Date: Wed, 1 Jun 2011 21:56:59 +0200
Message-ID: <201106012157.03928.linux@rainbow-software.org>
References: <201105231417.17450.linux@rainbow-software.org>
	<s5hvcwx29co.wl%tiwai@suse.de> <4DE65E9B.7060509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EB931038D3
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 21:57:17 +0200 (CEST)
In-Reply-To: <4DE65E9B.7060509@redhat.com>
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
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>, alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 01 June 2011 17:45:31 Mauro Carvalho Chehab wrote:
> Em 26-05-2011 04:45, Takashi Iwai escreveu:
> > At Wed, 25 May 2011 21:21:30 -0300,
> >
> > Mauro Carvalho Chehab wrote:
> >> Em 23-05-2011 09:17, Ondrej Zary escreveu:
> >>> Convert radio-sf16fmr2 to use generic TEA575x implementation. Most of
> >>> the driver code goes away as SF16-FMR2 is basically just a TEA5757
> >>> tuner connected to ISA bus.
> >>> The card can optionally be equipped with PT2254A volume control
> >>> (equivalent of TC9154AP) - the volume setting is completely reworked
> >>> (with balance control added) and tested.
> >>
> >> Ondrej,
> >>
> >> As your first series went via alsa tree, and we are close to the end of
> >> the merge window, and assuming that Takashi didn't apply those patches
> >> on his tree, as you're re-sending it, I think that the better is to wait
> >> for the end of the merge window, in order to allow us to sync our
> >> development tree with 2.6.40-rc1, and then review and apply it on the
> >> top of it.
> >
> > Yeah, I didn't pick it up as the patches are rather V4L-side changes
> > (although tea575x.c is in sound sub-directory).
> > And I agree with Mauro - let's merge it after rc1, so that we stand on
> > the same ground.  This sort of cross-tree change is better done at the
> > fixed point than in flux like during merge window.
>
> Hmm.. I tried to apply it after -rc1. It didn't apply:
>
> Applying patch
> patches/lmml_808552_v5_resend_radio_sf16fmr2_convert_to_generic_tea575x_int
>erface.patch patching file sound/pci/Kconfig
> patching file drivers/media/radio/radio-sf16fmr2.c
> Hunk #1 FAILED at 1.
> 1 out of 2 hunks FAILED -- rejects in file
> drivers/media/radio/radio-sf16fmr2.c Patch
> patches/lmml_808552_v5_resend_radio_sf16fmr2_convert_to_generic_tea575x_int
>erface.patch does not apply (enforce with -f)
>
> Is there any missing patches, or is it just due to some other changes from
> the alsa tree?

It fails because of a stupid typo comment fix:
-/* !!! not tested, in my card this does't work !!! */
+/* !!! not tested, in my card this doesn't work !!! */


-- 
Ondrej Zary
