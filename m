From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 28 Sep 2004 15:22:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4159659B.2020702@pg.gda.pl>
References: <200409281113.i8SBDo5U021462@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409281113.i8SBDo5U021462@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>>you're simply wrong about this. if an interrupt is blocked for longer
>>>than the buffer size, GETOPTR can't help you.
>>
>>It depends of kernel driver behaviour. If it could not detect this 
>>situaction then of course no. But this is easy to detect just by 
>>monitoring actual system time and amount of data send to/received from 
>>device. We know what should be the proper value.
>>Anyway if this situaction occurs how ALSA driver detects it?
>>hw_ptr is not moved and appl_ptr too so how ALSA is doing that?
> 
> thats my whole point. the facilities offered by OSS to track this
> stuff all presuppose that this kind of disaster can't happen, but it
> *does* happen. ALSA obviously cannot do any better in that situation,
> but it has an infrastructure in place that doesn't make the assumption
> that things just work. It would be easy to get ALSA to indicate an
> xrun in the above situation; it would be quite hard to get OSS to do
> so.

So ALSA is not any better in that situaction ;-(. Talking about OSS
if we modify the driver so it detects hardware xruns it can report them
in a same manner as software ones. For example GETOPTR bytes value 
should return count of bytes which would be processed by a device
if there was no xrun. hw_ptr will be unchanged. So we can correct our 
sample position because we know the delay and the hw_ptr.
I think that the problem is not in the API but in the kernel driver.
It should detect this situaction - both ALSA and OSS driver.


> anyway, we're way off topic here. the essential issue is that you want
> an API that allows for large buffers but also lets you overwrite stuff
> you have written in the past, in order to offer the illusion of low
> latency without impacting CPU load too much. by contrast, the
> pro-audio/music world wants small buffer sizes to reduce latency
> because we do everything in real time. the consumer audio world wants
> virtual devices with various specific capabilities that hide the
> complexity of the underlying hardware. the kernel developers don't
> want emulators, sample rate converters and so on in the kernel.
Yes and almost all of this problems could be solved by mixing
this kernel/userspace approach. A kernel module emulating /dev access
and ioctl's communicating with RT daemon which is doing real job
and contacting with physical device.

/dev access is needed for compability and access granting (chmod and 
ACL's) and also simple cat file.wav > /dev/dsp possibilities,
OSS apps also need that

more sophisticated apps can talk directly to the daemon and through it
to the hw device


> 
> in the windows world, the two outlined goals are viewed as orthogonal,
> and nobody uses the same audio driver API to achieve them. that maybe
> changing with WDM, but at least until recently, the pro-audio world
> focused on ASIO which no games use; games used directX, which almost
> no audio apps did.
Linux is not only for pro-audio world I think. And placeing something in 
kernel (ALSA drivers I mean) should not break existing normal apps.

> and anyway, i am not really sure what you want. ALSA lets you do what
> you want but at the cost of having to make a few more function calls
> to cover the handling of virtual devices. you don't like the cost,
current ALSA could not meet my requirements because of 
swapping/scheduling effects which makes distorted sound in normal non RT 
apps. Doing just a few more calls doesn't help in this case ;-[.

> you'd rather move the cost so that its in the
> kernel or a library rather than be in your code. that's the best i can
> understand so far.
Yes - that's the point. Common operations like format changeing, 
resampling, remixing and additional effects should be done
in one place not in every app by itself.
I want to have possibility of doing cat file.wav > /dev/dsp
and play it with 5.1 or 2 speakers or with headphones with special 
stereo  effects applied just by one click or keypress on special mixer 
app on the fly without restarting anything and fiddling with config 
files and program execution arguments.
Current ALSA design is not user friendly and rather not meets these end 
user requirements. May be it should be only for audio profs?

Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
