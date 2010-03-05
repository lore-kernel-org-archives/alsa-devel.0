From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH]Support MCP89 and GT21x hdmi audio
Date: Fri, 5 Mar 2010 10:41:52 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C16B1AD558@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C068B2BA8B@HKMAIL01.nvidia.com>
	<s5hmxyrp311.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C068B2BA8C@HKMAIL01.nvidia.com>
	<s5heik3ujy0.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16A89A118@HKMAIL01.nvidia.com>
	<6B4D417B830BC44B8026029FD256F7F1C16A89A11A@HKMAIL01.nvidia.com>
	<s5haaupoqew.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16A89A11C@HKMAIL01.nvidia.com>
	<s5htysxm5yo.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD54C@HKMAIL01.nvidia.com>
	<s5hzl2ol8qu.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD554@HKMAIL01.nvidia.com>
	<s5h1vg0qrrr.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD555@HKMAIL01.nvidia.com>
	<s5hwrxspblg.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD556@HKMAIL01.nvidia.com>
	<s5htyswpb18.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD557@HKMAIL01.nvidia.com>
	<s5hvddcnlr6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.112.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 831CD103838
	for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2010 03:42:33 +0100 (CET)
In-Reply-To: <s5hvddcnlr6.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'akpm' <akpm@linux-foundation.org>, 'alsa-devel' <alsa-devel@alsa-project.org>, Wu Fengguang <fengguang.wu@intel.com>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Pavel Hofman' <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

Hi,Takashi
Oh, it's great.
In actually, I have lots of other work to do.

Thanks for your help.
Wei.
nvpublic

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Thursday, March 04, 2010 11:35 PM
To: Wei Ni
Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'; Wu Fengguang
Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio

At Thu, 4 Mar 2010 19:46:17 +0800,
Wei Ni wrote:
> 
> Ok, I will give you the patch tomorrow.

In the end, I fixed it by myself :)
If you have more other fixes, please take topic/hda branch of sound
git tree as basis.
  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git topic/hda

Fengguang, could you rework your patch later for that version?


thanks,

Takashi

> 
> 
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Thursday, March 04, 2010 7:44 PM
> To: Wei Ni
> Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'; Wu Fengguang
> Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio
> 
> At Thu, 4 Mar 2010 19:37:52 +0800,
> Wei Ni wrote:
> > 
> > Do you mean you will check in my patch first, and then I give you the
> > additional patch for adding EXPORT_SYMBOL() in hda_eld.c?
> 
> Yes.  I need the integration tests first.
> Meanwhile, prepare your patch on the top of your current patches.
> Feel free to post it at any time.
> 
> After that, we can merge Fengguang's patch_hdmi.c change on that.
> 
> 
> thanks,
> 
> Takashi
> 
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de] 
> > Sent: Thursday, March 04, 2010 7:31 PM
> > To: Wei Ni
> > Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'
> > Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio
> > 
> > At Thu, 4 Mar 2010 19:09:29 +0800,
> > Wei Ni wrote:
> > > 
> > > Hi, Takashi
> > > I test my patch, it build successful when CONFIG_SND_HDA_*=y.
> > > Could you give me your build error messages?
> > 
> > Sorry, it's CONFIG_SND_HDA*=m.  Then load two modules, so you'll have
> > two identical objects in different modules.
> > 
> > OTOH, if it's no exported symbol, it might coexist.  Hmm.
> > 
> > If you get no errors with it, then it's fine as an intermediate state.
> > Please give the additional patch on them for further fixes.
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > > 
> > > Thanks
> > > Wei.
> > > nvpublic
> > > 
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de] 
> > > Sent: Thursday, March 04, 2010 6:57 PM
> > > To: Wei Ni
> > > Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'
> > > Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio
> > > 
> > > At Thu, 4 Mar 2010 18:46:59 +0800,
> > > Wei Ni wrote:
> > > > 
> > > > Hi, Takashi
> > > > I think we can submit my patch first,
> > > 
> > > But your patch breaks the build when CONFIG_SND_HDA_*=y.
> > > So, it should be fixed in your patch.
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > > > then generate another patch
> > > > to add EXPORT_SYMBOL() in hda_eld.c, and change Makefile to remove
> > > > hda_eld.o from snd-hda-codec-xxhdmi-objs.
> > > > 
> > > > Thanks
> > > > Wei.
> > > > nvpublic
> > > > 
> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai@suse.de] 
> > > > Sent: Thursday, March 04, 2010 5:47 PM
> > > > To: Wei Ni
> > > > Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'
> > > > Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio
> > > > 
> > > > At Thu, 4 Mar 2010 10:21:39 +0800,
> > > > Wei Ni wrote:
> > > > > 
> > > > > Hi, Takashi
> > > > > 1. Yes, it can works for all Nvidia controller.
> > > > 
> > > > OK.
> > > > 
> > > > > 2. The hda_eld.o doesn't export any symbols.
> > > > > I tried to put hda_eld.o to snd-had-codec-*, and remove had_eldo.o
> > > > > from snd-had-codec-intelhdmi-objs, but it will build error. It need
> > > > > to modify hda_eld.c to export symbols, it will add many changes.
> > > > 
> > > > Yes, this is unavoidable.  Please add EXPORT_SYMBOL()'s
> > > > appropriately.
> > > > 
> > > > We can reduce them again once after all HDMI stuff is merged into
> > > > one.
> > > > 
> > > > 
> > > > thanks,
> > > > 
> > > > Takashi
> > > > 
> > > 
> > 
> 
