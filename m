From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device
 open (OHCI)
Date: Mon, 27 Sep 2004 11:10:25 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8659.195.245.190.94.1096279825.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
References: 
In-Reply-To: 
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Karsten,

Just noticed a bulb crackling :)

> erm, found the bug:
> snd-usb-usx2y currently really can't cope with ohci,
> as ohci_hcd doesn't use specified urb->start_frame values.
> Only ISO_ASAP is supported and start_frame is 16Bit where
> uhci start_frame is 10Bit.
> ... <bulb crackling> ...

Is this good news? Is there anything I can do to help?

I'm all yours!
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org








-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
