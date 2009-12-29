From: David Mohr <damailings@mcbf.net>
Subject: Front jack not working with hda-intel driver SigmaTel
	STAC9271D codec
Date: Tue, 29 Dec 2009 16:57:12 +0100
Message-ID: <472d4b250912290757r68b6d421id289314d1cb1ea9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f185.google.com (mail-px0-f185.google.com
	[209.85.216.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 07DA724435
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 16:57:13 +0100 (CET)
Received: by pxi15 with SMTP id 15so7949393pxi.23
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 07:57:13 -0800 (PST)
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
I'm running ubuntu 9.10. I had to force model=5stack to get any audio
output at all. While the jack in the back now works, I still don't get
any sound on the front jack. I haven't found any options in alsamixer,
and switching the output mode in pavucontrol to the headphones just
makes the sound disappear from the back jack, but I still get nothing
in the front.

I uploaded my alsa-info.sh output here:
http://www.alsa-project.org/db/?f=3ed2ab9e7732bf08d2bbfbe8adb74bf037d9e618

Can I fix this somehow, or is it a bug?

And of course thanks everyone for the usually great working alsa system.

~David
