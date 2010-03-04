From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH]Support MCP89 and GT21x hdmi audio
Date: Thu, 4 Mar 2010 18:46:59 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C16B1AD554@HKMAIL01.nvidia.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.112.145])
	by alsa0.perex.cz (Postfix) with ESMTP id E7CD3103810
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 11:47:15 +0100 (CET)
In-Reply-To: <s5hzl2ol8qu.wl%tiwai@suse.de>
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
Cc: 'akpm' <akpm@linux-foundation.org>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Pavel Hofman' <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi
I think we can submit my patch first, then generate another patch
to add EXPORT_SYMBOL() in hda_eld.c, and change Makefile to remove
hda_eld.o from snd-hda-codec-xxhdmi-objs.

Thanks
Wei.
nvpublic

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Thursday, March 04, 2010 5:47 PM
To: Wei Ni
Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'
Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio

At Thu, 4 Mar 2010 10:21:39 +0800,
Wei Ni wrote:
> 
> Hi, Takashi
> 1. Yes, it can works for all Nvidia controller.

OK.

> 2. The hda_eld.o doesn't export any symbols.
> I tried to put hda_eld.o to snd-had-codec-*, and remove had_eldo.o
> from snd-had-codec-intelhdmi-objs, but it will build error. It need
> to modify hda_eld.c to export symbols, it will add many changes.

Yes, this is unavoidable.  Please add EXPORT_SYMBOL()'s
appropriately.

We can reduce them again once after all HDMI stuff is merged into
one.


thanks,

Takashi
