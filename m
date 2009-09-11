From: Orm Finnendahl <o.finnendahl@mh-freiburg.de>
Subject: hda-intel missing mixer channels
Date: Fri, 11 Sep 2009 21:02:48 +0200
Message-ID: <20090911190248.GG19531@varese>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mh-freiburg.de (mail.mh-freiburg.de [193.197.131.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D78724752
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 21:02:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.mh-freiburg.de (Postfix) with ESMTP id 8AEBCF0F49
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 21:02:48 +0200 (CEST)
Received: from inm.mh-freiburg.de (unknown [192.168.242.2])
	by mail.mh-freiburg.de (Postfix) with ESMTP id 71C6EF0941
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 21:02:48 +0200 (CEST)
Received: from orm by grisey with local (masqmail 0.2.21) id
	1MmBOS-1Ox-00 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2009
	21:02:48 +0200
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

Hi,

I sent this to alsa-user a week ago but didn't get any reply. Does
anybody know, who is responsible for the missing faders? Did the
driver change or is it some module loading mechanism in the distro
which prevents the faders from showing up in alsamixer? This is so
strange. Please help!

--
Orm
--------------------------------------------------------------------
Hi everybody,

 after the last update of Ubuntu (intrepid to jaunty) on my Lenovo
Ideapad my microphone input doesn't work anymore (neither internal nor
external). I found out that alsamixer lacks quite a lot of faders in
the newer kernel/module compared to the older one. Some of the faders
now unavailable were crucial for Mic input to work on the older system
so I'd very much like to get them back ;-)

Some more infos: 

Soundcard:    Intel 82801G (ICH7 Family)
Chip:         Realtek ALC269
Module:       snd_hda_intel (in both kernels)

Older kernel: Ubuntu stock 2.6.27-14-generic
Newer kernel: Ubuntu stock 2.6.28-13-rt

Is there any way to make the missing controls available or did the
driver change and I have to compile the older driver for the new
kernel?

Yours,
Orm
