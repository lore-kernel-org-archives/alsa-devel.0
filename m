From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA lib pcm.c:2175 snd_pcm_open_conf) symbol
 _snd_pcm_plug_open is not defined inside [builtin]
Date: Wed, 08 Sep 2010 07:51:23 +0200
Message-ID: <4C87245B.1090305@ladisch.de>
References: <AANLkTimybMC1f_eB04G0-WeOoCapKBeeKGR7wXO3GxWm@mail.gmail.com>	<4C861FCB.3080502@ladisch.de>
	<AANLkTinUwv_=sTQyKQT89SMZyUxNzDKvwZ0NuokGBwnL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1D6C2103858
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 07:50:57 +0200 (CEST)
In-Reply-To: <AANLkTinUwv_=sTQyKQT89SMZyUxNzDKvwZ0NuokGBwnL@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: asim khan <khan.asim.2009@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

asim khan wrote:
> ./configure CC=arm_v7_vfp_le-gcc --target=arm-linux --host=i386-linux
> --with-pcm-plugins=dmix --with-pcm-plugins=dsnoop --with-pcm-plugins=plug
> --with-pcm-plugins=softvol --with-pcm-plugins=asym --build=$BUILD
> --enable-static  --enable-static --disable-debug --disable-python
> --prefix=/mtd_rwarea.

--with-pcm-plugins=dmix,dsnoop,plug,softvol,asym


Regards,
Clemens
