From: "Max Klein" <mein_name@ist-einmalig.de>
Subject: alsa-driver cross compile problem - upgrading ALSA
Date: Fri, 29 Jun 2012 17:32:48 +0200
Message-ID: <20120629153248.29780@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id B1AB211CF8B
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 17:32:50 +0200 (CEST)
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

I am running 2.6.27 kernel on arm board with ALSA driver version 1.0.17 (cat /proc/asound/version) and I would like to update ALSA driver version to current 1.0.25.

I am trying to build alsa-drivers with "./configure --with-cross=arm-none-linux-gnueabi- --enable-dynamic-minors --with-debug=full --with-isapnp=no --with-oss=no --with-kernel=/data/src/kernel/linux-davinci --with-build=/data/src/kernel/linux-davinci --with-sequencer=no"

Afterwards I compile it via "make ARCH=arm" but this fails we the following error:

In file included from /data/VRM/davinci33/alsa-1.0.25/alsa-driver-1.0.25/acore/hrtimer.c:1:
/data/VRM/davinci33/alsa-1.0.25/alsa-driver-1.0.25/include/adriver.h:753: error: static declaration of 'jiffies_to_msecs' follows non-static declaration
include/linux/jiffies.h:286: error: previous declaration of 'jiffies_to_msecs' was here
/data/VRM/davinci33/alsa-1.0.25/alsa-driver-1.0.25/include/adriver.h:772: error: static declaration of 'msecs_to_jiffies' follows non-static declaration
include/linux/jiffies.h:288: error: previous declaration of 'msecs_to_jiffies' was here


Can someone please help me how to get ALSA upgraded on my platform? Obviously I am either doing something wrong when configuring or I am on the absolutely wrong way?

I am looking forward for any advice, thanks in advance!
-- 
NEU: FreePhone 3-fach-Flat mit kostenlosem Smartphone!                                  
Jetzt informieren: http://mobile.1und1.de/?ac=OM.PW.PW003K20328T7073a
