From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: Re: hdsp/firmware problem
Date: Fri, 14 Feb 2003 14:57:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030214135711.GA1792@finnendahl.de>
References: <20030214131848.GA1586@finnendahl.de> <200302141340.h1EDeNY24474@icemserv.folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200302141340.h1EDeNY24474@icemserv.folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Freitag, den 14. Februar 2003 um 08:30:24 Uhr (-0500) schrieb Paul Davis:
> >the driver/interface works. The guy in Rotterdam tried the line
> >outputs on the front (I realized that this might have been the reason
> >5 minutes after I posted my previous mail).
> 
> can you clarify what you mean by this?

It means he didn't use the rear outputs for checking but the line outs
on the front of the Multifaceq which are muted even if alsamixers
controls are up afaik.

> >Since the hdsp code reports firmware load failure there still might be
> >something wrong, but the Multiface plays sound as it should :-).
> 
> so it looks like it may just a need for a more lenient timeout check
> on the FIFO?

Maybe. It's quite stupid as I can't really check it myself.

--
Orm


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
