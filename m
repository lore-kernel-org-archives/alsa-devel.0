From: jfm3 <jfm3@ouroboros-complex.org>
Subject: Re: hdsp driver status
Date: 03 Jul 2003 16:20:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1057263648.1244.24.camel@localhost.localdomain>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>
	 <3F044FF5.2010602@boosthardware.com>  <3F0456A5.9000600@boosthardware.com>
	 <1057252106.7192.61.camel@lotte>
	 <1057252985.1241.20.camel@localhost.localdomain>
	 <3F047C89.9080100@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F047C89.9080100@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: ALSA Developer List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-07-03 at 14:57, Patrick Shirkey wrote:
> > I have an 0xb Multiface. I haven't been able to load the firmware with
> > 0.9.4, either with the PCI or the PCMCIA interface. [...]
> 
> Try using this script if you don't already have something similar. I now 
> get sound through my line out:
> 
> --------------
> modprobe snd-hdsp; hdsploader;
> 
> # route jack inputs to line out
> # left
> amixer -c 1 cset numid=5 26,26,4000
> amixer -c 1 cset numid=5 28,26,4000 [...]

Thanks for the script. My problem isn't getting amixer commands right, I
don't even get that far. As my original message said, I can't load the
firmware. hdsploader fails. I don't have the output of how it fails with
me, but I've posted it to alsa-devel before.
-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
