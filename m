From: David Henningsson <david.henningsson@canonical.com>
Subject: Questions about the alsa-driver-unstable tarballs
Date: Mon, 15 Aug 2011 09:54:56 +0200
Message-ID: <4E48D0D0.7020009@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 9D58F24514
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 09:55:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

1) there seems to be a build failure with current 
alsa-driver-unstable-snapshot [1] :

...as alsa-kernel/soc/Makefile references a mxs/ directory, but this 
directory is not present in the soc/ directory.

2) it seems like the .bz2 version of alsa-driver-snapshot has 
disappeared, is this intentional?

3) Could you explain the difference between alsa-driver-snapshot and 
alsa-driver-unstable-snapshot, and how the alsa-kernel.git, 
alsa-driver.git and sound-2.6.git come together to form the two 
different tarballs?

Thanks!

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] 
http://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/alsa-driver-unstable-snapshot.tar.bz2
