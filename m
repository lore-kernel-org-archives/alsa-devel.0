From: Roger Williams <raw@qux.com>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 12:00:25 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3d6mt9is6.fsf@grouper.coelacanth.com>
References: <3E2A952E.6060305@boosthardware.com>
	<1042985569.1663.33.camel@satellite.undata.org>
	<3E2AC45F.3070601@boosthardware.com>
	<1042992464.1649.55.camel@satellite.undata.org>
	<3E2AD34D.6070308@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E2AD34D.6070308@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>>>>> Patrick Shirkey <pshirkey@boosthardware.com> writes:

  > Can we route multiple software outputs to the same hardware output?

Yes.  For instance, when recording 8 tracks, I'll generate a monitor
mix (for JACK's outputs) to outputs 1 & 2 like this:

amixer cset numid=5 26,26,16384
amixer cset numid=5 28,26,16384
amixer cset numid=5 30,26,16384
amixer cset numid=5 32,26,16384
amixer cset numid=5 27,27,16384
amixer cset numid=5 29,27,16384
amixer cset numid=5 31,27,16384
amixer cset numid=5 33,27,16384

-- 
Roger Williams <raw@qux.com>
Qux Tool & Die, Middleborough, Massachusetts
// Omne tulit punctum qui misquit utile dulci //


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
