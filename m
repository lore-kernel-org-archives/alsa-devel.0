From: K900 <k0009000@gmail.com>
Subject: Some more on MSI GX740 and HDA Intel (bug 5321)
Date: Mon, 1 Aug 2011 13:30:11 +0400
Message-ID: <CAK0ehjGomrjD458tjXZ9qZPq1cgzAc-gi3+Jnc6uXuz1wiz7tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) by alsa0.perex.cz (Postfix) with ESMTP id BB61C244E3
	for <Alsa-devel@alsa-project.org>;
	Mon,  1 Aug 2011 11:30:14 +0200 (CEST)
Received: by yib2 with SMTP id 2so3549306yib.38
	for <Alsa-devel@alsa-project.org>; Mon, 01 Aug 2011 02:30:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry for disappearing last time, I've been quite busy at the time.
But I managed to find a bit more on my laptop's sound card and how to
make it work. I've found two nodes that actually produce (some) sound
when connected to a mixer. 0x1b pin complex is connected to front
speakers and 0x16 to the center/LFE thingy. However, I can only get
sound from them when I connect them to 0x0c and 0x0e mixers, that both
(why?) output the sound from front channels. So, there's no mixer that
outputs rear or LFE channels. To be honest, I don't understand
anything further than this, so can someone please help me :) I'll try
to be around on IRC most of the time. Also, my JID is k900@neko.im.

// Note: it seems my last mail was lost somewhere. Correct me if I'm wrong.
