From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Mixing.
Date: Sat, 28 Jul 2007 16:34:17 +0300
Message-ID: <200707281634.17222.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 51F8C1037F5
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Jul 2007 15:33:45 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so821314ugf
	for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2007 06:33:44 -0700 (PDT)
Content-Disposition: inline
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

Hi 2 all.

I've just read many discussions about kernelspace and userspace sound mixing. 
Both sides have their arguments, etc. But why not to implement both? If you 
don't want to rewrite something there's easy way: just create a driver for 
dummy sound card, that will perform kernelspace mixing and will use default 
sound card for sound output. Kernelspace mixing will be very usefull for 
example for oss kernelspace oss emulation (as you know, userspace one doesn't 
work for huge amount of apps), or for dumb apps, that open hw:0 device for 
sound and have no option to change output device. Please, think about your 
users ;) Let them decide which mixing they wants

Cheers,
Vasily.
