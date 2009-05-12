From: =?iso-8859-1?Q?Kristoffer_Grundstr=F6m?= <khisbra@hotmail.com>
Subject: aplay as a Zombie shows up in systemsupervisor when
 starting Totem or Totem-xine.
Date: Wed, 13 May 2009 00:42:25 +0200
Message-ID: <COL104-W201E055126ECF3C99CE1E7A7600@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc3-s13.col0.hotmail.com (col0-omc3-s13.col0.hotmail.com
	[65.55.34.151]) by alsa0.perex.cz (Postfix) with ESMTP id A6A3A103882
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 00:42:27 +0200 (CEST)
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


I think I've identified the issue with my sound as aplay being a Zombie everytime I'm starting totem or totem-xine.

When restarting ALSA with service alsa restart as root I get what's shown in this link:

http://pastebin.mandriva.com/11255

3319 is Pulseaudio.

Pulseaudio disappears when closing totem or totem-xine.

This problem has to do with my earlier mentioned bugreport in this link: https://qa.mandriva.com/show_bug.cgi?id=49048

Thank you.

/Kristoffer
