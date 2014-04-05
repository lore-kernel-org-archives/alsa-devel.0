From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Sun, 6 Apr 2014 05:55:31 +0800
Message-ID: <CAN8ccia5hZi36dCaQ+pdSH7QaHzNopLKmcHbvK_Rfj93mgeQdA@mail.gmail.com>
References: <loom.20140404T175952-945@post.gmane.org>
 <CAN8cciaF9ZbyOoz4A3f3GyTkmzzbvskFtqqKUv2rjgVAXbjCcQ@mail.gmail.com>
 <loom.20140405T202230-761@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
 [209.85.192.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 45898265166
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 23:55:32 +0200 (CEST)
Received: by mail-qg0-f49.google.com with SMTP id 63so1731028qgz.8
 for <alsa-devel@alsa-project.org>; Sat, 05 Apr 2014 14:55:31 -0700 (PDT)
In-Reply-To: <loom.20140405T202230-761@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: andoru <andoru.blah@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >
> > does the hardware really support (16384/1764)
> > 9.27 periods?
> > does the error occur in the last period ?
>
> I have no idea, how do I find out? What last period?

http://www.alsa-project.org/main/index.php/XRUN_Debug

# Enable basic debugging and dump stack, check hardware pointer on the
period update
# Usefull to just see, if PCM stream is stopped for a reason (usually wrong
audio process timing from scheduler)
# And to check the values from driver

echo 11 > /proc/asound/card0/pcm0p/xrun_debug

Check the system log whether the hwptr position are correct in first nine
periods and xrun  occur on 10th period since the buffer contain 9.27
periods when running vlc?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/CMIPCI.txt

cat /proc/asound/card0/cmipci

What is the model of your sound card ?

Does it support 4 and 6 channels in windows ?
