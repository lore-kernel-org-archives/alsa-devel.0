From: Adish Kuvelker <adkuvi@gmail.com>
Subject: alsa-utils configuration query
Date: Tue, 29 Jun 2010 19:28:36 +0530
Message-ID: <AANLkTikIgwy6cRlcQrbBLAy0wiyOfvskyf7oPyxippQp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5944724680
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jun 2010 15:58:39 +0200 (CEST)
Received: by vws11 with SMTP id 11so4792303vws.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Jun 2010 06:58:37 -0700 (PDT)
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

Hello,

I am cross-compiling alsa-utils for my ARM target. I have successfully
configured and installed the alsa-lib (alsa-lib-1.0.16). Now to
configure the alsa-utils(alsa-utils-1.0.16) i pass the following
command

LD=arm-linux-ld ./configure --with-alsa-prefix=/usr/lib
--build=i686-linux --disable-nls

The libasound.la & libasound.a are present in the /usr/lib but the
above command gives an error

checking for snd_ctl_open in -lasound... no
configure: error: No linkable libasound was found

Can anyone give me a pointer of how to tackle this?

Regards;
Aadish
