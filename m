From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: hdsp multiface pci.
Date: Mon, 20 Jan 2003 01:33:17 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E2AD34D.6070308@boosthardware.com>
References: <3E2A952E.6060305@boosthardware.com>	 <1042985569.1663.33.camel@satellite.undata.org>	 <3E2AC45F.3070601@boosthardware.com> <1042992464.1649.55.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thomas Charbonnel wrote:
> 
> 
> You have to understand that software outputs are not directly related to
> physical outputs. On simpler hardware, software and physical outputs can
> be considered the same. On the hdsp system, thanks to the internal
> matrix mixer, software outputs are totally abstracted from physical
> ones. On the multiface you have 18 software outputs, each of wich can be
> independently routed to any of the 18 physical outputs. For convenience,
> the hdsp linux driver's default behaviour is to have a 1:1 routing
> policy: each software output is by default routed to to corresponding
> hardware output.
> So the "numid=5 26,26,16384" line says:
> connect software output 1 (called "playback" in the above table) to line
> out left, as the syntax of the call is input_source,output_source,value.
> 

Great explanation. I have added it as an editors note on the hdsp page.

so it's default is a fifo?

i.e 	software output 26 -> analog output 1
	software output 27 -> analog output 2....

Therefore can I do this?

numid=5 26,0,16384			
numid=5 27,1,16384
numid=5 28,2,16384
numid=5 29,3,16384
numid=5 30,4,16384
numid=5 31,5,16384
numid=5 32,6,16384
numid=5 33,7,16384

Or is that the default setting (except with no volume).

> 
> Here it looks like you're mixing up the amixer numid parameter number
> with the hdsp internal channel numbers.
> Numid 5 is the actual alsa matrix mixer control. Numid 10 is the global
> line out switch. Numid 26 and 27 are read only, and correspond to the
> internal peak and rms calculation the card does to provide a 0% CPU
> metering solution (to be used in the forthcoming HDSPMixer totalmix
> clone !...)
> 
> I hope this makes things clearer.
> 

Getting there. So we have to tell the control called numid=5 to route 
the output from software 1 to line out before we can hear it through 
line out?

Can we route multiple software outputs to the same hardware output?

eg.	numid=5 26,26,16384			
	numid=5 27,27,16384
	numid=5 28,26,16384
	numid=5 29,27,16384
	numid=5 30,26,16384
	numid=5 31,27,16384
	numid=5 32,26,16384
	numid=5 33,27,16384

Or is that what the .asoundrc is for?



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
