From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: hdsp driver status
Date: Fri, 04 Jul 2003 01:15:33 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F0456A5.9000600@boosthardware.com>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org> <3F044FF5.2010602@boosthardware.com>
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
> Thomas Charbonnel wrote:
> 
>>
>> Remaining:
>> * HDSP9652: the matrix mixer isn't yet handled right.
>> * Rev11 + Multiface: either the firmware file is wrong or the io-box
>> firmware upload scenario has changed for this card revision. Has anyone
>> ever had success with this combination (or rev11 + Digiface) ?
>>
> 
> I am using multiface which hasn't been flashed. I have upgraded to a 
> newer kernel (2.4.21) (0.9.4 tarball) and now I don't get the error 
> about finding hwdep when I run hdsploader but there is still no sound 
> coming from the device.
> 
> My friend tells me that in windows it will always have the WC button on 
> when it is working correctly.
> 
> In this case after running hdsploader the box flashes and then all the 
> lights turn off.
> 
> This device has worked with older versions of the alsa drivers.
> 

following the above I decided to check I was setting the correct params 
in the matrix and it turns out that line out has been moved to numid 22 
(before it was 5).

amixer -D hw:1 cset numid=22 0,0,16384

"And out of the box came a burbling noise, white noise that is, RME gold..."

So Jed wasn't rich yet but he was almost there. At least we know that 
the latest revisions are almost functional. I tried playing a very loud 
tune and I can just make it out if I listen carefully. I also tried 
using a volume of 32768 but there was no change in the levels I could hear.

Am I right to use alsamixer to set the volume for outputs 1-8?

I'll also try with amixer just incase.


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
