From: Mike Crowe <drmikecrowe@gmail.com>
Subject: Debugging custom driver: BUG: pcmC0D0c:0 error
Date: Thu, 19 May 2011 16:34:59 -0400
Message-ID: <BANLkTim3_eSbp1Ax9L8w8kEXQVvdtZ9q-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D73711037F5
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 22:35:44 +0200 (CEST)
Received: by vxi40 with SMTP id 40so2534523vxi.38
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 13:35:42 -0700 (PDT)
Received: by qwf7 with SMTP id 7so1669571qwf.38
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 13:35:19 -0700 (PDT)
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

Hi folks,

I'm digging into a custom, embedded ALSA driver for some hardware we are
developing.  The basic functionality (interfacing with an soc/wm8990 codec)
is working fine.

We have a new library that we are adding which interfaces with the system
via OSS.  In preparation, I built the vrec/vplay functions, which also use
OSS, and they work fine with the OSS Emulation layer of ALSA.

I have enabled verbose printk and debug messages, and am seeing the
following entries in the log file.  Since I did not have these enabled
before I started integrating, I'm not sure if this is new, or if they have
been there for a while.

Are these a problem, or can I ignore these?

ALSA sound/core/pcm_lib.c:318: BUG: pcmC0D0c:0, pos = 230989824, buffer size
= 12304, period size = 769

[ 2018.944000] ALSA sound/core/pcm_lib.c:318: BUG: pcmC0D0c:0, pos = 65536,
buffer size = 65536, period size = 4096
[ 2020.304000] ALSA sound/core/pcm_lib.c:318: BUG: pcmC0D0c:0, pos = 65536,
buffer size = 65536, period size = 4096
[ 2021.660000] ALSA sound/core/pcm_lib.c:318: BUG: pcmC0D0c:0, pos = 65536,
buffer size = 65536, period size = 4096

TIA
Mike
