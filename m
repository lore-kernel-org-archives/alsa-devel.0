From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp/firmware problem
Date: Fri, 14 Feb 2003 10:49:03 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18ji5U-0007Op-00@sc8-sf-list1.sourceforge.net>
References: <20030214153724.GB2192@finnendahl.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 14 Feb 2003 16:37:24 +0100."
             <20030214153724.GB2192@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>got this additional Info from R'dam for those interested.
>
>Wasn't the warm boot corrected with the old firmware?

no. it was connected with a bug in the driver that marcus fixed. on
little-endian platforms we failed to write a "terminating" byte to the
FIFO at the end of the firmware load. 

i believe that this patch is in CVS, but i haven't checked. i assume
the R'dam system is using the "latest" code?

--p


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
