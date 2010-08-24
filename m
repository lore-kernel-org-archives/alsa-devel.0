From: pl bossart <bossart.nospam@gmail.com>
Subject: Loopback device conf/alias
Date: Tue, 24 Aug 2010 17:29:27 -0500
Message-ID: <AANLkTimpA7QjU0w+EO0Ky_k-zZpB4Y4h2hGHu7mZn=bL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7332A24518
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 00:29:30 +0200 (CEST)
Received: by iwn4 with SMTP id 4so5311077iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 15:29:27 -0700 (PDT)
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

I played with the snd_aloop module that Jaroslav added a couple of
days ago. It just does what I wanted and seems to work ok :-) Thanks
for this patch!

I would like however to expose this output as a PulseAudio profile.
Using a string such as hw:%f conflicts with other analog output
profiles, and the actual card index will vary depending on each
hardware setup.
Is there a way to have an alias or a configuration so that I could use
a profile definition as aloop:%f in PulseAudio, and use arecord
-Daloop for my monitoring app. By default the playback device would be
0 and the capture one 1. As long as the card index is handle
automatically I am happy.

I tried to play with alsa-lib .conf files, no luck (I really have no
idea how this works). Any ideas on how to add an alias?
Thanks for your feedback
-Pierre
