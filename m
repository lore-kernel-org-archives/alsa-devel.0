From: Jos van den Oever <jos@vandenoever.info>
Subject: Re: midi on ESS Solo with 2.6.0-test2
Date: Wed, 30 Jul 2003 15:47:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307301547.40431.jos@vandenoever.info>
References: <Pine.LNX.4.44.0307301526200.9821-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307301526200.9821-100000@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Use sbiload from the alsa-tools package to load FM instruments to
> the driver.


Oops, I forgot the arguments and sbiload didn't miss them. I ran:

./sbiload -p 65:0 /etc/playmidi/std.sb /etc/playmidi/drums.sb

And voila midi sound, finally. Tears come to my eyes. (-;

Thanks!
Jos




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
