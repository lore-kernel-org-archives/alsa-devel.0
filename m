From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: Cross-compiling alsa-lib
Date: Thu, 23 Sep 2010 10:56:47 -0700
Message-ID: <AANLkTim3P20U5iy0980CP-8d-b49W+PdJ2qZ5F7Xh4FC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C9E74244C9
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 19:56:47 +0200 (CEST)
Received: by wwb28 with SMTP id 28so1896268wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2010 10:56:47 -0700 (PDT)
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
I am trying to cross-compile alsa-lib. As a result of building alsa-lib I
get libasound.so file. However, if I try using aplay or anything that uses
alsa I get:

ALSA lib conf.c:2700:(snd_config_hooks_
call) Cannot open shared library libasound_module_conf_pulse.so
ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL hw:0

I am not sure how to build libasound_module_conf_pulse.so. I see that the
code for this library is in the alsa-lib folder.

Thnak you
Ogi
