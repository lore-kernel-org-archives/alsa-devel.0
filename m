From: loody <miloody@gmail.com>
Subject: Re: where to get snd_pcm_hardware info when usb audio
 device plug in?
Date: Sun, 8 Sep 2013 16:25:55 +0800
Message-ID: <CANudz+uu5XNL6-KgE4oTV_z=8qOUZh8ppNGznCYFBx3dGEzEZQ@mail.gmail.com>
References: <CANudz+uTk+GDAj=NfHQ_6ZrL6=ZmWJfXAnwRqk7yHPr4s0Jg1A@mail.gmail.com>
 <521E07A1.5020807@ladisch.de>
 <CANudz+v219cxgAwo2RtAMvmvQ+18doPX0qsX4Pc+vk9TAe3D2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E750261684
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2013 10:25:56 +0200 (CEST)
Received: by mail-wi0-f179.google.com with SMTP id hm2so2314381wib.6
 for <alsa-devel@alsa-project.org>; Sun, 08 Sep 2013 01:25:56 -0700 (PDT)
In-Reply-To: <CANudz+v219cxgAwo2RtAMvmvQ+18doPX0qsX4Pc+vk9TAe3D2g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi Clements and all:

2013/8/29 loody <miloody@gmail.com>:
> hi clements:
>
> 2013/8/28 Clemens Ladisch <clemens@ladisch.de>:
>> loody wrote:
>>> is it possible to get snd_pcm_hardware information in /proc, /sys or
>>> anywhere when usb audio device plug in?
>>>
>>> if no, is there api I can take in usermode to get snd_pcm_hardware of
>>> this usb audio device?
>>
>> Something like this?
>> http://download.atmark-techno.com/misc/demos/usb-audio-a500-howto/hw_params.c
> I download the file and
> 1. cross-compile it with alsa-lib-1.0.23
>
> but I get below message
> # ./hw_params
> no soundcards found...no soundcards found...
Sorry, it is my fault :)
I didn't create /dev/snd/xxxx nodes for hw_params to access.

after creating /dev/snd/xxx nodes, I get another problem.
hw_params will try to access alsa.conf, which is located my host machine.

# ./hw_params
PLAYBACK
ALSA lib conf.c:3601:(snd_config_update_r) Cannot access file
/media/sdb1/software/linux.sound/alsa-lib-1.0.23.mips.clibc/build/share/alsa/alsa.conf
ALSA lib control.c:902:(snd_ctl_open_noupdate) Invalid CTL hw:0
control open (0): No such file or directoryCAPTURE
ALSA lib conf.c:3601:(snd_config_update_r) Cannot access file
/media/sdb1/software/linux.sound/alsa-lib-1.0.23.mips.clibc/build/share/alsa/alsa.conf
ALSA lib control.c:902:(snd_ctl_open_noupdate) Invalid CTL hw:0
control open (0): No such file or directory/
#

Except create the same location on target board, is there any compile
option I can use to change the path of alsa.conf for hw_params to look
for?

appreciate your help,
