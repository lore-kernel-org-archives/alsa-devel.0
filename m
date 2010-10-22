From: Florian Faber <faber@faberman.de>
Subject: Re: RME MADIface 192 kHz problem
Date: Fri, 22 Oct 2010 07:09:26 +0200
Message-ID: <4CC11C86.6090204@faberman.de>
References: <4CC03A21.2050406@ifi.uio.no>	<4CC049F2.1050707@faberman.de>
	<s5h1v7jclqd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 83AA9103833
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 07:09:32 +0200 (CEST)
In-Reply-To: <s5h1v7jclqd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

>>> What is needed to get this card running at 192 kHz?
>> A working driver :)
>>
>> http://wiki.linuxproaudio.org/index.php/Driver:hdspe
> How about posting the patches? :)

It would be dozens/hundreds of single patches against the hdspm driver.
I'd rather replace it with the version above. And I changed one ioctl
which would break compatibility - although I doubt anybody used the
levelmeter ioctl besides me. The version above is a 'public beta'.

If the support for the AIO/RayDAT finally works - sure. But for that I
still need to tell ALSA somehow that there are n buffers to use, n>2,
with n IRQs per buffer cycle.


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
