From: "alasinski" <alasinski@rogers.com>
Subject: Re: Re: Re: Re: How to access vendor specificAC97codecregister?
Date: Thu, 20 Apr 2006 14:54:25 -0400
Message-ID: <e28ld5$9r1$1@sea.gmane.org>
References: <e28805$nlf$1@sea.gmane.org> <1145546855.3008.0.camel@mindpipe> <e28ag6$1hb$1@sea.gmane.org> <1145549628.25762.4.camel@localhost.localdomain> <e28dd5$chl$1@sea.gmane.org> <1145552273.25762.22.camel@localhost.localdomain> <e28h2d$qij$1@sea.gmane.org> <1145556884.25762.40.camel@localhost.localdomain>
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

>> Your Google must be better then mine. But I don't give up, I'm still
>> looking. For sure UCB14xx leads nowhere. Little hint could go long way.
> Google for "linux ucb touchscreen driver"
> Also look in drivers/mfd/
OK, I have: drivers/mfd/ucb1x00*.* I will look at those. Thx

>> > This wont work for AC97 codec registers as they are not part of the 
>> > host
>> > memory map and are accessed via the hosts AC97 controller.
>> It should. What I intended to do is make same calls as pxa2xx_ac97_read. 
>> It
>> talks to memory mapped AC97 codec registers to obtain content of UCB1400
>> registers. They appear to be mapped 1 to 1 with gsr_bit toggled as a
>> handshake protocol.
>>
> I'm afraid it's not a simple as that (only register 0x54 can work this
> way - see pxa manual on AC97 slot 12). You still have to check and clear
> the command and status done bits in GSR. You will also have to manage
> access with the audio driver as only one read/write can take place at a
> time over the AC97 link. I'm not sure how your going to use your mmap
> vm_ops to do all this.
I'm not sure either. If pxa2xx_ac97_read() can do it (remenber /proc/...regs 
where all registers are listed?), why applying same strategy in a user code 
would fail ? At that point I will just cobble some code and let it try. As 
far interference with existing ALSA it may be tricky. I will find out a hard 
way, I'm afraid. Will keep you posted. Thx.





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
