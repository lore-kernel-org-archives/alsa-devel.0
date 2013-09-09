From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: where to get snd_pcm_hardware info when usb audio
 device plug in?
Date: Mon, 09 Sep 2013 10:17:33 +0200
Message-ID: <522D841D.1050603@ladisch.de>
References: <CANudz+uTk+GDAj=NfHQ_6ZrL6=ZmWJfXAnwRqk7yHPr4s0Jg1A@mail.gmail.com>
 <521E07A1.5020807@ladisch.de>
 <CANudz+v219cxgAwo2RtAMvmvQ+18doPX0qsX4Pc+vk9TAe3D2g@mail.gmail.com>
 <CANudz+uu5XNL6-KgE4oTV_z=8qOUZh8ppNGznCYFBx3dGEzEZQ@mail.gmail.com>
 <522C6D74.9000208@ladisch.de>
 <CANudz+s_iQ9tQSEpk30FaeGPVVBy=u65nxxh230=aZkUg4369w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id A84252608D9
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 10:17:35 +0200 (CEST)
In-Reply-To: <CANudz+s_iQ9tQSEpk30FaeGPVVBy=u65nxxh230=aZkUg4369w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: loody <miloody@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

loody wrote:
>> How exactly did you compile and install alsa-lib?
>
> $ ./configure --prefix=/media/sdb1/software/linux.sound/alsa-lib-1.0.23.mips.clibc/build --host=mipsel-linux CC=mipsel-linux-gnu-gcc --disable-python

The --prefix option specifies where the files are on the target system.
You must not use it.


Regards,
Clemens
