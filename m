From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: usx2y jack driver
Date: Sat, 25 Sep 2004 15:33:29 -0400
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <1096140809.3504.13.camel@krustophenia.net>
References: <200409222228.38243.annabellesgarden@yahoo.de>
	 <32827.192.168.1.5.1096065064.squirrel@192.168.1.5>
	 <1096078552.1407.1.camel@krustophenia.net>
	 <200409251555.59384.annabellesgarden@yahoo.de>
	 <32983.192.168.1.5.1096125029.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <32983.192.168.1.5.1096125029.squirrel@192.168.1.5>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, jackit-devel <jackit-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-09-25 at 11:10, Rui Nuno Capela wrote:
> Karsten Wiese wrote:

Thanks for the excellent description of the driver.

> If someone have an idea on how to dig on this, like some debugging
> silver-bullet :) I'll very thankful. Ingo Molnar has taught me the serial
> console method but, guess what, this is a post-modern laptop: it doesn't
> have a serial port. Duh?
> 

This is a really good point, I asked about it on LKML.  I don't think an
equivalent procedure is currently available for a legacy-free machine.  
This will become a serious problem as such machines become more common,
as the serial console is the only way to diagnose some bugs.

For now you have to get by with magic sysrq.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
