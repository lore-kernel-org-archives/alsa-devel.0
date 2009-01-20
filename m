From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: usr/include/linux/soundcard.h warnings for 'make headers_check'
Date: Tue, 20 Jan 2009 21:08:22 +0530
Message-ID: <1232465902.3088.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763272AbZATX2v@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

usr/include/linux/soundcard.h is giving following warnings for 'make headers_check':
 usr/include/linux/soundcard.h:1047: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1048: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1049: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1050: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1051: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1053: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1055: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1056: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1061: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1062: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1078: extern's make no sense in userspace
 usr/include/linux/soundcard.h:1079: extern's make no sense in userspace

Do we need to fix these warnings.

If yes, then how can we fix these warnings.

Thanks

--
JSR
