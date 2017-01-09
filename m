From: Mark Brand <mark.brand@nmmu.ac.za>
Subject: Building a new out-of-tree ALSA module on Ubuntu
 Xenial (was gitcompile fail)
Date: Mon, 9 Jan 2017 16:51:44 +0200
Message-ID: <2915d595-0b62-fc12-3a62-5f719b49860d@nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from securemail-pl-omx10.synaq.com (securemail-pl-omx10.synaq.com
 [196.35.198.100])
 by alsa0.perex.cz (Postfix) with ESMTP id B89EF266D40
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 15:51:58 +0100 (CET)
Received: from [197.88.122.75] (helo=[192.168.1.99])
 by securemail-pl-omx10.synaq.com with esmtpa (Exim 4.63)
 (envelope-from <mark.brand@nmmu.ac.za>) id 1cQbIZ-0001pl-8L
 for alsa-devel@alsa-project.org; Mon, 09 Jan 2017 16:51:47 +0200
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

Hi all

My abundant thanks to Clemens and Takashi for your kind and patient 
assistance.  May I now answer my own question by offering the following 
step-by-step procedure in case anyone comes looking for it?  Any 
improvements or suggestions would be greatly appreciated too, thank you.

$ sudo apt-get install linux-headers-$(uname -r)
$ sudo mkdir /lib/modules/$(uname -r)/updates
$ sudo apt-get build-dep linux-image-$(uname -r)
$ mkdir $HOME/src; cd $HOME/src
$ apt-get source linux-image-$(uname -r)
$ cd linux-$(uname -r | awk -F - '{print $1}')

Now I am at the root of the kernel source tree.  In my case, I want to 
add a new driver for an as-yet unsupported device.  I find a supported 
device that appears substantially similar to what I need 
(sound/drivers/mtpav.c) and base my hack on that - producing 
sound/drivers/mq8portse.c.  I then add the following lines to the 
sound/drivers/Makefile (each mirroring entries found in respect of mtpav.c)

snd-mq8portse-objs := mq8portse.o

obj-$(CONFIG_SND_MQ8PORTSE) += snd-mq8portse.o

Now (from the root of the kernel source tree):

$ cd sound/drivers/
$ CONFIG_SND_MQ8PORTSE=m make -C /lib/modules/$(uname -r)/build M=$(pwd) 
snd-mq8portse.ko

This produces my module in the same folder, which I copy to the updates 
folder.

$ sudo cp snd-mq8portse.ko /lib/modules/$(uname -r)/updates/
$ sudo depmod -a

Now, because my particular device is attached to the LPT port, I need to 
unload the lp driver before snd-mq8portse will load.
$ sudo modprobe -r lp
$ sudo modprobe snd-mq8portse
$ modinfo snd-mq8portse

I try it out in my ALSA client ... then remove ...

$ sudo modprobe -r snd-mq8portse

The MusicQuest 8Port/SE is attached to the LPT port, so a more permanent 
setup requires that I blacklist all typical parport stuff.  I add the 
following as /etc/modprobe.d/blacklist-parport.conf:

# keep LPT port open for mq8portse
alias parport_pc off
alias parport off

blacklist parport_pc
blacklist parport
blacklist ppdev
blacklist lp

I also comment out autoloading of lp in /etc/modules.  I can then add 
mq8portse to /etc/modules for automatic loading, unless I want to defer 
to manual modprobe-ing.

Once again, thank you ever so much, one and all.  Next I need to find 
out how to submit this driver for inclusion in ALSA.

*Mark Brand*
Lecturer in Music Technology
School of Music, Art & Design
Summerstrand Campus (South)
Tel: +27 (0)41 5042250
Fax: +27 (0)41 5042507
