From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: X-Fi Xtreme Audio PCIe
Date: Wed, 06 Oct 2010 16:08:41 +0200
Message-ID: <4CAC82E9.3080903@ladisch.de>
References: <SNT136-w16AB2F31C1D85EDBEED317CF6E0@phx.gbl>,
	<4CAC185C.4050804@ladisch.de>
	<SNT136-w21705876B4A70E6B690448CF6E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 04605103981
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 16:08:00 +0200 (CEST)
In-Reply-To: <SNT136-w21705876B4A70E6B690448CF6E0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaime Torres <jaimeurieltorres@hotmail.com>
Cc: ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

Jaime Torres wrote:
> snd_ctxfi

The snd-ctxfi driver was written by Creative some time ago; there
haven't been any updates since then.  This driver does not handle the
Xtreme Audio PCIe.

> snd_hda_codec_ca0110  snd_hda_intel

This chip is also said to be compatible with the HD Audio specification.
Therefore, the snd-hda-intel driver tries to handle it.

> ALSA sound/pci/hda/hda_intel.c:660: spurious response 0x0:0x0, last cmd=0x000000
> ALSA sound/pci/hda/hda_intel.c:711: azx_get_response timeout, switching to polling mode: last cmd=0x107ba000
> ALSA sound/pci/hda/hda_intel.c:750: hda_intel: azx_get_response timeout, switching to single_cmd mode: last cmd=0x107ba000
> ALSA sound/pci/hda/hda_intel.c:786: get_response timeout: IRS=0x0

However, the chip doesn't seem to be initialized correctly, or isn't
really HDA compatible.  Nobody except Creative knows.


Regards,
Clemens
