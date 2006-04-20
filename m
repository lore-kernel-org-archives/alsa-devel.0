From: "alasinski" <alasinski@rogers.com>
Subject: Re: Re: Re: How to access vendor specific AC97codecregister?
Date: Thu, 20 Apr 2006 13:40:25 -0400
Message-ID: <e28h2d$qij$1@sea.gmane.org>
References: <e28805$nlf$1@sea.gmane.org> <1145546855.3008.0.camel@mindpipe> <e28ag6$1hb$1@sea.gmane.org> <1145549628.25762.4.camel@localhost.localdomain> <e28dd5$chl$1@sea.gmane.org> <1145552273.25762.22.camel@localhost.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

>> > You will only be able to access these functions from an ad-hoc AC97
>> > driver. Please see the UCB14xx touch driver for implementation details.
>> - where I can find it ?
>
> Please use Google.
Your Google must be better then mine. But I don't give up, I'm still 
looking. For sure UCB14xx leads nowhere. Little hint could go long way.

>> How to go about using sysfs() to access to registers ? It provides info 
>> on
>> file system equivalent to /proc/filesystems content I'm told. I know of 
>> one
>> way to do it: I can map registers into user space with 
>> open("/dev/mem",...)
>> followed by mmap (...). Then I'm a king and can read/write to any of 
>> them.
>
> This wont work for AC97 codec registers as they are not part of the host
> memory map and are accessed via the hosts AC97 controller.
It should. What I intended to do is make same calls as pxa2xx_ac97_read. It 
talks to memory mapped AC97 codec registers to obtain content of UCB1400 
registers. They appear to be mapped 1 to 1 with gsr_bit toggled as a 
handshake protocol.

Is sysfs() going to be more helpfull ?

cheers
-al 





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
