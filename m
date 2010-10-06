From: Jaime Torres <jaimeurieltorres@hotmail.com>
Subject: Re: X-Fi Xtreme Audio PCIe
Date: Wed, 6 Oct 2010 08:59:32 -0500
Message-ID: <SNT136-w21705876B4A70E6B690448CF6E0@phx.gbl>
References: <SNT136-w16AB2F31C1D85EDBEED317CF6E0@phx.gbl>,
	<4CAC185C.4050804@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from snt0-omc3-s41.snt0.hotmail.com (snt0-omc3-s41.snt0.hotmail.com
	[65.54.51.78]) by alsa0.perex.cz (Postfix) with ESMTP id C232F10396F
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 15:59:38 +0200 (CEST)
In-Reply-To: <4CAC185C.4050804@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



Modules

snd_ctxfi snd_hda_codec_ca0110  snd_hda_intel
lspci
PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG PCI to PCIe Bridge



I belive problem is related with PCIe interface.
ALSA sound/pci/hda/hda_intel.c:786: get_response timeout: IRS=0x0
ALSA sound/pci/hda/hda_codec.c:4385: autoconfig: line_outs=4 (0xb/0xd/0xc/0xe/0x0)
ALSA sound/pci/hda/hda_codec.c:4389:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:4393:    hp_outs=1 (0xf/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:4394:    mono: mono_out=0x0
ALSA sound/pci/hda/hda_codec.c:4397:    dig-out=0x12/0x0
ALSA sound/pci/hda/hda_codec.c:4405:    inputs: mic=0x11, fmic=0x0, line=0x10, fline=0x0, cd=0x0, aux=0x0
ALSA sound/pci/hda/hda_codec.c:4407:    dig-in=0x13
ALSA sound/pci/hda/hda_intel.c:660: spurious response 0x0:0x0, last cmd=0x000000
ALSA sound/pci/hda/hda_intel.c:711: azx_get_response timeout, switching to polling mode: last cmd=0x107ba000
ALSA sound/pci/hda/hda_intel.c:750: hda_intel: azx_get_response timeout, switching to single_cmd mode: last cmd=0x107ba000
ALSA sound/pci/hda/hda_intel.c:786: get_response timeout: IRS=0x0
ALSA sound/pci/hda/hda_intel.c:786: get_response timeout: IRS=0x0
ALSA sound/pci/hda/hda_intel.c:786: get_response timeout: IRS=0x0




> Date: Wed, 6 Oct 2010 08:34:04 +0200
> From: clemens@ladisch.de
> To: jaimeurieltorres@hotmail.com
> CC: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] X-Fi Xtreme Audio PCIe
> 
> Jaime Torres wrote:
> > We have 500 linux servers with X-Fi Xtreme Audio PCIe. The audio card
> > is properly detected by kernel.
> 
> Which driver?
> 
> 
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
 		 	   		  
