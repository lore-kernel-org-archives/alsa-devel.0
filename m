From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: gitcompile fail
Date: Sun, 8 Jan 2017 08:25:48 +0900
Message-ID: <81488170-fc82-0863-a77d-354fb96502f8@sakamocchi.jp>
References: <bf26b6bb-6447-8ec9-bacf-9954a4b924e5@nmmu.ac.za>
 <a5d5a532-c63c-f9a2-5bd5-e9cefbb3d056@nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C8ABD266BF2
 for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2017 00:25:55 +0100 (CET)
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
To: Mark Brand <mark.brand@nmmu.ac.za>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

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
