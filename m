From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [Alsa-user]  hdmi sound rerouted?
Date: Mon, 7 Oct 2013 13:36:24 +0000
Message-ID: <A3397C8B8B789E45844E7EC5DEAD89D02E80F013@satlexdag05.amd.com>
References: <20130927185045.47660@gmx.com>	<52475908.1060705@googlemail.com>
 <A3397C8B8B789E45844E7EC5DEAD89D02E80B231@satlexdag05.amd.com>
 <s5h4n927jn0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 50A792650FA
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 15:36:32 +0200 (CEST)
In-Reply-To: <s5h4n927jn0.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, Dagg Stompler <daggs@gmx.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <cladisch@googlemail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, September 30, 2013 5:18 AM
> To: Deucher, Alexander
> Cc: Clemens Ladisch; Dagg Stompler; alsa-user@lists.sourceforge.net; alsa-
> devel@alsa-project.org
> Subject: Re: [alsa-devel] [Alsa-user] hdmi sound rerouted?
> 
> At Mon, 30 Sep 2013 02:23:22 +0000,
> Deucher, Alexander wrote:
> >
> > > -----Original Message-----
> > > From: Clemens Ladisch [mailto:cladisch@googlemail.com]
> > > Sent: Saturday, September 28, 2013 6:33 PM
> > > To: Dagg Stompler
> > > Cc: alsa-user@lists.sourceforge.net; Deucher, Alexander; alsa-
> devel@alsa-
> > > project.org
> > > Subject: Re: [Alsa-user] [alsa-devel] hdmi sound rerouted?
> > >
> > > Dagg Stompler wrote:
> > > >> daggs@gmx.com wrote:
> > > >>> card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
> > > >>> card 1: Generic [HD-Audio Generic], device 3: HDMI 0 [HDMI 0]
> > > >>> card 2: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
> > > >>
> > > >> The second one is called "Generic" because your kernel does not (yet)
> > > >> know the hardware.
> > > >>
> > > >>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar
> > > HDMI Audio [Radeon HD 5400/6300 Series]
> > > >>> 06:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] RV635
> > > HDMI Audio [Radeon HD 3600 Series]
> > > >>
> > > >> These are the HDMI outputs of *two* graphics cards. The first one's
> > > >> model is so new that the driver doesn't know it.
> > > >
> > > > the 3600 doesn't have hdmi socket so I think it is irrelevant for my issue.
> > >
> > > The RV635 chip does support HDMI outputs (even if none are actually
> > > connected), so the corresponding PCI device shows up here.
> > >
> > > >>> If you update the kernel, you will get two devices named "HDA ATI
> > > HDMI".
> > > >
> > > > upgrade to where?
> > >
> > > Oops.  Even the latest driver lacks the PCI IDs of many HDMI HDA devices
> > > (aa50/aa58/aa60/aa68/aa80/aa88/aa90/aa98:
> > > Cypress/Juniper/Redwood/Cedar/
> > > Cayman+Antilles/Barts/Turks/Caicos).
> > >
> > > Alex, are these devices that require disabling snooping?
> >
> > Sorry what does snooping mean in this context?
> 
> Most of HD-audio controller have a snoop control, but the recent AMD
> HDMI audio controller don't have the feature, thus the driver must use
> the non-cached pages.  At least, PCI ID 1002:aaa0, aaa8 and aab0 are
> known to require such.
> 
> Now the question is whether all new chips above (aa50,...) require the
> same workaround, too.  Could you check this or forward the inquiry to
> someone in AMD?

According to our internal teams, disabling snooping is only required on the audio parts included in Evergreen and Northern Islands GPUs.  Older chips like R7xx (aa48) and newer chips like Southern Islands (aaa0) are able to use snooping.  I'm not real familiar with the audio portions of the GPUs so if you need further clarification, let me know.

Alex

> 
> FWIW, such a chip needs to set AZX_DRIVER_ATIHDMI_NS bits in
> driver_data of pci entries in sound/pci/hda/hda_intel.c.
> 
> 
> thanks,
> 
> Takashi
