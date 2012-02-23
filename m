From: Kevin Hilman <khilman@ti.com>
Subject: HDA intel, wired headset w/mic, jack mic detect
Date: Thu, 23 Feb 2012 11:09:20 -0800
Message-ID: <87ehtlwen3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 713202436C
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 20:09:22 +0100 (CET)
Received: by mail-pz0-f51.google.com with SMTP id y9so1406669dad.10
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 11:09:07 -0800 (PST)
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

I'm trying to get a wired headset with a mic working on MacBookAir
running v3.0 (3.0.0-13-generic from Ubuntu to be precise.)

It has Intel HDA audio[1] and everything works fine, including the
built-in mic.  The only think I can't seem to get working is a headset
w/mic.

I know the HW for dynamic detect works because the mic is detected
dynamically under OSX.  Is there some setting I need to tweak in order
to enable the automatic mic detection?

Thanks for any pointers,

Kevin

[1] $ cat /proc/asound/cards
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                     HDA Intel PCH at 0xa0600000 irq 46
