From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: 2.6.31.x vs. rme vs. alsa 1.0.22?
Date: Tue, 16 Feb 2010 17:58:02 -0800
Message-ID: <1266371882.3361.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.stanford.edu (smtp3.Stanford.EDU [171.67.219.83])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B955103839
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 02:58:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: The Linux Audio Developers' Mailing List <linux-audio-dev@lists.linuxaudio.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey, has anyone been seeing strange behavior from this combination?

  kernel 2.6.31.x rt20 + alsa 1.0.22 userland
  RME card (pcmcia card + multiface)

hdspmixer is not doing the right thing (does not initialize the card in
a way in which playback works), it does not see the hwdep interface (or
something like that) and disables metering, alsamixer even segfaults
when I reach the end of the controls listed. Plain weird. Smells like
something changed deep in the kernel that makes alsa-lib very unhappy.
Alsa-tools rebuilt from source does not make a difference. 

Weirdness goes away when I boot into 2.6.29.6 rt23...

Is there anything in alsa-* that depends on which _kernel_ is available
at compile time?

-- Fernando
