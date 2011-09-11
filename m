From: gmane@colin.guthr.ie
Subject: Allow alsa configuration to be loaded from a
	alsa.conf.d folder
Date: Sun, 11 Sep 2011 13:40:37 +0100
Message-ID: <1315744838-21911-1-git-send-email-gmane@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id 305F124703
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Sep 2011 14:40:49 +0200 (CEST)
Received: from localhost (summit.brent.tribalogic.net [127.0.0.1])
	by summit.brent.tribalogic.net (Postfix) with ESMTP id 0ABF710B0FC
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2011 13:40:48 +0100 (BST)
Received: from summit.brent.tribalogic.net ([127.0.0.1])
	by localhost (summit.brent.tribalogic.net [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id vZw3n4zq-hPZ for <alsa-devel@alsa-project.org>;
	Sun, 11 Sep 2011 13:40:47 +0100 (BST)
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

This is a small patch for alsa-lib that supports the common ".d" folder
configs.

The idea here is to make it easier for packagers and distros to supply
plugin configuration without having to patch alsa-lib to do so (or
by managing a /etc/asound.conf file which may want to be tweaked by multiple
files)

If this patch is accepted, I'll modify alsa-plugins to inlcude a
pulseaudio.conf file in /usr/share/alsa/alsa.conf.d/ which defines
a pcm.pulse anc ctl.pulse. If distros want to default to PA, they should
include their own file in there that defines pcm|ctl.!default appropriately.

Similar configuration could be added for third party alsa plugins such as
the DTS encoder plugin being developed by Alexander Patrikov which are
shipped outside of alsa.

I don't think there is anything too controversial in here, so hopefully it'll
be accepted.

Cheers

Col
