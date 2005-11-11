From: Giuliano Pochini <pochini@shiny.it>
Subject: xxx_t replacement (was:ALSA SoC layer)
Date: Fri, 11 Nov 2005 10:00:02 +0100 (CET)
Message-ID: <XFMail.20051111100002.pochini@shiny.it>
References: <s5h8xvw22jl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CD25919C
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2005 10:00:21 +0100 (MET)
In-Reply-To: <s5h8xvw22jl.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 10-Nov-2005 Takashi Iwai wrote:

> I'll merge my big patches to replace xxx_t with struct xxx likely
> in the next week just after releasing ALSA 1.0.10-final.

Please don't change all the xxxchip_t typedef's in the drivers. They
help a lot keeping many lines short.


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
