From: niteblade@gmx.net
Subject: Random controls with hda-intel
Date: Sun, 21 Sep 2008 13:10:20 +0200
Message-ID: <48D62B9C.8010003@gmx.net>
Reply-To: niteblade@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 464AA245F7
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Sep 2008 13:10:24 +0200 (CEST)
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

Hi guys,

This is a problem I already posted on alsa-users, but since the only
reply I got was a me-too, I'm posting here.

I have some problems with the snd-hda-intel driver. The mixer controls
seem to be unpredictably appearing and disappearing or changing type
(on/off-switch vs volume) from alsa-driver
version to version. In the current daily snapshot (12th Sept 2008) I
have no volume control at all. In the driver shipped with 2.6.25 kernel
at least I get a pcm volume control. Several driver versions ago (dont
remember the version number) I had a master volume control. Several
other controls seem to have no effect on anything.

When loading the snd-hda-intel driver, I get in my syslog:

 hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...

The alsa info script has uploaded my infos here:
http://www.alsa-project.org/db/?f=be535315befdb3dbb24430e90e46a7b4ed07a591

Any help is appreciated

Kai
