From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp/firmware problem
Date: Fri, 14 Feb 2003 08:30:24 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18jfvD-0006MO-00@sc8-sf-list1.sourceforge.net>
References: <20030214131848.GA1586@finnendahl.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 14 Feb 2003 14:18:48 +0100."
             <20030214131848.GA1586@finnendahl.de>
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

>the driver/interface works. The guy in Rotterdam tried the line
>outputs on the front (I realized that this might have been the reason
>5 minutes after I posted my previous mail).

can you clarify what you mean by this?

>Since the hdsp code reports firmware load failure there still might be
>something wrong, but the Multiface plays sound as it should :-).

so it looks like it may just a need for a more lenient timeout check
on the FIFO?


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
