From: andoru <andoru.blah@gmail.com>
Subject: Re:
	=?utf-8?q?Invalid_PCM_pointer_with_CMI8738_and_pcm?=
	=?utf-8?q?=2Ec_buffer=09underuns?=
Date: Sat, 5 Apr 2014 23:16:02 +0000 (UTC)
Message-ID: <loom.20140406T010044-863@post.gmane.org>
References: <loom.20140404T175952-945@post.gmane.org>
 <CAN8cciaF9ZbyOoz4A3f3GyTkmzzbvskFtqqKUv2rjgVAXbjCcQ@mail.gmail.com>
 <loom.20140405T202230-761@post.gmane.org>
 <CAN8ccia5hZi36dCaQ+pdSH7QaHzNopLKmcHbvK_Rfj93mgeQdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 014452651A0
 for <alsa-devel@alsa-project.org>; Sun,  6 Apr 2014 01:16:13 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WWZor-0000dy-7P
 for alsa-devel@alsa-project.org; Sun, 06 Apr 2014 01:16:13 +0200
Received: from cl-86-125-143-65.cablelink.mures.rdsnet.ro ([86.125.143.65])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 06 Apr 2014 01:16:13 +0200
Received: from andoru.blah by cl-86-125-143-65.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 06 Apr 2014 01:16:13 +0200
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

Raymond Yau <superquad.vortex2 <at> gmail.com> writes:


> http://www.alsa-project.org/main/index.php/XRUN_Debug
> 
> # Enable basic debugging and dump stack, check hardware pointer on the
> period update
> # Usefull to just see, if PCM stream is stopped for a reason (usually wrong
> audio process timing from scheduler)
> # And to check the values from driver
> 
> echo 11 > /proc/asound/card0/pcm0p/xrun_debug

Argh, seems the kernel I'm using doesn't have the debug options.
Any other ways around this?

> Check the system log whether the hwptr position are correct in first nine
> periods and xrun  occur on 10th period since the buffer contain 9.27
> periods when running vlc?

Which system log? Or maybe this is related to the above? I can't find
anything in any file under /var/log/ that contains anything you're talking
about. 
 
>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation
>/sound/alsa/CMIPCI.txt
> 
> cat /proc/asound/card0/cmipci
> 
> What is the model of your sound card ?

____________________________________________________
$ cat /proc/asound/card0/cmipci
C-Media CMI8738 (model 55) at 0xe000, irq 18

00: 02 00 01 00
04: d0 0d 00 00
08: 83 00 09 00
0c: 00 00 01 0a
10: c0 00 00 00
14: 00 60 c0 00
18: 00 01 80 0e
1c: 00 00 ee ee
20: 10 40 f9 00
24: 8f ff ff 06
90: 20 09 00 00
____________________________________________________


> Does it support 4 and 6 channels in windows ?

6 channels. I don't use more than 2 channels anyway.
