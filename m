From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: hdsp driver status
Date: Fri, 04 Jul 2003 01:34:24 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F045B10.9030403@boosthardware.com>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org> <3F044FF5.2010602@boosthardware.com> <3F0456A5.9000600@boosthardware.com>
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
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> 
> I'll also try with amixer just incase.

Yep. Things changed again. This time Jeds rich and I'm happy.

The line outs are still kaput but the outputs are working.

I got a nice clear clean signal from output 1 and 2 after running:

amixer -c 1 cset numid=23 0,0,4000;
amixer -c 1 cset numid=24 0,0,4000;
amixer -c 1 cset numid=25 0,0,4000;
amixer -c 1 cset numid=26 0,0,4000;
amixer -c 1 cset numid=27 0,0,4000;
amixer -c 1 cset numid=28 0,0,4000;
amixer -c 1 cset numid=29 0,0,4000;
amixer -c 1 cset numid=30 0,0,4000;
amixer -c 1 cset numid=31 0,0,4000;
amixer -c 1 cset numid=32 0,0,4000;
amixer -c 1 cset numid=33 0,0,4000;
amixer -c 1 cset numid=34 0,0,4000;
amixer -c 1 cset numid=34 0,0,4000;
amixer -c 1 cset numid=35 0,0,4000;
amixer -c 1 cset numid=36 0,0,4000;
amixer -c 1 cset numid=37 0,0,4000;
amixer -c 1 cset numid=38 0,0,4000;
amixer -c 1 cset numid=39 0,0,4000;
amixer -c 1 cset numid=40 0,0,4000;

Someone might want to make a script out of this...

Now I can start recording :)

-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
