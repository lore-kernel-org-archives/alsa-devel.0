From: Shayne O'Connor <forums@machinehasnoagenda.com>
Subject: Re: [PATCH 0/8] emu10k1 multichannel support
Date: Wed, 16 Feb 2005 18:31:59 +1100
Message-ID: <4212F6EF.1040306@machinehasnoagenda.com>
References: <1108514291.3772.19.camel@krustophenia.net>	 <42129C4F.4060507@machinehasnoagenda.com>	 <1108515965.14789.1.camel@krustophenia.net>	 <4212D49F.40404@machinehasnoagenda.com> <1108530906.26851.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108530906.26851.2.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Wed, 2005-02-16 at 16:05 +1100, Shayne O'Connor wrote:
>  
>
>>ok, i got the patches applied, but ... i have no idea how to compile
>>this - all i know is that it obviously isn't the standard build
>>procedure for a source package, and i've only been able to find
>>references to people having troubles compiling cvs, not *how* to compile
>>cvs ... the furthest i got (running whatever scripts looked appropriate)
>>was it asking for me to specify the ALSAKERNELDIR variable ... how do i
>>do that, and where should i point it (/lib/modules/'uname -r'/build/?)?
>>    
>>
>
>I am pretty sure I have posted this before.  But, here's the procedure:
>
>checkout CVS sources
>cd to directory where you checked out
>run "./build prep"
>cd alsa-driver
>run "./configure --with-cards=emu10k1
>--with-kernel=/path/to/kernel/source"
>run "make; make install"
>
>So you just replace /path/to/kernel/source with wherever your kernel
>source is.
>
>Lee
>
>  
>
maybe there's new problems with cvs - followed directions, and this is
what i got during "make" (output starting from where it started
producing errors):

> make[1]: Entering directory
> `/lib/modules/2.6.10-0.6.rdt.rhfc2.ccrma/build'
>   CC [M]  /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.o
> In file included from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/core.h:29,
>                  from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:28:
> include/linux/pm.h:198: error: redefinition of `pm_message_t'
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/adriver.h:717:
> error: `pm_message_t' previously declared here
> In file included from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/core.h:29,
>                  from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:28:
> include/linux/pm.h:218:1: warning: "PMSG_FREEZE" redefined
> In file included from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/driver.h:42,
>                  from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:22:
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/adriver.h:718:1:
> warning: this is the location of the previous definition
> In file included from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/core.h:29,
>                  from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:28:
> include/linux/pm.h:219:1: warning: "PMSG_SUSPEND" redefined
> In file included from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/driver.h:42,
>                  from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:22:
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/adriver.h:719:1:
> warning: this is the location of the previous definition
> In file included from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/core.h:29,
>                  from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:28:
> include/linux/pm.h:220:1: warning: "PMSG_ON" redefined
> In file included from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/driver.h:42,
>                  from
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:22:
> /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/adriver.h:720:1:
> warning: this is the location of the previous definition
> make[4]: ***
> [/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.o] Error 1
> make[3]: *** [/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore]
> Error 2
> make[2]: ***
> [_module_/home/mrmachine/linux-progz/cvs/alsa/alsa-driver] Error 2
> make[1]: *** [modules] Error 2
> make[1]: Leaving directory `/lib/modules/2.6.10-0.6.rdt.rhfc2.ccrma/build'
> make: *** [compile] Error 2



shayne


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
