From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Building Takashi's sound-2.6.git?
Date: Fri, 20 Aug 2010 22:29:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008202229190.10278@eeebox2.perex-int.cz>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
	<s5hsk29conv.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1008201729440.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE37665A@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008201833100.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE37666D@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008202011380.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE376670@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008202134330.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE37668C@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 55D1F24465
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 22:29:58 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FE37668C@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Aug 2010, Stephen Warren wrote:

> Jaroslav Kysela wrote:
>> Stephen Warren wrote:
>>> Jaroslav Kysela wrote:
>>>> Stephen Warren wrote:
>>>>> Unfortunately, it doesn't seem to work:
>>>>>
>>>>> ALSAKERNELDIR=../sound-2.6/sound ./gitcompile
>>>>
>>>> It should be:
>>>>
>>>> ALSAKERNELDIR=../sound-2.6 ./gitcompile
>>>
>>> sound-2.6 is a complete Linux kernel tree, not just the ALSA drivers.
>>> Hence, the second part of the following test fails, because last.c is in
>>> ../sound-2.6/sound/last.c not ../sound-2.6/last.c
>>>
>>> if [ ! -d $ALSAKERNELDIR -o ! -f $ALSAKERNELDIR/last.c ]; then
>>>    echo "No alsa-kmirror is found."
>>
>> You're right. But the Makefile accepts both trees. This patch should solve
>> this issue:
>
> OK, that patch works OK, but I actually ended up getting the exact same issue.
>
> make[3]: Warning: File `.includes' has modification time 0.04 s in the future
> cp ../../alsa-kernel/include/*.h .
> cp: cannot stat `../../alsa-kernel/include/*.h': No such file or directory
>
> I looked into that further this time, and I found it's because
> alsa-driver-build/alsa-kernel/include points at ../sound-2.6/include/sound,
> but should have an extra "../" on the front. Doing the following fixes this:
>
> ALSAKERNELDIR=`cd ../sound-2.6 && pwd` ./gitcompile
>
> Doesn't this affect the ../alsa-kmirror case too? Perhaps everyone who checks
> out alsa-kmirror places it inside the alsa-driver-build directory, or symlinks
> it themselves first?
>
> Perhaps gitcompile can add the following right before the make:
>
> ALSAKERNELDIR=`cd ${ALSAKERNELDIR} && pwd`

Good catch. The fix is in my tree now:

http://git.alsa-project.org/?p=alsa-driver.git;a=commitdiff;h=59ca79b3253de1c160ee446a67d3d5fd2b4dba92

 				Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
