From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Sound Blaster 4.1 problem (ens1371)
Date: Tue, 14 Jan 2003 17:22:37 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301141721240.504-100000@pnote.perex-int.cz>
References: <200301111123.52102.pieter.palmers@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301111123.52102.pieter.palmers@student.kuleuven.ac.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Jan 2003, Pieter Palmers wrote:

> Hi,
> 
> I own a soundblaster 4.1 and I experience the following problem: I can't get 
> the rear channel to work. There isn't even a volume control for it (neither 
> in amixer nor in alsamixer). I'm using the snd-ens1371 driver that should do 
> the job.
> 
> The card is a basic design using a CT5880 PCI controller and a Sigmatel 
> STAC9708T codec. That's what's printed on the chips.

The whole problem is, that I don't know, how we can route the signal to 
rear slots of AC'97 codec (STAC9708T). Documentation is missing.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
