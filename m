From: "Ronny V. Vindenes" <s864@lstud.ii.uib.no>
Subject: Re: make install for alsa-lib 0.9.1
Date: Thu, 13 Mar 2003 13:26:33 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303131320200.15046-100000@snylter.ii.uib.no>
References: <m2llzja3c4.fsf@enfocus.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2llzja3c4.fsf@enfocus.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Immanuel Litzroth <immanuell@enfocus.be>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 13 Mar 2003, Immanuel Litzroth wrote:

> 
> I use stow for package management and I noticed that 
> ./configure --prefix=/usr
> make 
> make install prefix=/usr/stow/alsa-lib
> still installs the libraries in /usr/lib. Previous versions worked
> installed in the correct place. Is this a bug?
> Immanuel
> 

IMHO it's a bug. You can work around it by doing
make install DESTDIR=/usr/stow/alsa-lib

-- 
Ronny V. Vindenes <sublett@dc-s.com>



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
