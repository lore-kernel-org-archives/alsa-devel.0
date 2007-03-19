From: Pieter Palmers <pieterp@joow.be>
Subject: Re: alsa userspace interface
Date: Mon, 19 Mar 2007 12:36:29 +0100
Message-ID: <45FE75BD.8040101@joow.be>
References: <3BC073ED-BC5A-48AB-A3D0-21F3A23B4DDB@xant.net>
	<1174298934.28822.1180148355@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1174298934.28822.1180148355@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Andrea Guzzo <xant@xant.net>, linux1394-devel@lists.sourceforge.net, Stefan Richter <stefanr@s5r6.in-berlin.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Andrea Guzzo wrote:
>> we are wondering if it's possible to register an alsa device from
>> userspace.
> 
> It is not possible to register a kernel device from userspace, but it is
> possible to write a plugin that is used by the alsa library like a
> kernel device.
> 
> Have a look into the alsa-plugins package.
Might I raise the documentation issue here? Last time I checked (1.0.9) 
it was very difficult to understand what exactly was going on.

Glancing at the current alsa-lib-plugins I see that there are some new 
ones that might help.

> 
>> Is there any working or experimental one?
> 
> The FreeBoB project is writing an ALSA plugin for some IEEE1394 devices.


We could implement iSight support in our framework, it wouldn't be that 
much work I guess. The only issue could be that we have a more pro-audio 
point of view. However it is probably beneficial to both parties to use 
FreeBoB, as we have tried to make device support as easy as possible, 
abstracting everything related to audio API's and FireWire. If you know 
the device & the framework, implementing support is a matter of days.

Note however that unless somebody starts to help out, the FreeBoB ALSA 
plugin might take some time.

One major issue with userspace audio drivers is that stock/distro 
kernels are not good enough to make it work reliably with acceptable 
latencies (we're talking a videoconferencing device here). Having to 
install a RT kernel is IMHO only justifiable for (dedicated) 'audio' 
boxes, and should not be something that is required for 
videoconferencing. And if you would want to use them on stock kernels, 
you need a way to get SCHED_FIFO as an ordinary user, which again is not 
available on stock distro's.

Pieter
FreeBoB

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
