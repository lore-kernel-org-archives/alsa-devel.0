From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCMCIA In Kernel Or In ALSA Driver?
Date: Wed, 25 Jun 2003 20:51:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306252050580.1838-100000@pnote.perex-int.cz>
References: <01d401c33b42$139c5a40$1c02a8c0@win98>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA25038
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2003 20:52:31 +0200
In-Reply-To: <01d401c33b42$139c5a40$1c02a8c0@win98>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Len Moskowitz <vze24hrw@verizon.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 25 Jun 2003, Len Moskowitz wrote:

> Hi to all,
> 
> We're setting up a PDAudio-CF card.
> 
> I note that the  configuration asks whether we want kernel or ALSA PCMCIA
> support: does it
> matter to the PDAudio-CF card driver?

Yes, both should be enabled (kernel + ALSA PCMCIA support).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
