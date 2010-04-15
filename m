From: "Dark.@ Zzz" <darkclip@gmail.com>
Subject: Defect Patch File for AD1981HD
Date: Fri, 16 Apr 2010 04:48:46 +0800
Message-ID: <j2h583116371004151348ha86618e0j8e44c6310a1d258d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id ED6B72415F
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Apr 2010 22:48:48 +0200 (CEST)
Received: by vws15 with SMTP id 15so546960vws.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2010 13:48:46 -0700 (PDT)
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

Hi guys, I don't know if it's the right place to send a mail, but a
little defect in one of the driver patch files is bothering me for a
long time.

The patch file is for analog device (hda-intel, patch_analog.c), under
the section of Patch for HP nx6320, the author took out the mic/line
loopback contorl part: "#if 0  FIXME: analog mic/line loopback doesn't
work with my tests...  #endif". However I accidentally found out that
the original code for loopback contorl is actually working perfectly.

The thing is I need to listen to mic loopback all the time when I need
to record something. So every time I update my kernel I need to
download the newest alsa driver, modify then compile it by myself. I
don't know if others noticed it, but since the mic loopback contorl
section is functional, I'm thinking maybe some of you can do something
about the source code.

Thank You!

Dark.@Zzz
