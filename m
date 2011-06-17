From: Tom Horsley <horsley1953@gmail.com>
Subject: Can I get audio via HDMI with radeon mobility HD 5400?
Date: Fri, 17 Jun 2011 08:14:27 -0400
Message-ID: <20110617081427.6c49e824@tomh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id AC664244D8
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 14:14:31 +0200 (CEST)
Received: by ywm39 with SMTP id 39so1031769ywm.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2011 05:14:31 -0700 (PDT)
Received: from tomh (localhost [127.0.0.1]) (Authenticated sender: tom)
	by zooty.my.lan (Postfix) with ESMTPA id E7DB14E40C8
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2011 08:14:28 -0400 (EDT)
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

If I install the binary ATI catalyst driver, I can get audio
out the HDMI connection, and alsa-info says it is using
the snd-hda-intel driver.

If I use the open source radeon driver, I cannot get audio
out the HDMI connection, yet alsa-info says it is using the
same snd-hda-intel driver.

Does anyone know how to persuade snd-hda-intel to work
with the open source radeon driver? (Because the video
quality is about 1000% better with the open source driver).

With binary catalyst driver, I see this from alsa-info:
http://home.comcast.net/~tomhorsley/hardware/zino/catalyst-alsa-info.txt

With open source radeon driver, I see this:
http://home.comcast.net/~tomhorsley/hardware/zino/radeon-alsa-info.txt
