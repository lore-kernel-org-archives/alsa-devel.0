From: Mark Brand <mark.brand@nmmu.ac.za>
Subject: Re: gitcompile fail
Date: Sun, 8 Jan 2017 17:19:15 +0200
Message-ID: <12c78c97-64ee-60ab-d4f3-3523b4d33e31@nmmu.ac.za>
References: <bf26b6bb-6447-8ec9-bacf-9954a4b924e5@nmmu.ac.za>
 <a5d5a532-c63c-f9a2-5bd5-e9cefbb3d056@nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from securemail-pl-omx10.synaq.com (securemail-pl-omx10.synaq.com
 [196.35.198.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B34426669C
 for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2017 16:19:28 +0100 (CET)
Received: from [197.83.213.47] (helo=[192.168.1.99])
 by securemail-pl-omx10.synaq.com with esmtpa (Exim 4.63)
 (envelope-from <mark.brand@nmmu.ac.za>) id 1cQFFi-0002ZX-1F
 for alsa-devel@alsa-project.org; Sun, 08 Jan 2017 17:19:22 +0200
In-Reply-To: <a5d5a532-c63c-f9a2-5bd5-e9cefbb3d056@nmmu.ac.za>
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

Hi Takashi (and all)

This is brilliant, perfect, thank you!  And thank you sincerely for 
taking the time to put these instructions together for me.  I am 
embarrassed to say that I need a little more help.  I am using the 
official Ubuntu linux-4.4.0 source tree (copied to my $HOME/Projects 
folder), with appropriate config obtained from "make oldconfig". Your 
instructions:

(Current working directory is top level of kernel source tree) - 
($HOME/Projects/linux-4.4.0)
$ cd sound/drivers/
$ make -C /lib/modules/4.4.0-57-lowlatency/build M=$(pwd) snd-mtpav.ko

This produces snd-mtpav.ko perfectly as expected.  Now I want to compile 
my own module called snd-mq8portse.ko (which is a device substantially 
similar to the mtpav).  I have successfully built this working driver in 
the past, but under an older build arrangement (which stopped working at 
some point).  I add my source file (mq8portse.c) to 
$HOME/Projects/linux-4.4.0/sound/drivers, and make the following 
additions to the Makefile in that folder:

snd-mq8portse-objs := mq8portse.o

obj-$(CONFIG_SND_MQ8PORTSE) += snd-mq8portse.o

I also make the following addition to Kconfig in the same folder (again 
following the model provided by SND_MTPAV):

config SND_MQ8PORTSE
     tristate "MusicQuest 8Port/SE multiport MIDI"
     select SND_RAWMIDI
     help
       To use a MusicQuest 8Port/SE multiport MIDI adapter
       connected to the parallel port, say Y here and make sure that
       the standard parallel port driver isn't used for the port.

       To compile this driver as a module, choose M here: the module
       will be called snd-mq8portse.

I now enable my new module for compilation by make menuconfig in the 
source tree root.  This adds the line CONFIG_SND_MQ8PORTSE=m to .config 
in that folder.
Now I try to compile my new module:

$ cd sound/drivers/
$ make -C /lib/modules/4.4.0-57-lowlatency/build M=$(pwd) snd-mq8portse.ko

I get:

make: Entering directory '/usr/src/linux-headers-4.4.0-57-lowlatency'
make[1]: *** No rule to make target 'snd-mq8portse.o'. Stop.
Makefile:1590: recipe for target 'snd-mq8portse.ko' failed
make: *** [snd-mq8portse.ko] Error 2
make: Leaving directory '/usr/src/linux-headers-4.4.0-57-lowlatency'

So my question is this: how (or where) do I add rules to make my 
module?  Am I modifying the correct Makefile/Kconfig/.config?  Is there 
some other step I'm missing?

Once again, I apologise sincerely for all the chatter, and thank you for 
your patience.

Kind regards
Mark Brand
________________________________________
From: Takashi Sakamoto [o-takashi@sakamocchi.jp]
Sent: Sunday, January 08, 2017 1:25 AM
To: Brand, Mark (Mr) (Summerstrand Campus South); 
alsa-devel@alsa-project.org
Subject: Re: gitcompile fail

Hi,

On Jan 7 2016 23:14, Mark Brand wrote:
 > Thank you sincerely for your response, Clemens.
 >
 > Please forgive my noobness, but is a full kernel compilation necessary?
 > I'm running Ubuntu 16.04 with 4.4.0-57-lowlatency kernel and my module
 > is closely based on the existing mtpav driver.  I believe I know where
 > to place my source file, and what modifications to make to the
 > appropriate Kconfig and Makefile.  I recall being able to specify which
 > modules I wanted to compile in arguments to ./configure (followed by
 > make modules), but I don't see that option anymore.  Please, could
 > someone point me in the direction of a valid, step-by-step procedure?
 > Every set of instructions that I've been able to find seems to now be
 > out of date.

I use Ubuntu in my development for out-of-tree sources of ALSA firewire
stack[0].

Roughly, you don't necessarily compile a full kernel just for a few
modules, because kernel supports out-of-tree build for such modules. In
Ubuntu, 'linux-headers-xxx' package is available to build the modules
for installed kernel. In your case, it's
'linux-headers-4.4.0-57-lowlatency' package[1].

When installing this package, you can see
'/lib/modules/4.4.0-57-lowlatency/build'[2]. In each directory of kernel
source, you can build modules just included in the directory. In your case:
(Current working directory is top level of kernel source tree)
$ cd sound/drivers/
$ make -C /lib/modules/4.4.0-57-lowlatency/build M=$(pwd) snd-mtpav.ko

Of course, packages related to kernel build should be installed, for
example, installing 'kernel-package' meta package.

When success to build, you can see 'snd-mtpav.ko' in the directory.
Next, you need to put the module into a correct path for module seeking.
In rough way, replace
'/lib/modules/4.8.0-32-generic/kernel/sound/drivers/snd-mtpav.ko' with
it. The, execute 'depmod -a' to generate the latest dependency and
mapping file of installed modules.

But I don't recommend the replacement, because the original module comes
from 'linux-image-extra-4.8.0-32-generic' in Ubuntu official repository.
This way confuses package manager a bit. Therefore, it's better to make
'/lib/modules/4.8.0-32-generic/updates' directory and put the new module
into it. I don't know the reason but this directory has priority for
module seeking to the original one.

Finally, you can load the new module. It's better to check that output
of modinfo includes the new path for the module. This is a sample of my
case.

$ modinfo snd-firewire-motu
filename:
/lib/modules/4.8.0-32-generic/updates/dkms/snd-firewire-motu.ko
...

If you get used to these instructions, please investigate to apply
DKMS[3]. It will strongly help this kind of your work.

[0] https://github.com/takaswie/snd-firewire-improve
[1] http://packages.ubuntu.com/xenial/linux-headers-4.4.0-57-lowlatency
[2] as a symbolic link to '/usr/src/linux-headers-4.8.0-32-generic/'.
[3] https://github.com/dell/dkms


Regards

Takashi Sakamoto
