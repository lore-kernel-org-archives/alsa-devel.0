From: Ludovic Drolez <ludovic.drolez@freealter.com>
Subject: Re: oops with 2.4.22 alsa 0.9.8 and a non-pnp sb16 (solved !)
Date: Sun, 09 Nov 2003 02:01:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAD9204.6070709@freealter.com>
References: <3FAD13D8.7040007@freealter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FAD13D8.7040007@freealter.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Third and last episode !

There was something strange with my problems: kernel panics or oops never
occured twice in the same module.
And I remembered the problems I got with my radeon glx drivers, for which the
FAQ says, you should compile modules with the same compiler used for the kernel...

So I recompiled alsa with gcc 3.3 instead of 3.0 ... and everything is working
fine now !!! (That was no so simple in fact. Before doing this recompilation, I
removed all PCI cards one by one from my PC, I tried old alsa releases (0.5),
tried non-free OSS drivers,... everything ended with kernel panics...)

Cheers,

   Ludovic Drolez.



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
