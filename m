From: Max Klein <mein_name@ist-einmalig.de>
Subject: Re: alsa-driver cross compile problem - upgrading ALSA
Date: Mon, 02 Jul 2012 09:58:21 +0200
Message-ID: <4FF1549D.5050206@ist-einmalig.de>
References: <20120629153248.29780@gmx.net>
	<CADgpFcpmf2LQzXYnfvUgZttAw0Ko71CdaTpAMJ+d3HpT0omTJA@mail.gmail.com>
Reply-To: mein_name@ist-einmalig.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id C17C72440B
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 09:58:28 +0200 (CEST)
In-Reply-To: <CADgpFcpmf2LQzXYnfvUgZttAw0Ko71CdaTpAMJ+d3HpT0omTJA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: raj raja <yuvaraj.addu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

What do you mean exactly? Am I missing any option? The other way around
would be to try integrating a newer ALSA driver version into my kernel
source (therefore updating the integrated ALSA driver before building
the kernel and afterwards directly build the Kernel with updated ALSA
version)?

> Better you compile with kernel
>
>
> Thanks
>
> Yuvi R
>
> On Fri, Jun 29, 2012 at 9:02 PM, Max Klein <mein_name@ist-einmalig.de>wrote:
>
>> I am running 2.6.27 kernel on arm board with ALSA driver version 1.0.17
>> (cat /proc/asound/version) and I would like to update ALSA driver version
>> to current 1.0.25.
>>
>> I am trying to build alsa-drivers with "./configure
>> --with-cross=arm-none-linux-gnueabi- --enable-dynamic-minors
>> --with-debug=full --with-isapnp=no --with-oss=no
>> --with-kernel=/data/src/kernel/linux-davinci
>> --with-build=/data/src/kernel/linux-davinci --with-sequencer=no"
>>
>> Afterwards I compile it via "make ARCH=arm" but this fails we the
>> following error:
>>
>> In file included from
>> /data/VRM/davinci33/alsa-1.0.25/alsa-driver-1.0.25/acore/hrtimer.c:1:
>> /data/VRM/davinci33/alsa-1.0.25/alsa-driver-1.0.25/include/adriver.h:753:
>> error: static declaration of 'jiffies_to_msecs' follows non-static
>> declaration
>> include/linux/jiffies.h:286: error: previous declaration of
>> 'jiffies_to_msecs' was here
>> /data/VRM/davinci33/alsa-1.0.25/alsa-driver-1.0.25/include/adriver.h:772:
>> error: static declaration of 'msecs_to_jiffies' follows non-static
>> declaration
>> include/linux/jiffies.h:288: error: previous declaration of
>> 'msecs_to_jiffies' was here
>>
>>
>> Can someone please help me how to get ALSA upgraded on my platform?
>> Obviously I am either doing something wrong when configuring or I am on the
>> absolutely wrong way?
>>
>> I am looking forward for any advice, thanks in advance!
