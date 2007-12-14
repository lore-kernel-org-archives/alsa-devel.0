From: "Natalie Protasevich" <protasnb@gmail.com>
Subject: [BUG] Kernel Bugzilla: ALSA bugs
Date: Thu, 13 Dec 2007 21:24:51 -0800
Message-ID: <32209efe0712132124v6c00c794t3267c389155e4fc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id E650E24378
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 06:24:52 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so720888nfd.32
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 21:24:52 -0800 (PST)
Content-Disposition: inline
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

Hello,

There are couple of open ALSA bus on bugzilla.kernel.org, seems like
they weren't noticed yet.
Can someone take look at those please.
Thanks!


hp_only quirk needed for lifebook p7010
http://bugzilla.kernel.org/show_bug.cgi?id=9100
Kernel: 2.6.22.X
on lifebook p7010 I need to add options snd-intel8x0 ac97_quirk=hp_only
to have the master volume work properly

snd-au8830 has strange I/O problems
http://bugzilla.kernel.org/show_bug.cgi?id=9367
Kernel:2.6.22
jack only works in 'playback' mode, none 'duplex' or 'capture' works.


snd_hda_intel doesn't mute front speakers when headset is plugged in
http://bugzilla.kernel.org/show_bug.cgi?id=9338
Kernel: 2.6.23+
Vaio VGN-FZ19VN
