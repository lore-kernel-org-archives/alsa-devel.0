From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA lib pcm.c:2175 snd_pcm_open_conf) symbol
 _snd_pcm_plug_open is not defined inside [builtin]
Date: Wed, 08 Sep 2010 09:51:41 +0200
Message-ID: <4C87408D.9090400@ladisch.de>
References: <AANLkTinE54u1aq7bNqgLxsVjuqeb95ctfvbDn5hPQpM-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 62E39243BC
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 09:51:16 +0200 (CEST)
In-Reply-To: <AANLkTinE54u1aq7bNqgLxsVjuqeb95ctfvbDn5hPQpM-@mail.gmail.com>
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

asim khan wrote:
> I have enabled  --with-pcm-plugins  option in my configure script which will
> select all pcm-plugins
> #!/bin/sh
> ./configure CC=arm_v7_vfp_le-gcc --target=arm-linux --host=i386-linux
> --build=$BUILD --enable-static  --enable-pcm --with-pcm-plugins
> --disable-debug --disable-python --prefix=/mtd_rwarea

This is the same as --with-pcm-plugins="".

Use "--with-pcm-plugins=all", leave it as the default.


Regards,
Clemens
