From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Sound Blaster 4.1 problem (ens1371)
Date: Tue, 14 Jan 2003 20:20:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301142018210.541-100000@pnote.perex-int.cz>
References: <200301141851.22286.pieter.palmers@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301141851.22286.pieter.palmers@student.kuleuven.ac.be>
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

> Anyway, the statement I wanted to make is: maybe I can use the same approach 
> to try spying on the ens1371. I already experienced that you can obtain a lot 
> of info fast if you know what you're looking for.
> 
> Should you have any suggestions on how I should build/enhance the 'bridge', 
> they are very welcome. I'm new to linux driver design, and kernel level code.

Thanks for explaining. Perhaps, you can log all accesses to i/o ports for 
ens1371 hardware from the windows drivers? It might be helpful - we can 
decode the init sequence.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
