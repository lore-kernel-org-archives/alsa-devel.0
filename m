From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: hdsp driver status
Date: Fri, 04 Jul 2003 03:57:13 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F047C89.9080100@boosthardware.com>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>	 <3F044FF5.2010602@boosthardware.com>  <3F0456A5.9000600@boosthardware.com>	 <1057252106.7192.61.camel@lotte> <1057252985.1241.20.camel@localhost.localdomain>
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
To: jfm3 <jfm3@ouroboros-complex.org>
Cc: ALSA Developer List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

jfm3 wrote:
> On Thu, 2003-07-03 at 13:08, Justin Cormack wrote:
> 
>>On Thu, 2003-07-03 at 17:15, Patrick Shirkey wrote:
>>
>>>Patrick Shirkey wrote:
>>>
>>>>Thomas Charbonnel wrote:
>>>>
>>>>
>>>>>Remaining:
>>>>>* HDSP9652: the matrix mixer isn't yet handled right.
>>>>>* Rev11 + Multiface: either the firmware file is wrong or the io-box
>>>>>firmware upload scenario has changed for this card revision. Has anyone
>>>>>ever had success with this combination (or rev11 + Digiface) ?
>>>>>
>>>>
>>you mean 0xb? I have one that works on 0.9.0rc5, but wont work on
>>0.9.4/todays cvs.
>>
>>And now I have a 0xa revision that wont work at all on any version of
>>the driver...
> 
> 
> I have an 0xb Multiface. I haven't been able to load the firmware with
> 0.9.4, either with the PCI or the PCMCIA interface. I have not tried
> 0.9.0rc5, nor have I tried loading the firmware with windows and warm
> booting. Either route is a lot of work. I'd rather see the hardware
> documentation and work on the driver source code. Thanks for any help!
> 

Try using this script if you don't already have something similar. I now 
get sound through my line out:

--------------
modprobe snd-hdsp; hdsploader;

# route jack inputs to line out
# left
amixer -c 1 cset numid=5 26,26,4000
amixer -c 1 cset numid=5 28,26,4000
amixer -c 1 cset numid=5 30,26,4000
amixer -c 1 cset numid=5 32,26,4000
# right
amixer -c 1 cset numid=5 27,27,4000
amixer -c 1 cset numid=5 29,27,4000
amixer -c 1 cset numid=5 31,27,4000
amixer -c 1 cset numid=5 33,27,4000

# Set volume for analog outputs to reasonable level
# and connect jack inputs to analog outs
amixer -c 1 cset numid=5 26,0,4000;
amixer -c 1 cset numid=5 27,1,4000;
amixer -c 1 cset numid=5 28,2,4000;
amixer -c 1 cset numid=5 29,3,4000;
amixer -c 1 cset numid=5 30,4,4000;
amixer -c 1 cset numid=5 31,5,4000;
amixer -c 1 cset numid=5 32,6,4000;
amixer -c 1 cset numid=5 33,7,4000;
amixer -c 1 cset numid=5 34,8,4000;
-------------

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
