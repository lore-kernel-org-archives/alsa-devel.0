From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Sat, 26 Jul 2014 18:18:48 +1000 (EST)
Message-ID: <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
 <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id EC5D4264EF3
 for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2014 10:18:49 +0200 (CEST)
In-Reply-To: <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Sat, July 26, 2014 2:01 pm, Raymond Yau wrote:
>>
>> What is the best way to test/debug the alc668 driver these days?
>>
>> I am running kernel 3.14.1 (debian testing/sid).
>>
>> The laptop is an ASUS N750JK.
>>
>> Sound works for front left/right speakers but the back speakers and
>> external lfe channel is not working on this laptop.
>
> You have to post output of alsa-info.sh
>

http://boosthardware.com/alsa-info-alc668-n750jk.txt

> Do the BIOS setup all the pin default ?
>
> How many audio jacks ?
>

Standard headphone/mic + yellow external lfe (sonic master). There is also
hdmi but I am not testing that at the moment.

> Do it support headset or headphone ?
>
> Do you mean there are four internal speakers ?
>

There are two front speakers which produce sound through the front bottom
of the case. There are also two back speakers which do not produce sound
in my tests so far.

> Do it support surround40 in windows ?
>

I am not running windows OS on this machine but I suspect it does.

> The external sonic master and headphone need two volume controls but
> alc668 only have three
>
> The best way to test is using latest git version and hda jack retask to
>

The process has changed somewhat since I last did this.

Turns out that is not such as easy process with the 3.14.1 kernel in
debian sid/testing. From the looks of it I have to compile my own kernel
to get all the necessary build files.


make[1]: Leaving directory '/home/patrick/code/alsa/alsa-driver/alsa'
make -C /lib/modules/3.14-1-amd64/source
SUBDIRS=/home/patrick/code/alsa/alsa-driver/alsa  CPP="gcc -E" CC="gcc"
modules
make[1]: Entering directory '/usr/src/linux-headers-3.14-1-common'

  ERROR: Kernel configuration is invalid.
         include/generated/autoconf.h or include/config/auto.conf are
missing.
         Run 'make oldconfig && make prepare' on kernel src to fix it.


  WARNING: Symbol version dump
/usr/src/linux-headers-3.14-1-common/Module.symvers
           is missing; modules will have no dependencies and modversions.

find: `/usr/src/linux-headers-3.14-1-common/alsa-kernel/': No such file or
directory
find: `/usr/src/linux-headers-3.14-1-common/alsa-kernel/': No such file or
directory
find: `/usr/src/linux-headers-3.14-1-common/alsa-kernel/': No such file or
directory
  Building modules, stage 2.
/usr/src/linux-headers-3.14-1-common/scripts/Makefile.modpost:42:
include/config/auto.conf: No such file or directory
find: `/usr/src/linux-headers-3.14-1-common/alsa-kernel/': No such file or
directory
find: `/usr/src/linux-headers-3.14-1-common/alsa-kernel/': No such file or
directory
find: `/usr/src/linux-headers-3.14-1-common/alsa-kernel/': No such file or
directory
make[2]: *** No rule to make target 'include/config/auto.conf'.  Stop.
Makefile:1294: recipe for target 'modules' failed
make[1]: *** [modules] Error 2
make[1]: Leaving directory '/usr/src/linux-headers-3.14-1-common'
Makefile:167: recipe for target 'compile' failed
make: *** [compile] Error 2


> 1) four internal speaker and headphone
> 2) two internal speaker, headphone and external subwoofer
>
> Once you confirm the nodes of the speakers, subwooder
> You need to decide whether headphone share the volume controls with the
> speaker/subwoofer
>>

I have spent some time on this step already with 3.14.1

Is there a specific reason this process is not already scripted other than
no one has taken the time to do it?

Can we not create a test script that will run through all the logical
combinations and provide all the relevant info?


>> - I have found a couple of kernel bug reports  for other ASUS models
>> with
>> this chipset but they are both marked resolved. Should I open a new
>> ticket
>> ?
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=65091
>> https://bugzilla.kernel.org/show_bug.cgi?id=66271
>>
>> - I can hear static through the front speakers (with pulseaudio test)
>> if
>> I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
>> (Center/LFE) or vice versa with hdajackretask.
>>
>> Pin 0x16 does not appear to work at all.
>>
>> I see this output when I apply the config in hdajackretask.
>>
>> 0x12 0x90a60140
>> 0x14 0x99130110
>> 0x15 0x04211020
>> 0x16 0x99134111
>> 0x18 0x01a19840
>> 0x19 0x01014011
>> 0x1a 0x411111f0
>> 0x1b 0x411111f0
>> 0x1d 0x40c6852d
>> 0x1e 0x014b1180
>> 0x1f 0x411111f0
>> 1
>>
>>


--
Patrick Shirkey
Boost Hardware Ltd
