From: =?ISO-8859-15?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: Re: are the alsa wiki instructions for mercurial
	correct?
Date: Thu, 22 Feb 2007 10:11:33 +0100
Message-ID: <45DD5E45.6090107@ingomueller.net>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8A2@sea-exch-01.na.corp.dmxmusic.com>
	<1172110844.3728.1.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1172110844.3728.1.camel@razman.gruemaster.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Tobin Davis schrieb:
> use http://hg.alsa-project.org/alsa-driver and
> http://hg.alsa-project.org/alsa-kernel.
> 
> The wiki is wrong (and hasn't been updated).
> 
> Tobin
> 

It'd be GREAT if you could bring it up-to-date! I can't do it because I
simply don't now how it works. Thanks in advance...

Regards, Ingo


> On Wed, 2007-02-21 at 17:13 -0800, John Utz wrote:
> 
>> i executed the following steps from the wiki:
>>
>> # Get a copy of the repository
>> cd alsa-hg
>>
>> hg clone http://hg-mirror.alsa-project.org/alsa-driver alsa-driver
>> hg clone http://hg-mirror.alsa-project.org/alsa-kernel alsa-kernel
>>
>> # Get latest
>>
>> cd alsa-driver
>> hg pull -u
>>
>> cd alsa-kernel
>> hg pull -u
>>
>> # Create a working copy
>> hg clone alsa-driver alsa-driver-fixbug1
>> cd alsa-driver-fixbug1
>>
>>
>>
>> However, all that i seem to be pulling down is the stub file and not
>> the real iplementations
>>
>> ie:
>>
>> [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} \;
>> -rw-r--r-- 1 jutz jutz 74 Feb 21
>> 17:07 ./alsa-driver/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21
>> 17:17 ./alsa-driver-2908/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21
>> 17:13 ./alsa-kernel-2908/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21
>> 17:07 ./alsa-kernel/pci/ac97/ac97_patch.c
>>
>>
>> these are just the files that include the 'real' implementations:
>>
>> [jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c
>> #define __NO_VERSION__
>> #include "../../alsa-kernel/pci/ac97/ac97_patch.c"
>>
>>
>> am i doing something wrong or is mercurial missing some stuff?


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
