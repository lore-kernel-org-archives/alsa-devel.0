From: Chris Raphael <raphael@math.umass.edu>
Subject: Re: playing underruns
Date: Thu, 13 Feb 2003 14:07:08 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302131907.h1DJ78H07915@fafner.math.umass.edu>
References: <200302131435.h1DEZWn21451@thales.math.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200302131435.h1DEZWn21451@thales.math.umass.edu> (message from
	Paul Davis on Thu, 13 Feb 2003 09:35:12 -0500)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Paul,  Again thanks very much.  From: 

/sbin/hdparm /dev/hda2

I get:

/dev/hda2:
 multcount	= 16 (on)
 I/O support	= 0 (default 16-bit)
 unmaskirq	= 0 (off)
 using_dma	= 1 (on)
 keepsettings	= 0 (off)
 nowerr		= 0 (off)
 readonly	= 0 (off)
 readahead	= 8 (on)
 geometry	= 4864/255/73, sectors = 36869175, start = 4225095

with similar results for the other hda's.  I don't know if this
is the question you were asking, though, since this doesn't seem
to have much info.  

I don't have the low latency patch.  

I will take a look at jackit.sf.net.  However, I am close to having 
the sound I/0 working the way I need it to, so I am a little reluctant
to start all over.  :)

Chris


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
