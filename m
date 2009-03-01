From: Brandon Ehle <azverkan@yahoo.com>
Subject: Status of the alsa sbxfi driver
Date: Sun, 1 Mar 2009 13:37:27 -0800
Message-ID: <3c5a513f0903011337o5e3b4686ha985c4e73e75e990@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FA1B1037EC
	for <alsa-devel@alsa-project.org>; Sun,  1 Mar 2009 22:37:29 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so1741027rvf.32
	for <alsa-devel@alsa-project.org>; Sun, 01 Mar 2009 13:37:27 -0800 (PST)
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

I merged the topic/sbxfi branch from
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git
into my latest 2.6.29-rc6 build.  I've done a few quick tests and I
have not run into any issues so far (except the driver has an
excessive amount of kprintfs).  Is this the latest version of the
sbxfi driver?

>From following the alsa-devel list and the git tree above, there
doesn't seem to be any changes since Oct 30 or so.  What work needs to
be done to get this driver into a state where it could be pushed to
the main alsa git and eventually to Linus' tree?
