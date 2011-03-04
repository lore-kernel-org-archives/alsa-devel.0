From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: 1.0.24 alsa-driver compilation problem
Date: Fri, 04 Mar 2011 11:07:22 +0100
Message-ID: <4D70B9DA.8070607@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout5.mailmx.agnat.pl
	[193.239.44.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 48507103994
	for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2011 11:46:37 +0100 (CET)
Received: from mailmxout4.mailmx.agnat.pl ([193.239.44.248]
	helo=mailmxout.mailmx.agnat.pl)
	by mailmxout.mailmx.agnat.pl with esmtp (Exim 4.72)
	(envelope-from <g.daniluk@elproma.com.pl>) id 1PvSRP-0007eO-74
	for alsa-devel@alsa-project.org; Fri, 04 Mar 2011 11:40:59 +0100
Received: from smtp.agnat.pl ([193.239.44.82])
	by mailmxout.mailmx.agnat.pl with esmtp (Exim 4.74)
	(envelope-from <g.daniluk@elproma.com.pl>) id 1PvRux-0003qN-BE
	for alsa-devel@alsa-project.org; Fri, 04 Mar 2011 11:07:27 +0100
Received: from [78.133.172.40] (helo=[192.168.1.79])
	by smtp.agnat.pl with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.71) (envelope-from <g.daniluk@elproma.com.pl>)
	id 1PvRux-0003kA-7I
	for alsa-devel@alsa-project.org; Fri, 04 Mar 2011 11:07:27 +0100
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
I'm trying to cross-compile the latest 1.0.24 alsa-driver for my 
embedded system (using SH4 processor and linux kernel 2.6.35). Before 
compiling 1.0.24 I did turn off the alsa in kernel configuration 
(leaving just Sound card support enabled). So I run as follows:
./configure --with-kernel=<where_my_kernel_src's_are> 
--with-build=<where_my_kernel_src's_are> --with-cross=sh4-linux-gnu-

and then 'make'. However, during 'make' I've noticed the following warning:

WARNING: "register_sound_special_device" 
[/root/alsa-driver-1.0.24/acore/snd.ko] undefined!
WARNING: "unregister_sound_special" 
[/root/alsa-driver-1.0.24/acore/snd.ko] undefined!

and then when trying to insmod the snd.ko module the following error 
appears:

snd: Unknown symbol unregister_sound_special (err 0)
snd: Unknown symbol register_sound_special_device (err 0)

thank you for your help,
best regards,
Greg
