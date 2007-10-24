From: Tharmarajan G <tharma@e-consystems.com>
Subject: Re: aplay appication failed to open the alsa device
Date: Wed, 24 Oct 2007 15:19:47 +0530
Message-ID: <1193219387.2827.47.camel@tharma.e-con>
References: <1193200898.2827.18.camel@tharma.e-con>
	<1193207047.11987.1217520753@webmail.messagingengine.com>
Reply-To: tharma@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms1.worldwebleaders.com (ms1.worldwebleaders.com [69.50.223.62])
	by alsa0.perex.cz (Postfix) with ESMTP id 16E1C2433B
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Oct 2007 11:50:29 +0200 (CEST)
In-Reply-To: <1193207047.11987.1217520753@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org, maharajan <maharajan@e-consystems.com>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Thanks for your reply. Still the problem is not solved.

I have downloaded the followings packages from the site
www.alsa-project.org   and built them for arm.

1. alsa-lib-1.0.14

2. alsa-utils-1.0.14


Configuring and Building instructions

pwd

/home/tharma/alsa-packages

cd alsa-lib-1.0.14

./configure --host=arm-linux --prefix=$PWD/install
CROSS_COMPILE=arm-linux-

make 

make install

cd ../alsa-utils-1.0.14

./configure --host=arm-linux --prefix=$PWD/install
CROSS_COMPILE=arm-linux
CFLAGS=-I/home/tharma/alsa-packages/alsa-lib-1.0.14/install/include
LDFLAGS=-I/home/tharma/alsa-packages/alsa-lib-1.0.14/install/lib

make 
make install


	I have got the share/alsa directory in the alsa-lib package. I have
downoaded this diretory to the /usr/share/ path in my target board. But
still the aplay application fails to open the alsa device.



Regards,
Tharmarajan G




On Wed, 2007-10-24 at 08:24 +0200, Clemens Ladisch wrote: 
> Tharmarajan G wrote:
> > 	I have built the kernel image with ALSA audio support and the
> > applications aplay and arecord for playing and recording audio data
> > using ALSA api.
> > 
> > 	I have got the alsa related entries in the /proc filesystem . But when
> > playing the aplay, it failed to open the device.
> > 
> > [root@SIRIUS /flash2]#./aplay /usr/local/Songs/AjRaj-Anthimanthirai-Theme4.mp3
> > ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
> 
> Apparently, alsa-lib's .conf files are not installed in /usr/share/alsa/.
> 
> 
> HTH
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
