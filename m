From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 18:20:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042996837.21521.17.camel@satellite.undata.org>
References: <3E2A952E.6060305@boosthardware.com>
	 <1042985569.1663.33.camel@satellite.undata.org>
	 <3E2AC45F.3070601@boosthardware.com>
	 <1042992464.1649.55.camel@satellite.undata.org>
	 <3E2AD34D.6070308@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

On Sun, 2003-01-19 at 17:33, Patrick Shirkey wrote:
> I have added it as an editors note on the hdsp page.

Thanks.

> so it's default is a fifo?
> 
> i.e 	software output 26 -> analog output 1
> 	software output 27 -> analog output 2....
> 

Strangely said, but yes.

> Therefore can I do this?
> 
> numid=5 26,0,16384			
> numid=5 27,1,16384
> numid=5 28,2,16384
> numid=5 29,3,16384
> numid=5 30,4,16384
> numid=5 31,5,16384
> numid=5 32,6,16384
> numid=5 33,7,16384
> 
> Or is that the default setting (except with no volume).
> 

Rather than bothering to use amixer, you'd better use alsamixer to
control those. These are the standard volume controls. (Internally the
volume controls use the matrix mixer)
If you want to hear sound through analog outputs 1-2 using software
outputs 1-2, you can either use amixer (e.g. amixer cset numid=5
26,0,16384) or alsamixer. 

> So we have to tell the control called numid=5 to route 
> the output from software 1 to line out before we can hear it through 
> line out?
> 
Yes. The control called numid=5 is the interface to the matrix mixer.

> Can we route multiple software outputs to the same hardware output?
> 
> eg.	numid=5 26,26,16384			
> 	numid=5 27,27,16384
> 	numid=5 28,26,16384
> 	numid=5 29,27,16384
> 	numid=5 30,26,16384
> 	numid=5 31,27,16384
> 	numid=5 32,26,16384
> 	numid=5 33,27,16384
> 
Yes we can :)

> Or is that what the .asoundrc is for?
> 
I don't know if you can do it with the .asoundrc file (I would rather
doubt it). Anyway the clear benefit of doing it with amixer is that it
is hardware mixing, thus consuming no system resources.

>From your latest post:
> In essence the hdsp can run 18 software streams at the same time as 
> processing upto 18 hardware input streams?
> 
Yes. In fact the hdsp system can run up to 26 of them (digiface).

> Do I need to set the volume for the analog inputs? Or will I be able
> to 
> capture from them without setting anything in amixer?
> 
You'll be able to capture without setting anything in amixer

Thomas




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
