From: Florian Faber <faber@faberman.de>
Subject: Re: RME MADIface 192 kHz problem
Date: Fri, 22 Oct 2010 11:54:36 +0200
Message-ID: <4CC15F5C.3010400@faberman.de>
References: <4CC03A21.2050406@ifi.uio.no>
	<4CC049F2.1050707@faberman.de>	<s5h1v7jclqd.wl%tiwai@suse.de>
	<4CC11C86.6090204@faberman.de> <s5hlj5qbngq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id C8FCD243C1
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 11:53:52 +0200 (CEST)
In-Reply-To: <s5hlj5qbngq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

>>>>> What is needed to get this card running at 192 kHz?
>>>> A working driver :)
>>>>
>>>> http://wiki.linuxproaudio.org/index.php/Driver:hdspe
>>> How about posting the patches? :)
>>
>> It would be dozens/hundreds of single patches against the hdspm driver.
> 
> I don't mind any number of patches if they are written logically and
> well readable.
> 
>> I'd rather replace it with the version above.
> 
> If it's more or less compatible with the current driver, it's fine.
> But, one bulk patch is bad.  Even if you replace the driver code,
> split in a logical order, at best.

There are changes everywhere since the old driver inherited a lot of
code from the hdsp driver which in turn inherited a lot of code from
previous drivers. The code was never properly suited to support a
broader range of hardware.

I don't have the time to split up all the changes in all the different
places and if I had the time, I would rather do a complete rewrite (or
better: Finish the rewrite I started a while ago).

>> And I changed one ioctl
>> which would break compatibility - although I doubt anybody used the
>> levelmeter ioctl besides me. The version above is a 'public beta'.
> If it's a new ioctl, it's OK.  We can drop the old (very likely)
> unused ioctl eventually.  But using the same ioctl for different
> behavior is no go.

Ok, dropping the old one in favour of the new one.

>> If the support for the AIO/RayDAT finally works - sure. But for that I
>> still need to tell ALSA somehow that there are n buffers to use, n>2,
>> with n IRQs per buffer cycle.
> Well, actually I forget what your questions are.  Please continue it
> on ML here.
> 
> All other sound drivers work fine with more than two periods, so I
> don't think there is any restriction in the API side.

Ok, the problem was that the AIO/RayDAT have two modes of operation, a
'windows' mode and a 'mac' mode. In the 'windows' mode the full 16k
sample buffer is utilized and the card produces 16k/period_size IRQs
while running through the buffer. I'd need a way to tell ALSA this.
In 'mac' mode it uses a double buffering scheme but only produces one
IRQ per each double buffer walkthru. I understand that ALSA does not
support this mode of operation.


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
