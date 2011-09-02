From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: A debug version of the ALSA lib?
Date: Fri, 02 Sep 2011 20:16:00 +0200
Message-ID: <4E611D60.4060902@canonical.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>  ,
	<CACTFLANvcWLEAtPuobu3j+m2608fB5oF7A1sQu8DeXj5u=Zbyw@mail.gmail.com>
	, <1314960940.3526.27.camel@mattotaupa>
	<4E60C7A3.369.112627E@olivier.myriad-online.com>
	<1314978185.3526.44.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 8782A245A0
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 20:16:02 +0200 (CEST)
In-Reply-To: <1314978185.3526.44.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/02/2011 05:43 PM, Paul Menzel wrote:
> Am Freitag, den 02.09.2011, 14:10 +0200 schrieb Olivier Guillion - Myriad:
>> Daniel Mack, then Paul Menzel wrote:
>>>>>> Or just use the binary Ubuntu packages and be done.
>>>>>
>>>>> Sorry, but what does it mean?
>>>>
>>>> That means that Ubuntu (as many other distros) offers you a
>>>> ready-made, debug symbols enabled version of the library which you can
>>>> just install and use. As you're struggeling with compiling the library
>>>> youself, I'd suggest you go for this solution. In Ubuntu, the package
>>>> you're looking for is called libasound2-dev.
>>>
>>> I have not followed the thread, but if you want debugging symbol you
>>> need `libasound2-dbg`. (`aptitude search libasound*`)
>>
>> I installed the libasound2-dev package.
>> I got mainly :
>> - a bunch of C header files in /usr/include
>> - libasound.a, libasound.la and libasound.so in /usr/lib
>> (none of these libraries include the debugging symbols)
>>
>> I tried "aptitude search libasound*"
>> and got:
>> libasound-dev
>> libasound2
>> libasound2-dev
>> libasound2-doc
>> libasound2-plugin-equal
>> libasound2-plugins
>>
>> but no libasound2-dbg.
>> Any idea about where (and how) I can get it? (using Ubuntu 11.04)
>
> I am using Debian Sid/unstable. Maybe David (put in CC) can say how to
> do that in Ubuntu.

We build debug symbols for every package and keep them at a separate 
repository at ddebs.ubuntu.com. For more information about how to find 
and install them see https://wiki.ubuntu.com/DebuggingProgramCrash

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
