From: Jos van den Oever <jos@vandenoever.info>
Subject: Re: midi on ESS Solo with 2.6.0-test2
Date: Wed, 30 Jul 2003 15:41:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307301541.42433.jos@vandenoever.info>
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

I downloaded this package and ran:

bzcat alsa-tools-0.9.6.tar.bz2 |tar xf -
cd alsa-tools-0.9.6/seq/sbiload
./configure --with-kernel=2.6.0-test2
make
./sbiload -p 65:0
pmidi -p 65:0 somefile.mid

still no sound




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
