From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: FIX: soundblaster rear channels (ens1371)
Date: Fri, 17 Jan 2003 13:11:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301171311.12245.pieter.palmers@student.kuleuven.ac.be>
References: <Pine.LNX.4.33.0301171229200.4134-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0301171229200.4134-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Uros Bizjak <uros@kss-loka.si>
List-Id: alsa-devel@alsa-project.org


>
> Done. Pieter, can you try the latest CVS source. When surround DAC is
> found, there should be 'AC97 2ch->4ch Copy Switch' which controls
> mirroring / separating channels. The front only configuration will be
> used only for cards with no surround DAC. Thank you for your work.
>

CVS refuses connection:

	[ppalmers@ox ppalmers]$ cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa login
	Logging in to :pserver:anonymous@cvs.sourceforge.net:2401/cvsroot/alsa
	CVS password:
	cvs [login aborted]: connect to cvs.sourceforge.net(66.35.250.207):2401 failed: Connection refused

	[ppalmers@ox ppalmers]$ cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-driver
	cvs [checkout aborted]: connect to cvs.sourceforge.net(66.35.250.207):2401 failed: Connection refused

Web based access also refuses service:

	An error occured while loading http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/alsa:

	Timeout on server
	cvs.sourceforge.net

Pieter


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
