From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: OSS API redirector
Date: Mon, 22 Mar 2004 10:27:47 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403221027080.1808@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0403181015270.1835@pnote.perex-int.cz>
 <4059AE5E.7030703@superbug.demon.co.uk> <Pine.LNX.4.58.3503191408270.16085@tomservo.workpc.tds.net>
 <405E1CD6.4030404@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA30493
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2004 10:33:11 +0100
In-Reply-To: <405E1CD6.4030404@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: David Lloyd <dmlloyd@tds.net>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 21 Mar 2004, James Courtier-Dutton wrote:

> I thought of that, but with that you just get different problems.
> E.g. dmix only works is all application wishing to play sound are run by 
> the same user. You would probably need some daemon to run the /dev/dsp, 

Nope. See the ipc_perm option (and we might enhance the permissions 
setup in future).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
