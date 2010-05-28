From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] ALSA,
 hda: Add support for Lenovo ThinkPad Edge 13 in conexant codec
Date: Fri, 28 May 2010 01:35:27 -0500
Message-ID: <1275028527.2945.1812.camel@laptop>
References: <20100527160656.GE10254@alberich.amd.com>
	<s5htyps3788.wl%tiwai@suse.de>
	<20100528062102.GF10254@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 08EBF103ADC
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 08:35:33 +0200 (CEST)
In-Reply-To: <20100528062102.GF10254@alberich.amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Borislav Petkov <borislav.petkov@amd.com>
List-Id: alsa-devel@alsa-project.org

Are you sure? The pci id I have is for 0x21b4 based on information from
that bug. What you point out is 0x21b3. Please retest with 

SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066_IDEAPAD)

Can you post lspci -vvnn output for your Thinkpad Edge?

Here is the patch I sent:
Signed-off-by: Jerone Young <jerone.young@canonical.com>

diff --git a/pci/hda/patch_conexant.c b/pci/hda/patch_conexant.c
index e863649..f4a2bd6 100644
--- a/pci/hda/patch_conexant.c
+++ b/pci/hda/patch_conexant.c
@@ -2975,6 +2975,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
        SND_PCI_QUIRK(0x1179, 0xff50, "Toshiba Satellite P500-PSPGSC-01800T", CXT5066_OLPC_XO_1_5),
        SND_PCI_QUIRK(0x1179, 0xffe0, "Toshiba Satellite Pro T130-15F", CXT5066_OLPC_XO_1_5),
        SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD),
+       SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066_IDEAPAD),
        SND_PCI_QUIRK(0x17aa, 0x3a0d, "ideapad", CXT5066_IDEAPAD),
        SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),



				Thanks,
					Jerone

On Fri, 2010-05-28 at 08:21 +0200, Andreas Herrmann wrote:
> On Fri, May 28, 2010 at 07:50:31AM +0200, Takashi Iwai wrote:
> > At Thu, 27 May 2010 18:06:56 +0200,
> > Andreas Herrmann wrote:
> > > 
> > > From: Andreas Herrmann <andreas.herrmann3@amd.com>
> > > 
> > > On a Thinkpad Edge 13 I had the problem that speakers played sound
> > > although headphones were plugged.
> > > 
> > > Using "model=olpc-xo-1_5" solved this problem. So it seems sensible to
> > > add this quirk. (Using other models, like ideabad did not fix it.)
> > > 
> > > Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> > > ---
> > >  sound/pci/hda/patch_conexant.c |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > 
> > > I don't know whether adding this quirk is the right/complete solution
> > > to support sound on Thinkpad Edge. But at least it solves this
> > > annoying problem.
> > 
> > Well, Jerone Young already sent a quirk patch but he took
> > model=ideapd.  Could you guys check which one is really better?
> 
> Hi Jerone,
> 
> there are two different models of Thinkpad Edge (one with Intel CPU/chipset,
> one with AMD CPU/chipset). I tested on the AMD version but from
> 
> https://bugs.launchpad.net/ubuntu/+source/linux-backports-modules-2.6.32/+bug/549289
> 
> it seems that using  model=olpc-xo-1_5 works for both versions of that Thinkpad.
> 
> I also tried ideapad -- because looking at the quirk table
> for cxt5066 there is this entry
> 
>         SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD),
> 
> and adding 
> 
>         SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge", CXT5066_IDEAPAD),
> 
> seems to be conclusive.
> 
> But as I said that did not solve the problem of speakers still playing
> audio if headphones are plugged in for me. Have you explicitely tested
> this?  Maybe I have to retest with some newer code from the alsa tree?
> 
> 
> Regards,
> Andreas
