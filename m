From: "alasinski" <alasinski@rogers.com>
Subject: Re: Re: How to access vendor specific AC97 codecregister?
Date: Thu, 20 Apr 2006 12:37:54 -0400
Message-ID: <e28dd5$chl$1@sea.gmane.org>
References: <e28805$nlf$1@sea.gmane.org> <1145546855.3008.0.camel@mindpipe> <e28ag6$1hb$1@sea.gmane.org> <1145549628.25762.4.camel@localhost.localdomain>
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

Thx Liam,

> You will only be able to access these functions from an ad-hoc AC97
> driver. Please see the UCB14xx touch driver for implementation details.
- where I can find it ?

> Alternatively, you could always export the vendor specific registers
> using sysfs. That way your user space program could read and write to
> the codec registers exported. I've done this with the codec GPIO status
> register (0x54) for the WM97xx touch drivers.
How to go about using sysfs() to access to registers ? It provides info on 
file system equivalent to /proc/filesystems content I'm told. I know of one 
way to do it: I can map registers into user space with open("/dev/mem",...) 
followed by mmap (...). Then I'm a king and can read/write to any of them. 
This is actually my fallback plan if ALSA proves to be to difficult (which 
start looking right now). Interacting with registers directly from a user 
program is not a recommended way: first timing become an issue, secondly I'm 
afraid of  unexpected interaction with a driver that is already loaded, 
thirdly there is an initialization stuff that needs to be done on UCB1400 as 
part of generic AC97 "bring to life" that I would rather delegate to ALSA 
driver rather then go over it all myself.

> I've done this with the codec GPIO status register (0x54) for the WM97xx 
> touch drivers.
Did you handled AC97 initialization yourself, or you relied on other driver 
(exp: ALSA) ?


cheers
-al

"Liam Girdwood" <liam.girdwood@wolfsonmicro.com> wrote in message 
news:1145549628.25762.4.camel@localhost.localdomain...
> On Thu, 2006-04-20 at 11:48 -0400, alasinski wrote:
>> Thx Lee,
>>
>> I have looked at pxa2xx-ac97.c driver. It provides generic functions to
>> read/write any ac97 register: pxa2xx_ac97_read/write that are made 
>> available
>> to generic ac97_codec with snd_ac97_bus() call. My problem is I don't 
>> know
>> how to invoke those functions with proper arguments from application 
>> level.
>
> You will only be able to access these functions from an ad-hoc AC97
> driver. Please see the UCB14xx touch driver for implementation details.
>
> Alternatively, you could always export the vendor specific registers
> using sysfs. That way your user space program could read and write to
> the codec registers exported. I've done this with the codec GPIO status
> register (0x54) for the WM97xx touch drivers.
>
> HTH
>
> Liam
>
>
>
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job 
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642 





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
