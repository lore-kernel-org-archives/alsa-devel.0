From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: How to route "spdif" to an FXBUS of emu10k1
Date: Thu, 9 Jan 2003 13:00:13 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301091256340.706-100000@pnote.perex-int.cz>
References: <73972737454@Octopus.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA32695
	for <alsa-devel@alsa-project.org>; Thu, 9 Jan 2003 13:00:27 +0100
In-Reply-To: <73972737454@Octopus.et.tudelft.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gerard Janssen <G.Janssen@ITS.TUDelft.NL>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Jan 2003, Gerard Janssen wrote:

> Hi Jaroslav,
> 
> Many thanks for your reply. This realy solved my problem.
> 
> I have been able to implement a new PCM-stream and send it to empty FXBUS
> registers. However, I could not find .asoundcr (I am using SUSE 8.1 with
> ALSA_rc6). Where is it? In stead, I adapted alsa.conf, emu10k1.conf and
> added a pcm_new.conf in /usr/share/alsa/ and this worked. 

It's not necessary. The ~/.asoundrc file is also loaded, so you can store 
your local configuration there.

> After having done this, I am stuck with some questions. Why are there no
> "Send Routing" lines in the "front" and "rear" config files, since they are
> routed to FXBUS? 
> Why do the lines:
> >        /* 22: */ OP(icode, &ptr, iMACINT1, ETRAM_ADDR(ipcm->etram[0]),
> GPR(gpr + 8), GPR_DBAC, C_ffffffff);
> >        /* 23: */ OP(icode, &ptr, iMACINT1, ETRAM_ADDR(ipcm->etram[1]),
> GPR(gpr + 9), GPR_DBAC, C_ffffffff);
> have to be removed?

I've a bit overlooked the code. The simplest way is to initialize GPR(8) 
and GPR(9) after the direct PCM part over ETRAM, so the 22: and 23: lines 
can be replaced with

        OP(icode, &ptr, iMACINT0, GPR(8), C_00000000, FXBUS(8), C_00000004);
        OP(icode, &ptr, iMACINT0, GPR(9), C_00000000, FXBUS(9), C_00000004);

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
