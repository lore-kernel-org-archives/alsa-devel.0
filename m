From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Why gameport port address as control?
Date: Tue, 17 Jun 2003 16:24:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306171622060.3847-100000@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0306160909230.27784-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0306160909230.27784-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Jun 2003, Clemens Ladisch wrote:

> Both the ymfpci and ens1370 drivers use the control API to enable and
> select the address of the gameport. Using module parameters would have
> been somewhat easier.
> 
> I don't really understand why this has been done. Is there any
> situation where the ability to change the gameport parameters at
> runtime is actually useful?

It is possible to change the code. My idea was to use control API, 
because we can create a list of available addresses. It is more
user friendly than module option, but the final result is same.

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
