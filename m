From: "Viliam Kubis" <viliam.kubis@gmail.com>
Subject: Fwd: Smart 5.1 function not working on VIA VT1708S
 with *three* jacks on mainboard
Date: Wed, 07 Jul 2010 00:19:32 +0200
Message-ID: <op.vff0au0jy9cctd@localhost>
References: <op.ve4vig0ny9cctd@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0ABF9246E7
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 00:19:35 +0200 (CEST)
Received: by bwz4 with SMTP id 4so4028051bwz.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Jul 2010 15:19:34 -0700 (PDT)
In-Reply-To: <op.ve4vig0ny9cctd@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Please at least reply, or guide me through the process to fix this bug!

------- Forwarded message -------
From: "Viliam Kubis" <viliam.kubis@gmail.com>
To: alsa-devel@alsa-project.org
Cc: lydiawang@viatech.com.cn, loganli@viatech.com.cn, tiwai@suse.de
Subject: Smart 5.1 function not working on VIA VT1708S with *three* jacks  
on mainboard
Date: Thu, 01 Jul 2010 00:02:30 +0200

Hello, for quite some time the "Smart 5.1" function in alsa is not working
properly when motherboard has only 3 audio jacks.

Me and Raymond on alsa-bugtracker have been trying to solve the issue for
a long time but were unsuccessful.

Please take a look at this alsa bug ticket:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4895

It contains A LOT of info on the problem + steps that we tried, which
included patching the code.

Synthom : NO "Surround" , "Center" and "LFE" Control and switch with
VT1708S on a motherboard with 3 audio jacks
Also NO surround sound.

speaker-test -c 4 -t wav -Dsurround40

Channels count (4) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument

Please advise if you can.

Thank you
Best Regards
Viliam Kubis


-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
