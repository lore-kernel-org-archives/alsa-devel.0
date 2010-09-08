From: asim khan <khan.asim.2009@gmail.com>
Subject: (no subject)
Date: Wed, 8 Sep 2010 12:55:46 +0530
Message-ID: <AANLkTimpjDn89D1qkS3vpf00JODjyFF4+w-=R6GDBi5m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 50A0424383
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 09:25:51 +0200 (CEST)
Received: by pzk5 with SMTP id 5so2587289pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 00:25:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
 Iam using alsa lib version 1.0.22..and Iam running an alsa capture
application.
 if Iam running this standalone application on my arm11 target ..it runs
fine
but when iam runnig this with my complete BD player integrated application
it gives an error
ALSA lib pcm.c:2175 snd_pcm_open_conf) symbol _snd_pcm_plug_open is not
defined inside [builtin]
cannot open audio device plughw:0,0 (No such device or address).

I googled Which explained the errors meant I didn't have the Alsa plugins
set via ALSA_PCM_PLUGINS in make.conf

I have enabled  --with-pcm-plugins  option in my configure script which will
select all pcm-plugins
#!/bin/sh
./configure CC=arm_v7_vfp_le-gcc --target=arm-linux --host=i386-linux
--build=$BUILD --enable-static  --enable-pcm --with-pcm-plugins
--disable-debug --disable-python --prefix=/mtd_rwarea

I have checked using pcm plugins the created library(.so,.a) size is
reduced...
                              but still Iam getting above same error *ALSA
lib pcm.c:2175 snd_pcm_open_conf) symbol _snd_pcm_plug_open is not defined
inside [builtin]*
**
Please let me know is there any other thing i can check to solve this
problem

---Thanks
Asim
*

*
